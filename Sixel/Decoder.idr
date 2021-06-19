module Sixel.Decoder

import System.FFI

import Sixel.Library
import Sixel.Symbols
import Sixel.Allocator

public export
PrimDecoder : Type
PrimDecoder = GCAnyPtr

export
data Decoder : (0 n : Nat) -> Type where
  PointDecoder : PrimDecoder -> Decoder Z
  RootDecoder  : Decoder n -> Decoder (S n)

%foreign (sixelutils "sixel_utils_decoder_ptr_new")
sixel_utils_decoder_ptr_new : PrimIO (Ptr AnyPtr)

%foreign (sixelutils "sixel_utils_decoder_ptr_deref")
sixel_utils_decoder_ptr_deref : Ptr AnyPtr -> AnyPtr

%foreign (sixel "sixel_decoder_new")
sixel_decoder_new : Ptr AnyPtr -> PrimAllocator -> PrimIO Int

%foreign (sixel "sixel_decoder_ref")
sixel_decoder_ref : PrimDecoder -> ()

%foreign (sixel "sixel_decoder_unref")
sixel_decoder_unref : PrimDecoder -> ()

%foreign (sixel "sixel_decoder_unref")
sixel_decoder_destroy : AnyPtr -> PrimIO ()

%foreign (sixel "sixel_decoder_setopt")
sixel_decoder_setopt : PrimDecoder -> (optflag : Int) -> (setting : String) -> PrimIO Int

%foreign (sixel "sixel_decoder_decode")
sixel_decoder_decode : PrimDecoder -> PrimIO Int

export
MkDecoder : {auto n : Nat} -> {default (getNullAllocator n) alloc : Allocator n} -> IO (Either Status (Decoder Z))
MkDecoder {alloc} = do
  ppdecoder <- fromPrim sixel_utils_decoder_ptr_new
  status    <- MkStatus <$> fromPrim (sixel_decoder_new ppdecoder (toPrim alloc))
  pdecoder  <- onCollectAny (sixel_utils_decoder_ptr_deref ppdecoder) (\pd => fromPrim $ sixel_decoder_destroy pd)
  pure $ if succeeded status then Right (PointDecoder pdecoder) else Left status

export
ref : Decoder n -> IO (Decoder (S n))
ref (RootDecoder decoder)           = RootDecoder <$> ref decoder
ref decoder@(PointDecoder pdecoder) = let _ = sixel_decoder_ref pdecoder in pure $ RootDecoder decoder

export
unref : Decoder (S n) -> IO (Decoder n)
unref (RootDecoder decoder@(RootDecoder _))         = RootDecoder <$> unref decoder
unref (RootDecoder decoder@(PointDecoder pdecoder)) = let _ = sixel_decoder_unref pdecoder in pure decoder

export
refs : Decoder n -> Nat
refs (RootDecoder decoder) = S (refs decoder)
refs (PointDecoder _)      = Z

export
toPrim : Decoder n -> PrimDecoder
toPrim (RootDecoder decoder)   = toPrim decoder
toPrim (PointDecoder pdecoder) = pdecoder

export
setOpt : Decoder n -> (optflag : OptFlag) -> (setting : String) -> IO (Either Status ())
setOpt decoder optflag setting = do
  status <- MkStatus <$> fromPrim (sixel_decoder_setopt (toPrim decoder) (binding optflag) setting)
  pure $ if succeeded status then Right () else Left status

export
decode : Decoder n -> IO (Either Status ())
decode decoder = do
  status <- MkStatus <$> fromPrim (sixel_decoder_decode (toPrim decoder))
  pure $ if succeeded status then Right () else Left status
