module Sixel.Symbols

import Sixel.Library

export
interface Show t => Symbolic t s | s where
  hint     : s -> String
  binding  : s -> t
  symbol   : s -> String
  symbolBy : (t -> AnyPtr) -> s -> String

  symbolBy f symbol =
    let val = binding symbol
        ptr = f val
        in if prim__isConcreteAny ptr
              then prim__toStringAny ptr
              else hint symbol ++ " " ++ show val

--

public export
data Status = MkStatus Int

namespace Status
  %foreign (sixelutils "sixel_utils_succeeded")
  sixel_utils_succeeded : Int -> Int

  export %inline
  succeeded : Status -> Bool
  succeeded (MkStatus s) = intToBool (sixel_utils_succeeded s)

  --

  %foreign (sixelutils "sixel_utils_failed")
  sixel_utils_failed : Int -> Int

  export %inline
  failed : Status -> Bool
  failed (MkStatus s) = intToBool (sixel_utils_failed s)

  --

  %foreign (sixelutils "sixel_utils_status_symbol")
  sixel_utils_status_symbol : Int -> AnyPtr

  export
  Symbolic Int Status where
    hint _               = "Status"
    binding (MkStatus b) = b
    symbol               = symbolBy sixel_utils_status_symbol

  export
  Eq Status where
    (==) x y = binding x == binding y

  export
  Show Status where
    show = symbol

  --

  %foreign (sixelutils "sixel_utils_ok")
  sixel_utils_ok : Int

  export %inline
  Ok : Status
  Ok = MkStatus sixel_utils_ok

  --

  %foreign (sixelutils "sixel_utils_runtime_error")
  sixel_utils_runtime_error : Int

  export %inline
  RuntimeError : Status
  RuntimeError = MkStatus sixel_utils_runtime_error

  --

  %foreign (sixelutils "sixel_utils_logic_error")
  sixel_utils_logic_error : Int

  export %inline
  LogicError : Status
  LogicError = MkStatus sixel_utils_logic_error

  --

  %foreign (sixelutils "sixel_utils_feature_error")
  sixel_utils_feature_error : Int

  export %inline
  FeatureError : Status
  FeatureError = MkStatus sixel_utils_feature_error

  --

  %foreign (sixelutils "sixel_utils_libc_error")
  sixel_utils_libc_error : Int

  export %inline
  LibcError : Status
  LibcError = MkStatus sixel_utils_libc_error

  --

  %foreign (sixelutils "sixel_utils_curl_error")
  sixel_utils_curl_error : Int

  export %inline
  CurlError : Status
  CurlError = MkStatus sixel_utils_curl_error

  --

  %foreign (sixelutils "sixel_utils_jpeg_error")
  sixel_utils_jpeg_error : Int

  export %inline
  JpegError : Status
  JpegError = MkStatus sixel_utils_jpeg_error

  --

  %foreign (sixelutils "sixel_utils_png_error")
  sixel_utils_png_error : Int

  export %inline
  PngError : Status
  PngError = MkStatus sixel_utils_png_error

  --

  %foreign (sixelutils "sixel_utils_gdk_error")
  sixel_utils_gdk_error : Int

  export %inline
  GdkError : Status
  GdkError = MkStatus sixel_utils_gdk_error

  --

  %foreign (sixelutils "sixel_utils_gd_error")
  sixel_utils_gd_error : Int

  export %inline
  GdError : Status
  GdError = MkStatus sixel_utils_gd_error

  --

  %foreign (sixelutils "sixel_utils_stbi_error")
  sixel_utils_stbi_error : Int

  export %inline
  StbiError : Status
  StbiError = MkStatus sixel_utils_stbi_error

  --

  %foreign (sixelutils "sixel_utils_stbiw_error")
  sixel_utils_stbiw_error : Int

  export %inline
  StbiwError : Status
  StbiwError = MkStatus sixel_utils_stbiw_error

  --

  %foreign (sixelutils "sixel_utils_interrupted")
  sixel_utils_interrupted : Int

  export %inline
  Interrupted : Status
  Interrupted = MkStatus sixel_utils_interrupted

  --

  %foreign (sixelutils "sixel_utils_bad_allocation")
  sixel_utils_bad_allocation : Int

  export %inline
  BadAllocation : Status
  BadAllocation = MkStatus sixel_utils_bad_allocation

  --

  %foreign (sixelutils "sixel_utils_bad_argument")
  sixel_utils_bad_argument : Int

  export %inline
  BadArgument : Status
  BadArgument = MkStatus sixel_utils_bad_argument

  --

  %foreign (sixelutils "sixel_utils_bad_input")
  sixel_utils_bad_input : Int

  export %inline
  BadInput : Status
  BadInput = MkStatus sixel_utils_bad_input

  --

  %foreign (sixelutils "sixel_utils_bad_integer_overflow")
  sixel_utils_bad_integer_overflow : Int

  export %inline
  BadIntegerOverflow : Status
  BadIntegerOverflow = MkStatus sixel_utils_bad_integer_overflow

  --

  %foreign (sixelutils "sixel_utils_not_implemented")
  sixel_utils_not_implemented : Int

  export %inline
  NotImplemented : Status
  NotImplemented = MkStatus sixel_utils_not_implemented

--

public export
data MethodForLargest = MkMethodForLargest Int

namespace MethodForLargest
  %foreign (sixelutils "sixel_utils_large_symbol")
  sixel_utils_large_symbol : Int -> AnyPtr

  export
  Symbolic Int MethodForLargest where
    hint _                         = "MethodForLargest"
    binding (MkMethodForLargest b) = b
    symbol                         = symbolBy sixel_utils_large_symbol

  export
  Eq MethodForLargest where
    (==) x y = binding x == binding y

  export
  Show MethodForLargest where
    show = symbol

  --

  %foreign (sixelutils "sixel_utils_large_auto")
  sixel_utils_large_auto : Int

  export %inline
  LargeAuto : MethodForLargest
  LargeAuto = MkMethodForLargest sixel_utils_large_auto

  --

  %foreign (sixelutils "sixel_utils_large_norm")
  sixel_utils_large_norm : Int

  export %inline
  LargeNorm : MethodForLargest
  LargeNorm = MkMethodForLargest sixel_utils_large_norm

  --

  %foreign (sixelutils "sixel_utils_large_lum")
  sixel_utils_large_lum : Int

  export %inline
  LargeLum : MethodForLargest
  LargeLum = MkMethodForLargest sixel_utils_large_lum

--

public export
data MethodForRep = MkMethodForRep Int

namespace MethodForRep
  %foreign (sixelutils "sixel_utils_rep_symbol")
  sixel_utils_rep_symbol : Int -> AnyPtr

  export
  Symbolic Int MethodForRep where
    hint _                     = "MethodForRep"
    binding (MkMethodForRep b) = b
    symbol                     = symbolBy sixel_utils_rep_symbol

  export
  Eq MethodForRep where
    (==) x y = binding x == binding y

  export
  Show MethodForRep where
    show = symbol

  --

  %foreign (sixelutils "sixel_utils_rep_auto")
  sixel_utils_rep_auto : Int

  export %inline
  RepAuto : MethodForRep
  RepAuto = MkMethodForRep sixel_utils_rep_auto


  --

  %foreign (sixelutils "sixel_utils_rep_center_box")
  sixel_utils_rep_center_box : Int

  export %inline
  RepCenterBox : MethodForRep
  RepCenterBox = MkMethodForRep sixel_utils_rep_center_box

  --

  %foreign (sixelutils "sixel_utils_rep_average_colors")
  sixel_utils_rep_average_colors : Int

  export %inline
  RepAverageColors : MethodForRep
  RepAverageColors = MkMethodForRep sixel_utils_rep_average_colors

  --

  %foreign (sixelutils "sixel_utils_rep_average_pixels")
  sixel_utils_rep_average_pixels : Int

  export %inline
  RepAveragePixels : MethodForRep
  RepAveragePixels = MkMethodForRep sixel_utils_rep_average_pixels

--

public export
data MethodForDiffuse = MkMethodForDiffuse Int

namespace MethodForDiffuse
  %foreign (sixelutils "sixel_utils_diffuse_symbol")
  sixel_utils_diffuse_symbol : Int -> AnyPtr

  export
  Symbolic Int MethodForDiffuse where
    hint _                         = "MethodForDiffuse"
    binding (MkMethodForDiffuse b) = b
    symbol                         = symbolBy sixel_utils_diffuse_symbol

  export
  Eq MethodForDiffuse where
    (==) x y = binding x == binding y

  export
  Show MethodForDiffuse where
    show = symbol

  --

  %foreign (sixelutils "sixel_utils_diffuse_auto")
  sixel_utils_diffuse_auto : Int

  export %inline
  DiffuseAuto : MethodForDiffuse
  DiffuseAuto = MkMethodForDiffuse sixel_utils_diffuse_auto

  --

  %foreign (sixelutils "sixel_utils_diffuse_none")
  sixel_utils_diffuse_none : Int

  export %inline
  DiffuseNone : MethodForDiffuse
  DiffuseNone = MkMethodForDiffuse sixel_utils_diffuse_none

  --

  %foreign (sixelutils "sixel_utils_diffuse_atkinson")
  sixel_utils_diffuse_atkinson : Int

  export %inline
  DiffuseAtkinson : MethodForDiffuse
  DiffuseAtkinson = MkMethodForDiffuse sixel_utils_diffuse_atkinson

  --

  %foreign (sixelutils "sixel_utils_diffuse_fs")
  sixel_utils_diffuse_fs : Int

  export %inline
  DiffuseFs : MethodForDiffuse
  DiffuseFs = MkMethodForDiffuse sixel_utils_diffuse_fs

  --

  %foreign (sixelutils "sixel_utils_diffuse_jajuni")
  sixel_utils_diffuse_jajuni : Int

  export %inline
  DiffuseJajuni : MethodForDiffuse
  DiffuseJajuni = MkMethodForDiffuse sixel_utils_diffuse_jajuni

  --

  %foreign (sixelutils "sixel_utils_diffuse_stucki")
  sixel_utils_diffuse_stucki : Int

  export %inline
  DiffuseStucki : MethodForDiffuse
  DiffuseStucki = MkMethodForDiffuse sixel_utils_diffuse_stucki

  --

  %foreign (sixelutils "sixel_utils_diffuse_burkes")
  sixel_utils_diffuse_burkes : Int

  export %inline
  DiffuseBurkes : MethodForDiffuse
  DiffuseBurkes = MkMethodForDiffuse sixel_utils_diffuse_burkes

  --

  %foreign (sixelutils "sixel_utils_diffuse_a_dither")
  sixel_utils_diffuse_a_dither : Int

  export %inline
  DiffuseADiffuse : MethodForDiffuse
  DiffuseADiffuse = MkMethodForDiffuse sixel_utils_diffuse_a_dither

  --

  %foreign (sixelutils "sixel_utils_diffuse_x_dither")
  sixel_utils_diffuse_x_dither : Int

  export %inline
  DiffuseXDither : MethodForDiffuse
  DiffuseXDither = MkMethodForDiffuse sixel_utils_diffuse_x_dither

--

public export
data QualityMode = MkQualityMode Int

namespace QualityMode
  %foreign (sixelutils "sixel_utils_quality_symbol")
  sixel_utils_quality_symbol : Int -> AnyPtr

  export
  Symbolic Int QualityMode where
    hint _                    = "QualityMode"
    binding (MkQualityMode b) = b
    symbol                    = symbolBy sixel_utils_quality_symbol

  export
  Eq QualityMode where
    (==) x y = binding x == binding y

  export
  Show QualityMode where
    show = symbol

  --

  %foreign (sixelutils "sixel_utils_quality_auto")
  sixel_utils_quality_auto : Int

  export %inline
  QualityAuto : QualityMode
  QualityAuto = MkQualityMode sixel_utils_quality_auto

  --

  %foreign (sixelutils "sixel_utils_quality_high")
  sixel_utils_quality_high : Int

  export %inline
  QualityHigh : QualityMode
  QualityHigh = MkQualityMode sixel_utils_quality_high

  --

  %foreign (sixelutils "sixel_utils_quality_low")
  sixel_utils_quality_low : Int

  export %inline
  QualityLow : QualityMode
  QualityLow = MkQualityMode sixel_utils_quality_low

  --

  %foreign (sixelutils "sixel_utils_quality_full")
  sixel_utils_quality_full : Int

  export %inline
  QualityFull : QualityMode
  QualityFull = MkQualityMode sixel_utils_quality_full

  --

  %foreign (sixelutils "sixel_utils_quality_highcolor")
  sixel_utils_quality_highcolor : Int

  export %inline
  QualityHighcolor : QualityMode
  QualityHighcolor = MkQualityMode sixel_utils_quality_highcolor

--

public export
data BuiltinDither = MkBuiltinDither Int

namespace BuiltinDither
  %foreign (sixelutils "sixel_utils_builtin_symbol")
  sixel_utils_builtin_symbol : Int -> AnyPtr

  export
  Symbolic Int BuiltinDither where
    hint _                      = "BuiltinDither"
    binding (MkBuiltinDither b) = b
    symbol                      = symbolBy sixel_utils_builtin_symbol

  export
  Eq BuiltinDither where
    (==) x y = binding x == binding y

  export
  Show BuiltinDither where
    show = symbol

  --

  %foreign (sixelutils "sixel_utils_builtin_mono_dark")
  sixel_utils_builtin_mono_dark : Int

  export %inline
  BuiltinMonoDark : BuiltinDither
  BuiltinMonoDark = MkBuiltinDither sixel_utils_builtin_mono_dark

  --

  %foreign (sixelutils "sixel_utils_builtin_mono_light")
  sixel_utils_builtin_mono_light : Int

  export %inline
  BuiltinMonoLight : BuiltinDither
  BuiltinMonoLight = MkBuiltinDither sixel_utils_builtin_mono_light

  --

  %foreign (sixelutils "sixel_utils_builtin_xterm16")
  sixel_utils_builtin_xterm16 : Int

  export %inline
  BuiltinXterm16 : BuiltinDither
  BuiltinXterm16 = MkBuiltinDither sixel_utils_builtin_xterm16

  --

  %foreign (sixelutils "sixel_utils_builtin_xterm256")
  sixel_utils_builtin_xterm256 : Int

  export %inline
  BuiltinXterm256 : BuiltinDither
  BuiltinXterm256 = MkBuiltinDither sixel_utils_builtin_xterm256

  --

  %foreign (sixelutils "sixel_utils_builtin_vt340_mono")
  sixel_utils_builtin_vt340_mono : Int

  export %inline
  BuiltinVt340Mono : BuiltinDither
  BuiltinVt340Mono = MkBuiltinDither sixel_utils_builtin_vt340_mono

  --

  %foreign (sixelutils "sixel_utils_builtin_vt340_color")
  sixel_utils_builtin_vt340_color : Int

  export %inline
  BuiltinVt340Color : BuiltinDither
  BuiltinVt340Color = MkBuiltinDither sixel_utils_builtin_vt340_color

  --

  %foreign (sixelutils "sixel_utils_builtin_g1")
  sixel_utils_builtin_g1 : Int

  export %inline
  BuiltinG1 : BuiltinDither
  BuiltinG1 = MkBuiltinDither sixel_utils_builtin_g1

  --

  %foreign (sixelutils "sixel_utils_builtin_g2")
  sixel_utils_builtin_g2 : Int

  export %inline
  BuiltinG2 : BuiltinDither
  BuiltinG2 = MkBuiltinDither sixel_utils_builtin_g2

  --

  %foreign (sixelutils "sixel_utils_builtin_g4")
  sixel_utils_builtin_g4 : Int

  export %inline
  BuiltinG4 : BuiltinDither
  BuiltinG4 = MkBuiltinDither sixel_utils_builtin_g4

  --

  %foreign (sixelutils "sixel_utils_builtin_g8")
  sixel_utils_builtin_g8 : Int

  export %inline
  BuiltinG8 : BuiltinDither
  BuiltinG8 = MkBuiltinDither sixel_utils_builtin_g8

--

public export
data PixelFormat = MkPixelFormat Int

namespace PixelFormat
  %foreign (sixelutils "sixel_utils_pixelformat_symbol")
  sixel_utils_pixelformat_symbol : Int -> AnyPtr

  export
  Symbolic Int PixelFormat where
    hint _                    = "PixelFormat"
    binding (MkPixelFormat b) = b
    symbol                    = symbolBy sixel_utils_pixelformat_symbol

  export
  Eq PixelFormat where
    (==) x y = binding x == binding y

  export
  Show PixelFormat where
    show = symbol

  --

  %foreign (sixelutils "sixel_utils_pixelformat_rgb555")
  sixel_utils_pixelformat_rgb555 : Int

  export %inline
  PixelFormatRgb555 : PixelFormat
  PixelFormatRgb555 = MkPixelFormat sixel_utils_pixelformat_rgb555

  --

  %foreign (sixelutils "sixel_utils_pixelformat_rgb565")
  sixel_utils_pixelformat_rgb565 : Int

  export %inline
  PixelFormatRgb565 : PixelFormat
  PixelFormatRgb565 = MkPixelFormat sixel_utils_pixelformat_rgb565

  --

  %foreign (sixelutils "sixel_utils_pixelformat_rgb888")
  sixel_utils_pixelformat_rgb888 : Int

  export %inline
  PixelFormatRgb888 : PixelFormat
  PixelFormatRgb888 = MkPixelFormat sixel_utils_pixelformat_rgb888

  --

  %foreign (sixelutils "sixel_utils_pixelformat_bgr555")
  sixel_utils_pixelformat_bgr555 : Int

  export %inline
  PixelFormatBgr555 : PixelFormat
  PixelFormatBgr555 = MkPixelFormat sixel_utils_pixelformat_bgr555

  --

  %foreign (sixelutils "sixel_utils_pixelformat_bgr565")
  sixel_utils_pixelformat_bgr565 : Int

  export %inline
  PixelFormatBgr565 : PixelFormat
  PixelFormatBgr565 = MkPixelFormat sixel_utils_pixelformat_bgr565

  --

  %foreign (sixelutils "sixel_utils_pixelformat_bgr888")
  sixel_utils_pixelformat_bgr888 : Int

  export %inline
  PixelFormatBgr888 : PixelFormat
  PixelFormatBgr888 = MkPixelFormat sixel_utils_pixelformat_bgr888

  --

  %foreign (sixelutils "sixel_utils_pixelformat_argb8888")
  sixel_utils_pixelformat_argb8888 : Int

  export %inline
  PixelFormatArgb8888 : PixelFormat
  PixelFormatArgb8888 = MkPixelFormat sixel_utils_pixelformat_argb8888

  --

  %foreign (sixelutils "sixel_utils_pixelformat_rgba8888")
  sixel_utils_pixelformat_rgba8888 : Int

  export %inline
  PixelFormatRgba8888 : PixelFormat
  PixelFormatRgba8888 = MkPixelFormat sixel_utils_pixelformat_rgba8888

  --

  %foreign (sixelutils "sixel_utils_pixelformat_abgr8888")
  sixel_utils_pixelformat_abgr8888 : Int

  export %inline
  PixelFormatAbgr8888 : PixelFormat
  PixelFormatAbgr8888 = MkPixelFormat sixel_utils_pixelformat_abgr8888

  --

  %foreign (sixelutils "sixel_utils_pixelformat_bgra8888")
  sixel_utils_pixelformat_bgra8888 : Int

  export %inline
  PixelFormatBgra8888 : PixelFormat
  PixelFormatBgra8888 = MkPixelFormat sixel_utils_pixelformat_bgra8888

  --

  %foreign (sixelutils "sixel_utils_pixelformat_g1")
  sixel_utils_pixelformat_g1 : Int

  export %inline
  PixelFormatG1 : PixelFormat
  PixelFormatG1 = MkPixelFormat sixel_utils_pixelformat_g1

  --

  %foreign (sixelutils "sixel_utils_pixelformat_g2")
  sixel_utils_pixelformat_g2 : Int

  export %inline
  PixelFormatG2 : PixelFormat
  PixelFormatG2 = MkPixelFormat sixel_utils_pixelformat_g2

  --

  %foreign (sixelutils "sixel_utils_pixelformat_g4")
  sixel_utils_pixelformat_g4 : Int

  export %inline
  PixelFormatG4 : PixelFormat
  PixelFormatG4 = MkPixelFormat sixel_utils_pixelformat_g4

  --

  %foreign (sixelutils "sixel_utils_pixelformat_g8")
  sixel_utils_pixelformat_g8 : Int

  export %inline
  PixelFormatG8 : PixelFormat
  PixelFormatG8 = MkPixelFormat sixel_utils_pixelformat_g8

  --

  %foreign (sixelutils "sixel_utils_pixelformat_ag88")
  sixel_utils_pixelformat_ag88 : Int

  export %inline
  PixelFormatAg88 : PixelFormat
  PixelFormatAg88 = MkPixelFormat sixel_utils_pixelformat_ag88

  --

  %foreign (sixelutils "sixel_utils_pixelformat_ga88")
  sixel_utils_pixelformat_ga88 : Int

  export %inline
  PixelFormatGa88 : PixelFormat
  PixelFormatGa88 = MkPixelFormat sixel_utils_pixelformat_ga88

  --

  %foreign (sixelutils "sixel_utils_pixelformat_pal1")
  sixel_utils_pixelformat_pal1 : Int

  export %inline
  PixelFormatPal1 : PixelFormat
  PixelFormatPal1 = MkPixelFormat sixel_utils_pixelformat_pal1

  --

  %foreign (sixelutils "sixel_utils_pixelformat_pal2")
  sixel_utils_pixelformat_pal2 : Int

  export %inline
  PixelFormatPal2 : PixelFormat
  PixelFormatPal2 = MkPixelFormat sixel_utils_pixelformat_pal2

  --

  %foreign (sixelutils "sixel_utils_pixelformat_pal4")
  sixel_utils_pixelformat_pal4 : Int

  export %inline
  PixelFormatPal4 : PixelFormat
  PixelFormatPal4 = MkPixelFormat sixel_utils_pixelformat_pal4

  --

  %foreign (sixelutils "sixel_utils_pixelformat_pal8")
  sixel_utils_pixelformat_pal8 : Int

  export %inline
  PixelFormatPal8 : PixelFormat
  PixelFormatPal8 = MkPixelFormat sixel_utils_pixelformat_pal8

--

public export
data PaletteType = MkPaletteType Int

namespace PaletteType
  %foreign (sixelutils "sixel_utils_palettetype_symbol")
  sixel_utils_palettetype_symbol : Int -> AnyPtr

  export
  Symbolic Int PaletteType where
    hint _                    = "PaletteType"
    binding (MkPaletteType b) = b
    symbol                    = symbolBy sixel_utils_palettetype_symbol

  export
  Eq PaletteType where
    (==) x y = binding x == binding y

  export
  Show PaletteType where
    show = symbol

  --

  %foreign (sixelutils "sixel_utils_palettetype_auto")
  sixel_utils_palettetype_auto : Int

  export %inline
  PaletteTypeAuto : PaletteType
  PaletteTypeAuto = MkPaletteType sixel_utils_palettetype_auto

  --

  %foreign (sixelutils "sixel_utils_palettetype_hls")
  sixel_utils_palettetype_hls : Int

  export %inline
  PaletteTypeHls : PaletteType
  PaletteTypeHls = MkPaletteType sixel_utils_palettetype_hls

  --

  %foreign (sixelutils "sixel_utils_palettetype_rgb")
  sixel_utils_palettetype_rgb : Int

  export %inline
  PaletteTypeRgb : PaletteType
  PaletteTypeRgb = MkPaletteType sixel_utils_palettetype_rgb

--

public export
data EncodePolicy = MkEncodePolicy Int

namespace EncodePolicy
  %foreign (sixelutils "sixel_utils_encodepolicy_symbol")
  sixel_utils_encodepolicy_symbol : Int -> AnyPtr

  export
  Symbolic Int EncodePolicy where
    hint _                     = "EncodePolicy"
    binding (MkEncodePolicy b) = b
    symbol                     = symbolBy sixel_utils_encodepolicy_symbol

  export
  Eq EncodePolicy where
    (==) x y = binding x == binding y

  export
  Show EncodePolicy where
    show = symbol

  --

  %foreign (sixelutils "sixel_utils_encodepolicy_auto")
  sixel_utils_encodepolicy_auto : Int

  export %inline
  EncodePolicyAuto : EncodePolicy
  EncodePolicyAuto = MkEncodePolicy sixel_utils_encodepolicy_auto

  --

  %foreign (sixelutils "sixel_utils_encodepolicy_fast")
  sixel_utils_encodepolicy_fast : Int

  export %inline
  EncodePolicyFast : EncodePolicy
  EncodePolicyFast = MkEncodePolicy sixel_utils_encodepolicy_fast

  --

  %foreign (sixelutils "sixel_utils_encodepolicy_size")
  sixel_utils_encodepolicy_size : Int

  export %inline
  EncodePolicySize : EncodePolicy
  EncodePolicySize = MkEncodePolicy sixel_utils_encodepolicy_size

--

public export
data MethodForResampling = MkMethodForResampling Int

namespace MethodForResampling
  %foreign (sixelutils "sixel_utils_res_symbol")
  sixel_utils_res_symbol : Int -> AnyPtr

  export %inline
  Symbolic Int MethodForResampling where
    hint _                            = "MethodForResampling"
    binding (MkMethodForResampling b) = b
    symbol                            = symbolBy sixel_utils_res_symbol

  export
  Eq MethodForResampling where
    (==) x y = binding x == binding y

  export
  Show MethodForResampling where
    show = symbol

  --

  %foreign (sixelutils "sixel_utils_res_nearest")
  sixel_utils_res_nearest : Int

  export %inline
  ResNearest : MethodForResampling
  ResNearest = MkMethodForResampling sixel_utils_res_nearest

  --

  %foreign (sixelutils "sixel_utils_res_gaussian")
  sixel_utils_res_gaussian : Int

  export %inline
  ResGaussian : MethodForResampling
  ResGaussian = MkMethodForResampling sixel_utils_res_gaussian

  --

  %foreign (sixelutils "sixel_utils_res_hanning")
  sixel_utils_res_hanning : Int

  export %inline
  ResHanning : MethodForResampling
  ResHanning = MkMethodForResampling sixel_utils_res_hanning

  --

  %foreign (sixelutils "sixel_utils_res_hamming")
  sixel_utils_res_hamming : Int

  export %inline
  ResHamming : MethodForResampling
  ResHamming = MkMethodForResampling sixel_utils_res_hamming

  --

  %foreign (sixelutils "sixel_utils_res_bilinear")
  sixel_utils_res_bilinear : Int

  export %inline
  ResBilinear : MethodForResampling
  ResBilinear = MkMethodForResampling sixel_utils_res_bilinear

  --

  %foreign (sixelutils "sixel_utils_res_welsh")
  sixel_utils_res_welsh : Int

  export %inline
  ResWelsh : MethodForResampling
  ResWelsh = MkMethodForResampling sixel_utils_res_welsh

  --

  %foreign (sixelutils "sixel_utils_res_bicubic")
  sixel_utils_res_bicubic : Int

  export %inline
  ResBicubic : MethodForResampling
  ResBicubic = MkMethodForResampling sixel_utils_res_bicubic

  --

  %foreign (sixelutils "sixel_utils_res_lanczos2")
  sixel_utils_res_lanczos2 : Int

  export %inline
  ResLanczos2 : MethodForResampling
  ResLanczos2 = MkMethodForResampling sixel_utils_res_lanczos2

  --

  %foreign (sixelutils "sixel_utils_res_lanczos3")
  sixel_utils_res_lanczos3 : Int

  export %inline
  ResLanczos3 : MethodForResampling
  ResLanczos3 = MkMethodForResampling sixel_utils_res_lanczos3

  --

  %foreign (sixelutils "sixel_utils_res_lanczos4")
  sixel_utils_res_lanczos4 : Int

  export %inline
  ResLanczos4 : MethodForResampling
  ResLanczos4 = MkMethodForResampling sixel_utils_res_lanczos4

--

public export
data ImageFormat = MkImageFormat Int

namespace ImageFormat
  %foreign (sixelutils "sixel_utils_format_symbol")
  sixel_utils_format_symbol : Int -> AnyPtr

  export
  Symbolic Int ImageFormat where
    hint _               = "ImageFormat"
    binding (MkImageFormat b) = b
    symbol               = symbolBy sixel_utils_format_symbol

  export
  Eq ImageFormat where
    (==) x y = binding x == binding y

  export
  Show ImageFormat where
    show = symbol

  --

  %foreign (sixelutils "sixel_utils_format_gif")
  sixel_utils_format_gif : Int

  export %inline
  FormatGif : ImageFormat
  FormatGif = MkImageFormat sixel_utils_format_gif

  --

  %foreign (sixelutils "sixel_utils_format_png")
  sixel_utils_format_png : Int

  export %inline
  FormatPng : ImageFormat
  FormatPng = MkImageFormat sixel_utils_format_png

  --

  %foreign (sixelutils "sixel_utils_format_bmp")
  sixel_utils_format_bmp : Int

  export %inline
  FormatBmp : ImageFormat
  FormatBmp = MkImageFormat sixel_utils_format_bmp

  --

  %foreign (sixelutils "sixel_utils_format_jpg")
  sixel_utils_format_jpg : Int

  export %inline
  FormatJpg : ImageFormat
  FormatJpg = MkImageFormat sixel_utils_format_jpg

  --

  %foreign (sixelutils "sixel_utils_format_tga")
  sixel_utils_format_tga : Int

  export %inline
  FormatTga : ImageFormat
  FormatTga = MkImageFormat sixel_utils_format_tga

  --

  %foreign (sixelutils "sixel_utils_format_wbmp")
  sixel_utils_format_wbmp : Int

  export %inline
  FormatWbmp : ImageFormat
  FormatWbmp = MkImageFormat sixel_utils_format_wbmp

  --

  %foreign (sixelutils "sixel_utils_format_tiff")
  sixel_utils_format_tiff : Int

  export %inline
  FormatTiff : ImageFormat
  FormatTiff = MkImageFormat sixel_utils_format_tiff

  --

  %foreign (sixelutils "sixel_utils_format_sixel")
  sixel_utils_format_sixel : Int

  export %inline
  FormatSixel : ImageFormat
  FormatSixel = MkImageFormat sixel_utils_format_sixel

  --

  %foreign (sixelutils "sixel_utils_format_pnm")
  sixel_utils_format_pnm : Int

  export %inline
  FormatPnm : ImageFormat
  FormatPnm = MkImageFormat sixel_utils_format_pnm

  --

  %foreign (sixelutils "sixel_utils_format_gd2")
  sixel_utils_format_gd2 : Int

  export %inline
  FormatGd2 : ImageFormat
  FormatGd2 = MkImageFormat sixel_utils_format_gd2

  --

  %foreign (sixelutils "sixel_utils_format_psd")
  sixel_utils_format_psd : Int

  export %inline
  FormatPsd : ImageFormat
  FormatPsd = MkImageFormat sixel_utils_format_psd

  --

  %foreign (sixelutils "sixel_utils_format_hdr")
  sixel_utils_format_hdr : Int

  export %inline
  FormatHdr : ImageFormat
  FormatHdr = MkImageFormat sixel_utils_format_hdr

--

public export
data LoopControl = MkLoopControl Int

namespace LoopControl
  %foreign (sixelutils "sixel_utils_loop_symbol")
  sixel_utils_loop_symbol : Int -> AnyPtr

  export
  Symbolic Int LoopControl where
    hint _                    = "LoopControl"
    binding (MkLoopControl b) = b
    symbol                    = symbolBy sixel_utils_loop_symbol

  export
  Eq LoopControl where
    (==) x y = binding x == binding y

  export
  Show LoopControl where
    show = symbol

  --

  %foreign (sixelutils "sixel_utils_loop_auto")
  sixel_utils_loop_auto : Int

  export %inline
  LoopAuto : LoopControl
  LoopAuto = MkLoopControl sixel_utils_loop_auto

  --

  %foreign (sixelutils "sixel_utils_loop_force")
  sixel_utils_loop_force : Int

  export %inline
  LoopForce : LoopControl
  LoopForce = MkLoopControl sixel_utils_loop_force

  --

  %foreign (sixelutils "sixel_utils_loop_disable")
  sixel_utils_loop_disable : Int

  export %inline
  LoopDisable : LoopControl
  LoopDisable = MkLoopControl sixel_utils_loop_disable

--

public export
data OptFlag = MkOptFlag Int

namespace OptFlag
  export
  Symbolic Int OptFlag where
    hint _                   = "OptFlag"
    binding (MkOptFlag flag) = flag
    symbol  (MkOptFlag flag) = "OptFlag " ++ show flag

  --

  %foreign (sixelutils "sixel_utils_optflag_input")
  sixel_utils_optflag_input : Int

  export %inline
  OptFlagInput : OptFlag
  OptFlagInput = MkOptFlag sixel_utils_optflag_input

  --

  %foreign (sixelutils "sixel_utils_optflag_output")
  sixel_utils_optflag_output : Int

  export %inline
  OptFlagOutput : OptFlag
  OptFlagOutput = MkOptFlag sixel_utils_optflag_output

  --

  %foreign (sixelutils "sixel_utils_optflag_outfile")
  sixel_utils_optflag_outfile : Int

  export %inline
  OptFlagOutfile : OptFlag
  OptFlagOutfile = MkOptFlag sixel_utils_optflag_outfile

  --

  %foreign (sixelutils "sixel_utils_optflag_7bit_mode")
  sixel_utils_optflag_7bit_mode : Int

  export %inline
  OptFlag7BitMode : OptFlag
  OptFlag7BitMode = MkOptFlag sixel_utils_optflag_7bit_mode

  --

  %foreign (sixelutils "sixel_utils_optflag_8bit_mode")
  sixel_utils_optflag_8bit_mode : Int

  export %inline
  OptFlag8BitMode : OptFlag
  OptFlag8BitMode = MkOptFlag sixel_utils_optflag_8bit_mode

  --

  %foreign (sixelutils "sixel_utils_optflag_has_gri_arg_limit")
  sixel_utils_optflag_has_gri_arg_limit : Int

  export %inline
  OptFlagHasGriArgLimit : OptFlag
  OptFlagHasGriArgLimit = MkOptFlag sixel_utils_optflag_has_gri_arg_limit

  --

  %foreign (sixelutils "sixel_utils_optflag_colors")
  sixel_utils_optflag_colors : Int

  export %inline
  OptFlagColors : OptFlag
  OptFlagColors = MkOptFlag sixel_utils_optflag_colors

  --

  %foreign (sixelutils "sixel_utils_optflag_mapfile")
  sixel_utils_optflag_mapfile : Int

  export %inline
  OptFlagMapfile : OptFlag
  OptFlagMapfile = MkOptFlag sixel_utils_optflag_mapfile

  --

  %foreign (sixelutils "sixel_utils_optflag_monochrome")
  sixel_utils_optflag_monochrome : Int

  export %inline
  OptFlagMonochrome : OptFlag
  OptFlagMonochrome = MkOptFlag sixel_utils_optflag_monochrome

  --

  %foreign (sixelutils "sixel_utils_optflag_insecure")
  sixel_utils_optflag_insecure : Int

  export %inline
  OptFlagInsecure : OptFlag
  OptFlagInsecure = MkOptFlag sixel_utils_optflag_insecure

  --

  %foreign (sixelutils "sixel_utils_optflag_invert")
  sixel_utils_optflag_invert : Int

  export %inline
  OptFlagInvert : OptFlag
  OptFlagInvert = MkOptFlag sixel_utils_optflag_invert

  --

  %foreign (sixelutils "sixel_utils_optflag_high_color")
  sixel_utils_optflag_high_color : Int

  export %inline
  OptFlagHighColor : OptFlag
  OptFlagHighColor = MkOptFlag sixel_utils_optflag_high_color

  --

  %foreign (sixelutils "sixel_utils_optflag_use_macro")
  sixel_utils_optflag_use_macro : Int

  export %inline
  OptFlagUseMacro : OptFlag
  OptFlagUseMacro = MkOptFlag sixel_utils_optflag_use_macro

  --

  %foreign (sixelutils "sixel_utils_optflag_macro_number")
  sixel_utils_optflag_macro_number : Int

  export %inline
  OptFlagMacroNumber : OptFlag
  OptFlagMacroNumber = MkOptFlag sixel_utils_optflag_macro_number

  --

  %foreign (sixelutils "sixel_utils_optflag_complexion_score")
  sixel_utils_optflag_complexion_score : Int

  export %inline
  OptFlagComplexionScore : OptFlag
  OptFlagComplexionScore = MkOptFlag sixel_utils_optflag_complexion_score

  --

  %foreign (sixelutils "sixel_utils_optflag_ignore_delay")
  sixel_utils_optflag_ignore_delay : Int

  export %inline
  OptFlagIgnoreDelay : OptFlag
  OptFlagIgnoreDelay = MkOptFlag sixel_utils_optflag_ignore_delay

  --

  %foreign (sixelutils "sixel_utils_optflag_static")
  sixel_utils_optflag_static : Int

  export %inline
  OptFlagStatic : OptFlag
  OptFlagStatic = MkOptFlag sixel_utils_optflag_static

  --

  %foreign (sixelutils "sixel_utils_optflag_diffusion")
  sixel_utils_optflag_diffusion : Int

  export %inline
  OptFlagDiffusion : OptFlag
  OptFlagDiffusion = MkOptFlag sixel_utils_optflag_diffusion

  --

  %foreign (sixelutils "sixel_utils_optflag_find_largest")
  sixel_utils_optflag_find_largest : Int

  export %inline
  OptFlagFindLargest : OptFlag
  OptFlagFindLargest = MkOptFlag sixel_utils_optflag_find_largest

  --

  %foreign (sixelutils "sixel_utils_optflag_select_color")
  sixel_utils_optflag_select_color : Int

  export %inline
  OptFlagSelectColor : OptFlag
  OptFlagSelectColor = MkOptFlag sixel_utils_optflag_select_color

  --

  %foreign (sixelutils "sixel_utils_optflag_crop")
  sixel_utils_optflag_crop : Int

  export %inline
  OptFlagCrop : OptFlag
  OptFlagCrop = MkOptFlag sixel_utils_optflag_crop

  --

  %foreign (sixelutils "sixel_utils_optflag_width")
  sixel_utils_optflag_width : Int

  export %inline
  OptFlagWidth : OptFlag
  OptFlagWidth = MkOptFlag sixel_utils_optflag_width

  --

  %foreign (sixelutils "sixel_utils_optflag_height")
  sixel_utils_optflag_height : Int

  export %inline
  OptFlagHeight : OptFlag
  OptFlagHeight = MkOptFlag sixel_utils_optflag_height

  --

  %foreign (sixelutils "sixel_utils_optflag_resampling")
  sixel_utils_optflag_resampling : Int

  export %inline
  OptFlagResampling : OptFlag
  OptFlagResampling = MkOptFlag sixel_utils_optflag_resampling

  --

  %foreign (sixelutils "sixel_utils_optflag_quality")
  sixel_utils_optflag_quality : Int

  export %inline
  OptFlagQuality : OptFlag
  OptFlagQuality = MkOptFlag sixel_utils_optflag_quality

  --

  %foreign (sixelutils "sixel_utils_optflag_loopmode")
  sixel_utils_optflag_loopmode : Int

  export %inline
  OptFlagLoopmode : OptFlag
  OptFlagLoopmode = MkOptFlag sixel_utils_optflag_loopmode

  --

  %foreign (sixelutils "sixel_utils_optflag_palette_type")
  sixel_utils_optflag_palette_type : Int

  export %inline
  OptFlagPaletteType : OptFlag
  OptFlagPaletteType = MkOptFlag sixel_utils_optflag_palette_type

  --

  %foreign (sixelutils "sixel_utils_optflag_builtin_palette")
  sixel_utils_optflag_builtin_palette : Int

  export %inline
  OptFlagBuiltinPalette : OptFlag
  OptFlagBuiltinPalette = MkOptFlag sixel_utils_optflag_builtin_palette

  --

  %foreign (sixelutils "sixel_utils_optflag_encode_policy")
  sixel_utils_optflag_encode_policy : Int

  export %inline
  OptFlagEncodePolicy : OptFlag
  OptFlagEncodePolicy = MkOptFlag sixel_utils_optflag_encode_policy

  --

  %foreign (sixelutils "sixel_utils_optflag_bgcolor")
  sixel_utils_optflag_bgcolor : Int

  export %inline
  OptFlagBgcolor : OptFlag
  OptFlagBgcolor = MkOptFlag sixel_utils_optflag_bgcolor

  --

  %foreign (sixelutils "sixel_utils_optflag_penetrate")
  sixel_utils_optflag_penetrate : Int

  export %inline
  OptFlagPenetrate : OptFlag
  OptFlagPenetrate = MkOptFlag sixel_utils_optflag_penetrate

  --

  %foreign (sixelutils "sixel_utils_optflag_pipe_mode")
  sixel_utils_optflag_pipe_mode : Int

  export %inline
  OptFlagPipeMode : OptFlag
  OptFlagPipeMode = MkOptFlag sixel_utils_optflag_pipe_mode

  --

  %foreign (sixelutils "sixel_utils_optflag_verbose")
  sixel_utils_optflag_verbose : Int

  export %inline
  OptFlagVerbose : OptFlag
  OptFlagVerbose = MkOptFlag sixel_utils_optflag_verbose

  --

  %foreign (sixelutils "sixel_utils_optflag_version")
  sixel_utils_optflag_version : Int

  export %inline
  OptFlagVersion : OptFlag
  OptFlagVersion = MkOptFlag sixel_utils_optflag_version

  --

  %foreign (sixelutils "sixel_utils_optflag_help")
  sixel_utils_optflag_help : Int

  export %inline
  OptFlagHelp : OptFlag
  OptFlagHelp = MkOptFlag sixel_utils_optflag_help
