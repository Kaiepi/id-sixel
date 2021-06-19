module Sixel.Output

import System.FFI

import Sixel.Library
import Sixel.Symbols
import Sixel.Allocator

%default total

public export
PrimOutput : Type
PrimOutput = GCAnyPtr

public export
WriteFn : Type
WriteFn = (toWrite : AnyPtr) -> (size : Int) -> (priv : AnyPtr) -> PrimIO Int

MkOutputRes : Type
MkOutputRes = Struct "sixel_utils_output_t" [("output", AnyPtr), ("status", Int)]

export
data Output : (0 n : Nat) -> Type where
  PointOutput : PrimOutput -> Output Z
  RootOutput  : Output n -> Output (S n)

%foreign (sixelutils "sixel_utils_output_ptr_new")
sixel_utils_output_ptr_new : PrimIO (Ptr AnyPtr)

%foreign (sixelutils "sixel_utils_output_ptr_deref")
sixel_utils_output_ptr_deref : Ptr AnyPtr -> AnyPtr

%foreign (sixel "sixel_output_new")
sixel_output_new : Ptr AnyPtr -> WriteFn -> (priv : AnyPtr) -> PrimAllocator -> PrimIO Int

%foreign (sixel "sixel_output_ref")
sixel_output_ref : PrimOutput -> ()

%foreign (sixel "sixel_output_unref")
sixel_output_unref : PrimOutput -> ()

%foreign (sixel "sixel_output_destroy")
sixel_output_destroy : AnyPtr -> PrimIO ()

%foreign (sixel "sixel_output_get_8bit_availability")
sixel_output_get_8bit_availability : PrimOutput -> Int

%foreign (sixel "sixel_output_set_8bit_availability")
sixel_output_set_8bit_availability : PrimOutput -> Int -> ()

%foreign (sixel "sixel_output_set_gri_arg_limit")
sixel_output_set_gri_arg_limit : PrimOutput -> Int -> ()

%foreign (sixel "sixel_output_set_penetrate_multiplexer")
sixel_output_set_penetrate_multiplexer : PrimOutput -> Int -> ()

%foreign (sixel "sixel_output_set_skip_dcs_envelope")
sixel_output_set_skip_dcs_envelope : PrimOutput -> Int -> ()

%foreign (sixel "sixel_output_set_palette_type")
sixel_output_set_palette_type : PrimOutput -> Int -> ()

%foreign (sixel "sixel_output_set_encode_policy")
sixel_output_set_encode_policy : PrimOutput -> Int -> ()

export
MkOutput : {auto n : Nat} -> 
  WriteFn ->
  {default prim__getNullAnyPtr priv : AnyPtr} ->
  {default (getNullAllocator n) alloc : Allocator n} ->
  IO (Either Status (Output Z))
MkOutput writefn {priv} {alloc} = do
  ppoutput <- fromPrim sixel_utils_output_ptr_new
  status   <- MkStatus <$> fromPrim (sixel_output_new ppoutput writefn priv (toPrim alloc))
  poutput  <- onCollectAny (sixel_utils_output_ptr_deref ppoutput) (\po => fromPrim $ sixel_output_destroy po)
  pure $ if succeeded status then Right (PointOutput poutput) else Left status

export
ref : Output n -> IO (Output (S n))
ref (RootOutput output)          = RootOutput <$> ref output
ref output@(PointOutput poutput) = let _ = sixel_output_ref poutput in pure $ RootOutput output

export
unref : Output (S n) -> IO (Output n)
unref (RootOutput output@(RootOutput _))        = RootOutput <$> unref output
unref (RootOutput output@(PointOutput poutput)) = let _ = sixel_output_unref poutput in pure output

export
refs : Output n -> Nat
refs (RootOutput output) = S (refs output)
refs (PointOutput _)     = Z

export
toPrim : Output n -> PrimOutput
toPrim (RootOutput output)   = toPrim output
toPrim (PointOutput poutput) = poutput

export %inline
get8BitAvailability : Output n -> IO Bool
get8BitAvailability output =
  pure $ intToBool $ sixel_output_get_8bit_availability $ toPrim output

export %inline
set8BitAvailability : Output n -> (setting : Bool) -> IO ()
set8BitAvailability output setting =
  pure $ sixel_output_set_8bit_availability (toPrim output) (ifThenElse setting 1 0)

export %inline
setGriArgLimit : Output n -> (setting : Bool) -> IO ()
setGriArgLimit output setting =
  pure $ sixel_output_set_gri_arg_limit (toPrim output) (ifThenElse setting 1 0)

export %inline
setPenetrateMultiplexer : Output n -> (setting : Bool) -> IO ()
setPenetrateMultiplexer output setting =
  pure $ sixel_output_set_penetrate_multiplexer (toPrim output) (ifThenElse setting 1 0)

export %inline
setSkipDcsEnvelope : Output n -> (setting : Bool) -> IO ()
setSkipDcsEnvelope output setting =
  pure $ sixel_output_set_skip_dcs_envelope (toPrim output) (ifThenElse setting 1 0)

export %inline
setPaletteType : Output n -> PaletteType -> IO ()
setPaletteType output type =
  pure $ sixel_output_set_palette_type (toPrim output) (binding type)

export %inline
setEncodePolicy : Output n -> EncodePolicy -> IO ()
setEncodePolicy output policy =
  pure $ sixel_output_set_encode_policy (toPrim output) (binding policy)
