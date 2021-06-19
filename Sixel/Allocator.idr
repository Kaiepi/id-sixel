module Sixel.Allocator

import System.FFI

import Sixel.Library
import Sixel.Symbols

%default total

public export
MAlloc : Type
MAlloc = (size : Int) -> PrimIO AnyPtr

public export
CAlloc : Type
CAlloc = (elems : Int) -> (size : Int) -> PrimIO AnyPtr

public export
ReAlloc : Type
ReAlloc = (ptr : AnyPtr) -> (size : Int) -> PrimIO AnyPtr

public export
Free : Type
Free = (ptr : AnyPtr) -> PrimIO ()

public export
PrimAllocator : Type
PrimAllocator = AnyPtr

%foreign (sixelutils "sixel_utils_allocator_null")
sixel_utils_allocator_null : PrimAllocator

%foreign (sixelutils "sixel_utils_allocator_ptr_new")
sixel_utils_allocator_ptr_new : PrimIO (Ptr AnyPtr)

%foreign (sixelutils "sixel_utils_allocator_ptr_deref")
sixel_utils_allocator_ptr_deref : Ptr AnyPtr -> AnyPtr

%foreign (c "malloc")
c_malloc : (size : Int) -> PrimIO AnyPtr

%foreign (c "calloc")
c_calloc : (elems : Int) -> (size : Int) -> PrimIO AnyPtr

%foreign (c "realloc")
c_realloc : (ptr : AnyPtr) -> (elems : Int) -> PrimIO AnyPtr

%foreign (c "free")
c_free : (ptr : AnyPtr) -> PrimIO ()

%foreign (sixel "sixel_allocator_new")
sixel_allocator_new : Ptr AnyPtr -> MAlloc -> CAlloc -> ReAlloc -> Free -> PrimIO Int

%foreign (sixel "sixel_allocator_unref")
sixel_allocator_destroy : AnyPtr -> PrimIO ()

%foreign (sixel "sixel_allocator_ref")
sixel_allocator_ref : PrimAllocator -> ()

%foreign (sixel "sixel_allocator_unref")
sixel_allocator_unref : PrimAllocator -> ()

%foreign (sixel "sixel_allocator_free")
sixel_allocator_free : PrimAllocator -> (ptr : AnyPtr) -> PrimIO ()

%foreign (sixel "sixel_allocator_malloc")
sixel_allocator_malloc : PrimAllocator -> (size : Int) -> PrimIO AnyPtr

%foreign (sixel "sixel_allocator_calloc")
sixel_allocator_calloc : PrimAllocator -> (elems : Int) -> (size : Int) -> PrimIO AnyPtr

%foreign (sixel "sixel_allocator_realloc")
sixel_allocator_realloc : PrimAllocator -> (ptr : AnyPtr) -> (size : Int) -> PrimIO AnyPtr

export
data Allocator : (0 n : Nat) -> Type where
  NullAllocator  : Allocator n -- for the sake of serving as a default
  PointAllocator : PrimAllocator -> Allocator Z
  RootAllocator  : Allocator n -> Allocator (S n)

public export
ConcreteAllocator : Allocator n -> Type
ConcreteAllocator NullAllocator         = Void
ConcreteAllocator (PointAllocator _)    = ()
ConcreteAllocator (RootAllocator alloc) = ConcreteAllocator alloc

public export
getNullAllocator : (n : Nat) -> Allocator n
getNullAllocator _ = NullAllocator

export
MkAllocator :
  {default c_malloc malloc : MAlloc} ->    -- NULL => malloc
  {default c_calloc calloc : CAlloc} ->    -- NULL => calloc
  {default c_realloc realloc : ReAlloc} -> -- NULL => realloc
  {default c_free free : Free} ->          -- NULL => free
  IO (Either Status (Allocator Z))
MkAllocator {malloc} {calloc} {realloc} {free} = do
  ppalloc <- fromPrim sixel_utils_allocator_ptr_new
  status  <- MkStatus <$> fromPrim (sixel_allocator_new ppalloc malloc calloc realloc free)
  pure $ if succeeded status
            then Right (PointAllocator $ sixel_utils_allocator_ptr_deref ppalloc)
            else Left status

export
ref : (alloc : Allocator n) -> {auto 0 ok : ConcreteAllocator alloc} -> IO (Allocator (S n))
ref (RootAllocator alloc)         = RootAllocator <$> ref alloc
ref alloc@(PointAllocator palloc) = let _ = sixel_allocator_ref palloc in pure $ RootAllocator alloc

export
unref : (alloc : Allocator (S n)) -> {auto 0 ok : ConcreteAllocator alloc} -> IO (Allocator n)
unref (RootAllocator alloc@(RootAllocator _))       = RootAllocator <$> unref alloc
unref (RootAllocator alloc@(PointAllocator palloc)) = let _ = sixel_allocator_unref palloc in pure alloc

export
destroy : (alloc : Allocator Z) -> {auto 0 ok : ConcreteAllocator alloc} -> IO ()
destroy (PointAllocator palloc) = fromPrim $ sixel_allocator_destroy palloc

export
toPrim : Allocator n -> PrimAllocator
toPrim NullAllocator           = sixel_utils_allocator_null
toPrim (PointAllocator palloc) = palloc
toPrim (RootAllocator alloc)   = toPrim alloc

export %inline
malloc : ConcreteAllocator alloc => (alloc : Allocator n) -> (size : Int) -> IO AnyPtr
malloc alloc size = fromPrim $ sixel_allocator_malloc (toPrim alloc) size

export %inline
calloc : ConcreteAllocator alloc => (alloc : Allocator n) -> (elems : Int) -> (size : Int) -> IO AnyPtr
calloc alloc elems size = fromPrim $ sixel_allocator_calloc (toPrim alloc) elems size

export %inline
realloc : ConcreteAllocator alloc => (alloc : Allocator n) -> (ptr : AnyPtr) -> (size : Int) -> IO AnyPtr
realloc alloc ptr size = fromPrim $ sixel_allocator_realloc (toPrim alloc) ptr size

export %inline
free : ConcreteAllocator alloc => (alloc : Allocator n) -> (ptr : AnyPtr) -> IO ()
free alloc ptr = fromPrim $ sixel_allocator_free (toPrim alloc) ptr
