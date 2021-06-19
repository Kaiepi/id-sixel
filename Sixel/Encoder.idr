module Sixel.Encoder

import Data.Buffer
import System.FFI

import Sixel.Library
import Sixel.Symbols
import Sixel.Allocator

public export
PrimEncoder : Type
PrimEncoder = GCAnyPtr

export
data Encoder : (0 n : Nat) -> Type where
  PointEncoder : PrimEncoder -> Encoder Z
  RootEncoder  : Encoder n -> Encoder (S n)

%foreign (sixelutils "sixel_utils_int_ptr_new")
sixel_utils_int_ptr_new : Int -> PrimIO (Ptr Int)

%foreign (sixelutils "sixel_utils_encoder_ptr_new")
sixel_utils_encoder_ptr_new : PrimIO (Ptr AnyPtr)

%foreign (sixelutils "sixel_utils_encoder_ptr_deref")
sixel_utils_encoder_ptr_deref : Ptr AnyPtr -> AnyPtr

%foreign (sixel "sixel_encoder_new")
sixel_encoder_new : Ptr AnyPtr -> PrimAllocator -> PrimIO Int

%foreign (sixel "sixel_encoder_ref")
sixel_encoder_ref : PrimEncoder -> ()

%foreign (sixel "sixel_encoder_unref")
sixel_encoder_unref : PrimEncoder -> ()

%foreign (sixel "sixel_encoder_unref")
sixel_encoder_destroy : AnyPtr -> PrimIO ()

%foreign (sixel "sixel_encoder_set_cancel_flag")
sixel_encoder_set_cancel_flag : PrimEncoder -> Ptr Int -> ()

%foreign (sixel "sixel_encoder_setopt")
sixel_encoder_setopt : PrimEncoder -> (optflag : Int) -> (setting : String) -> PrimIO Int

%foreign (sixel "sixel_encoder_encode")
sixel_encoder_encode : PrimEncoder -> (filename : String) -> PrimIO Int

%foreign (sixel "sixel_encoder_encode_bytes")
sixel_encoder_encode_bytes :
  PrimEncoder -> (bytes : Buffer) -> (w : Int) -> (h : Int) ->
    (pixelformat : Int) -> (palette : Buffer) -> (ncolors : Int) ->
    PrimIO Int

export
MkEncoder : {auto n : Nat} -> {default (getNullAllocator n) alloc : Allocator n} -> IO (Either Status (Encoder Z))
MkEncoder {alloc} = do
  ppencoder <- fromPrim sixel_utils_encoder_ptr_new
  status    <- MkStatus <$> fromPrim (sixel_encoder_new ppencoder (toPrim alloc))
  pencoder  <- onCollectAny (sixel_utils_encoder_ptr_deref ppencoder) (\pe => fromPrim $ sixel_encoder_destroy pe)
  pure $ if succeeded status then Right (PointEncoder pencoder) else Left status

export
ref : Encoder n -> IO (Encoder (S n))
ref (RootEncoder encoder)           = RootEncoder <$> ref encoder
ref encoder@(PointEncoder pencoder) = let _ = sixel_encoder_ref pencoder in pure $ RootEncoder encoder

export
unref : Encoder (S n) -> IO (Encoder n)
unref (RootEncoder encoder@(RootEncoder _))         = RootEncoder <$> unref encoder
unref (RootEncoder encoder@(PointEncoder pencoder)) = let _ = sixel_encoder_unref pencoder in pure encoder

export
refs : Encoder n -> Nat
refs (RootEncoder encoder) = S (refs encoder)
refs (PointEncoder _)      = Z

export
toPrim : Encoder n -> PrimEncoder
toPrim (RootEncoder encoder)   = toPrim encoder
toPrim (PointEncoder pencoder) = pencoder

export
setCancelFlag : Encoder n -> (setting : Bool) -> IO ()
setCancelFlag encoder setting = do
  cancelFlag <- fromPrim $ sixel_utils_int_ptr_new $ ifThenElse setting 1 0
  pure $ sixel_encoder_set_cancel_flag (toPrim encoder) cancelFlag

export
setOpt : Encoder n -> (optflag : OptFlag) -> (setting : String) -> IO (Either Status ())
setOpt encoder optflag setting = do
  status <- MkStatus <$> fromPrim (sixel_encoder_setopt (toPrim encoder) (binding optflag) setting)
  pure $ if succeeded status then Right () else Left status

export
encode : Encoder n -> (filename : String) -> IO (Either Status ())
encode encoder filename = do
  status <- MkStatus <$> fromPrim (sixel_encoder_encode (toPrim encoder) filename)
  pure $ if succeeded status then Right () else Left status

export
encodeBytes :
  Encoder n -> (bytes : Buffer) -> (w : Int) -> (h : Int) ->
    (pixelformat : PixelFormat) -> (palette : Buffer) -> (ncolors : Int) ->
    IO (Either Status ())
encodeBytes encoder bytes w h pixelformat palette ncolors = do
  status <- MkStatus <$> fromPrim (sixel_encoder_encode_bytes
    (toPrim encoder) bytes w h (binding pixelformat) palette ncolors)
  pure $ if succeeded status then Right () else Left status
