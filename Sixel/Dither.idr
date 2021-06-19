module Sixel.Dither

import Data.Buffer
import System.FFI

import Sixel.Library
import Sixel.Symbols
import Sixel.Allocator

public export
PrimDither : Type
PrimDither = GCAnyPtr

export
data Dither : (0 n : Nat) -> Type where
  PointDither : PrimDither -> Dither Z
  RootDither  : Dither n -> Dither (S n)

%foreign (sixelutils "sixel_utils_dither_ptr_new")
sixel_utils_dither_ptr_new :  PrimIO (Ptr AnyPtr)

%foreign (sixelutils "sixel_utils_dither_ptr_deref")
sixel_utils_dither_ptr_deref : Ptr AnyPtr -> AnyPtr

%foreign (sixel "sixel_dither_new")
sixel_dither_new : Ptr AnyPtr -> (ncolors : Int) -> PrimAllocator -> PrimIO Int

%foreign (sixel "sixel_dither_get")
sixel_dither_get : (builtin : Int) -> PrimIO AnyPtr

%foreign (sixel "sixel_dither_ref")
sixel_dither_ref : PrimDither -> ()

%foreign (sixel "sixel_dither_unref")
sixel_dither_unref : PrimDither -> ()

%foreign (sixel "sixel_dither_unref")
sixel_dither_destroy : AnyPtr -> PrimIO ()

%foreign (sixel "sixel_dither_initialize")
sixel_dither_initialize :
  PrimDither -> (pixels : Buffer) -> (w : Int) -> (h : Int) ->
    (pixelFormat : Int) -> (large : Int) -> (rep : Int) -> (quality : Int) ->
    PrimIO Int

%foreign (sixel "sixel_dither_set_diffusion_type")
sixel_dither_set_diffusion_type : PrimDither -> (diffuse : Int) -> ()

%foreign (sixel "sixel_dither_get_num_of_palette_colors")
sixel_dither_get_num_of_palette_colors : PrimDither -> Int

%foreign (sixel "sixel_dither_get_num_of_histogram_colors")
sixel_dither_get_num_of_histogram_colors : PrimDither -> Int

%foreign (sixel "sixel_dither_get_palette")
sixel_dither_get_palette : PrimDither -> String

%foreign (sixel "sixel_dither_set_palette")
sixel_dither_set_palette : PrimDither -> (palette : String) -> ()

%foreign (sixel "sixel_dither_set_complexion_score")
sixel_dither_set_complexion_score : PrimDither -> (score : Int) -> ()

%foreign (sixel "sixel_dither_set_body_only")
sixel_dither_set_body_only : PrimDither -> (setting : Int) -> ()

%foreign (sixel "sixel_dither_set_optimize_palette")
sixel_dither_set_optimize_palette : PrimDither -> (setting : Int) -> ()

%foreign (sixel "sixel_dither_set_pixelformat")
sixel_dither_set_pixelformat : PrimDither -> (pixelFormat : Int) -> ()

%foreign (sixel "sixel_dither_set_transparent")
sixel_dither_set_transparent : PrimDither -> (index : Int) -> ()

export
MkDither : {auto n : Nat} ->
  {default (-1) ncolors : Int} ->
  {default (getNullAllocator n) alloc : Allocator n} ->
  IO (Either Status (Dither Z))
MkDither {ncolors} {alloc} = do
  ppdither <- fromPrim sixel_utils_dither_ptr_new
  status   <- MkStatus <$> fromPrim (sixel_dither_new ppdither ncolors (toPrim alloc))
  pdither  <- onCollectAny (sixel_utils_dither_ptr_deref ppdither) (\pd => fromPrim $ sixel_dither_destroy pd)
  pure $ if succeeded status then Right (PointDither pdither) else Left status

export
getDither : BuiltinDither -> IO (Maybe (Dither Z))
getDither builtin = do
  ptr     <- fromPrim $ sixel_dither_get $ binding builtin
  pdither <- onCollectAny ptr (\pd => fromPrim $ sixel_dither_destroy pd)
  pure $ if prim__isConcreteAny ptr
            then Just (PointDither pdither)
            else Nothing

export
ref : Dither n -> IO (Dither (S n))
ref (RootDither dither)          = RootDither <$> ref dither
ref dither@(PointDither pdither) = let _ = sixel_dither_ref pdither in pure $ RootDither dither

export
unref : Dither (S n) -> IO (Dither n)
unref (RootDither dither@(RootDither _))        = RootDither <$> unref dither
unref (RootDither dither@(PointDither pdither)) = let _ = sixel_dither_unref pdither in pure dither

export
refs : Dither n -> Nat
refs (RootDither dither) = S (refs dither)
refs (PointDither _)     = Z

export
toPrim : Dither n -> PrimDither
toPrim (RootDither dither)   = toPrim dither
toPrim (PointDither pdither) = pdither

export
initialize :
  Dither n -> (image : Buffer) -> (w : Int) -> (h : Int) ->
    PixelFormat -> MethodForLargest -> MethodForRep -> QualityMode ->
    IO (Either Status ())
initialize dither pixels w h pixelformat large rep quality = let pdither = toPrim dither in do
  status <- MkStatus <$> fromPrim (sixel_dither_initialize
    (toPrim dither) pixels w h (binding pixelformat) (binding large) (binding rep) (binding quality))
  pure $ if succeeded status then Right () else Left status

export %inline
setDiffusionType : Dither n -> MethodForDiffuse -> IO ()
setDiffusionType dither methodForDiffuse =
  pure $ sixel_dither_set_diffusion_type (toPrim dither) (binding methodForDiffuse)

export %inline
getNumOfPaletteColors : Dither n -> IO Int
getNumOfPaletteColors dither = pure $ sixel_dither_get_num_of_palette_colors (toPrim dither)

export %inline
getNumOfHistogramColors : Dither n -> IO Int 
getNumOfHistogramColors dither = pure $ sixel_dither_get_num_of_histogram_colors (toPrim dither)

export %inline
setComplexionScore : Dither n -> (score : Int) -> IO ()
setComplexionScore dither score = pure $ sixel_dither_set_complexion_score (toPrim dither) score

export %inline
setBodyOnly : Dither n -> (setting : Bool) -> IO ()
setBodyOnly dither setting = pure $ sixel_dither_set_body_only (toPrim dither) (ifThenElse setting 1 0)

export %inline
setOptimizePalette : Dither n -> (setting : Bool) -> IO ()
setOptimizePalette dither setting = pure $ sixel_dither_set_optimize_palette (toPrim dither) (ifThenElse setting 1 0)

export %inline
setPixelFormat : Dither n -> PixelFormat -> IO ()
setPixelFormat dither pixelformat = pure $ sixel_dither_set_pixelformat (toPrim dither) (binding pixelformat)

export %inline
setTransparent : Dither n -> (index : Int) -> IO ()
setTransparent dither setting = pure $ sixel_dither_set_transparent (toPrim dither) setting
