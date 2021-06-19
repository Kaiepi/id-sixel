module Sixel

import public Data.Buffer

import Sixel.Library
import public Sixel.Symbols
import public Sixel.Allocator
import public Sixel.Output
import public Sixel.Dither
import public Sixel.Encoder
import public Sixel.Decoder
import public Sixel.Helpers

%foreign (sixel "sixel_encode")
sixel_encode :
  (pixels : Buffer) -> (w : Int) -> (h : Int) -> (depth : Int) -> PrimDither -> PrimOutput ->
  PrimIO Int

export
encode :
  (pixels : Buffer) -> (w : Int) -> (h : Int) -> (depth : Int) -> Dither n -> Output m ->
  IO (Either Status ())
encode pixels w h depth dither output = do
  status <- MkStatus <$> fromPrim (sixel_encode pixels w h depth (toPrim dither) (toPrim output))
  pure $ if succeeded status then Right () else Left status
