#include <sixel.h>
#include <stdint.h>
#ifdef _WIN32
#include <malloc.h>
#else
#include <stdlib.h>
#endif

#ifdef _WIN32
#define extern_inline __declspec(dllexport) __inline
#else
#define extern_inline extern inline
#endif

#ifdef _WIN32
#define alloca _alloca
#endif

int
sixel_utils_is_concrete(void *ptr)
{
    return ptr != NULL;
}

void *
sixel_utils_pointer_cast(void *ptr)
{
    return ptr;
}

void *
sixel_utils_buffer_null(void)
{
    return NULL;
}

sixel_allocator_t *
sixel_utils_allocator_null(void)
{
    return NULL;
}

extern_inline
int *
sixel_utils_int_ptr_new(int value)
{
    int *ptr = alloca(sizeof(int));
    *ptr = value;
    return ptr;
}

const char *
sixel_utils_version(void)
{
    return LIBSIXEL_VERSION;
}

const char *
sixel_utils_abi_version(void)
{
    return LIBSIXEL_ABI_VERSION;
}

#define SYMBOL(t, k, v) \
t \
sixel_utils_##k(void) \
{ \
    return SIXEL_##v; \
}

SYMBOL(int, palette_min, PALETTE_MIN)
SYMBOL(int, palette_max, PALETTE_MAX)
SYMBOL(uint64_t, allocate_bytes_max, ALLOCATE_BYTES_MAX)
SYMBOL(int, width_limit, WIDTH_LIMIT)
SYMBOL(int, height_limit, HEIGHT_LIMIT)

SYMBOL(int, ok, OK)
SYMBOL(int, runtime_error, RUNTIME_ERROR)
SYMBOL(int, logic_error, LOGIC_ERROR)
SYMBOL(int, feature_error, FEATURE_ERROR)
SYMBOL(int, libc_error, LIBC_ERROR)
SYMBOL(int, curl_error, CURL_ERROR)
SYMBOL(int, jpeg_error, JPEG_ERROR)
SYMBOL(int, png_error, PNG_ERROR)
SYMBOL(int, gdk_error, GDK_ERROR)
SYMBOL(int, gd_error, GD_ERROR)
SYMBOL(int, stbi_error, STBI_ERROR)
SYMBOL(int, stbiw_error, STBIW_ERROR)
SYMBOL(int, interrupted, INTERRUPTED)
SYMBOL(int, bad_allocation, BAD_ALLOCATION)
SYMBOL(int, bad_argument, BAD_ARGUMENT)
SYMBOL(int, bad_input, BAD_INPUT)
SYMBOL(int, bad_integer_overflow, BAD_INTEGER_OVERFLOW)
SYMBOL(int, not_implemented, NOT_IMPLEMENTED)
SYMBOL(int, large_auto, LARGE_AUTO)
SYMBOL(int, large_norm, LARGE_NORM)
SYMBOL(int, large_lum, LARGE_LUM)
SYMBOL(int, rep_auto, REP_AUTO)
SYMBOL(int, rep_center_box, REP_CENTER_BOX)
SYMBOL(int, rep_average_colors, REP_AVERAGE_COLORS)
SYMBOL(int, rep_average_pixels, REP_AVERAGE_PIXELS)
SYMBOL(int, diffuse_auto, DIFFUSE_AUTO)
SYMBOL(int, diffuse_none, DIFFUSE_NONE)
SYMBOL(int, diffuse_atkinson, DIFFUSE_ATKINSON)
SYMBOL(int, diffuse_fs, DIFFUSE_FS)
SYMBOL(int, diffuse_jajuni, DIFFUSE_JAJUNI)
SYMBOL(int, diffuse_stucki, DIFFUSE_STUCKI)
SYMBOL(int, diffuse_burkes, DIFFUSE_BURKES)
SYMBOL(int, diffuse_a_dither, DIFFUSE_A_DITHER)
SYMBOL(int, diffuse_x_dither, DIFFUSE_X_DITHER)
SYMBOL(int, quality_auto, QUALITY_AUTO)
SYMBOL(int, quality_high, QUALITY_HIGH)
SYMBOL(int, quality_low, QUALITY_LOW)
SYMBOL(int, quality_full, QUALITY_FULL)
SYMBOL(int, quality_highcolor, QUALITY_HIGHCOLOR)
SYMBOL(int, builtin_mono_dark, BUILTIN_MONO_DARK)
SYMBOL(int, builtin_mono_light, BUILTIN_MONO_LIGHT)
SYMBOL(int, builtin_xterm16, BUILTIN_XTERM16)
SYMBOL(int, builtin_xterm256, BUILTIN_XTERM256)
SYMBOL(int, builtin_vt340_mono, BUILTIN_VT340_MONO)
SYMBOL(int, builtin_vt340_color, BUILTIN_VT340_COLOR)
SYMBOL(int, builtin_g1, BUILTIN_G1)
SYMBOL(int, builtin_g2, BUILTIN_G2)
SYMBOL(int, builtin_g4, BUILTIN_G4)
SYMBOL(int, builtin_g8, BUILTIN_G8)
SYMBOL(int, pixelformat_rgb555, PIXELFORMAT_RGB555)
SYMBOL(int, pixelformat_rgb565, PIXELFORMAT_RGB565)
SYMBOL(int, pixelformat_rgb888, PIXELFORMAT_RGB888)
SYMBOL(int, pixelformat_bgr555, PIXELFORMAT_BGR555)
SYMBOL(int, pixelformat_bgr565, PIXELFORMAT_BGR565)
SYMBOL(int, pixelformat_bgr888, PIXELFORMAT_BGR888)
SYMBOL(int, pixelformat_argb8888, PIXELFORMAT_ARGB8888)
SYMBOL(int, pixelformat_rgba8888, PIXELFORMAT_RGBA8888)
SYMBOL(int, pixelformat_abgr8888, PIXELFORMAT_ABGR8888)
SYMBOL(int, pixelformat_bgra8888, PIXELFORMAT_BGRA8888)
SYMBOL(int, pixelformat_g1, PIXELFORMAT_G1)
SYMBOL(int, pixelformat_g2, PIXELFORMAT_G2)
SYMBOL(int, pixelformat_g4, PIXELFORMAT_G4)
SYMBOL(int, pixelformat_g8, PIXELFORMAT_G8)
SYMBOL(int, pixelformat_ag88, PIXELFORMAT_AG88)
SYMBOL(int, pixelformat_ga88, PIXELFORMAT_GA88)
SYMBOL(int, pixelformat_pal1, PIXELFORMAT_PAL1)
SYMBOL(int, pixelformat_pal2, PIXELFORMAT_PAL2)
SYMBOL(int, pixelformat_pal4, PIXELFORMAT_PAL4)
SYMBOL(int, pixelformat_pal8, PIXELFORMAT_PAL8)
SYMBOL(int, palettetype_auto, PALETTETYPE_AUTO)
SYMBOL(int, palettetype_hls, PALETTETYPE_HLS)
SYMBOL(int, palettetype_rgb, PALETTETYPE_RGB)
SYMBOL(int, encodepolicy_auto, ENCODEPOLICY_AUTO)
SYMBOL(int, encodepolicy_fast, ENCODEPOLICY_FAST)
SYMBOL(int, encodepolicy_size, ENCODEPOLICY_SIZE)
SYMBOL(int, res_nearest, RES_NEAREST)
SYMBOL(int, res_gaussian, RES_GAUSSIAN)
SYMBOL(int, res_hanning, RES_HANNING)
SYMBOL(int, res_hamming, RES_HAMMING)
SYMBOL(int, res_bilinear, RES_BILINEAR)
SYMBOL(int, res_welsh, RES_WELSH)
SYMBOL(int, res_bicubic, RES_BICUBIC)
SYMBOL(int, res_lanczos2, RES_LANCZOS2)
SYMBOL(int, res_lanczos3, RES_LANCZOS3)
SYMBOL(int, res_lanczos4, RES_LANCZOS4)
SYMBOL(int, format_gif, FORMAT_GIF)
SYMBOL(int, format_png, FORMAT_PNG)
SYMBOL(int, format_bmp, FORMAT_BMP)
SYMBOL(int, format_jpg, FORMAT_JPG)
SYMBOL(int, format_tga, FORMAT_TGA)
SYMBOL(int, format_wbmp, FORMAT_WBMP)
SYMBOL(int, format_tiff, FORMAT_TIFF)
SYMBOL(int, format_sixel, FORMAT_SIXEL)
SYMBOL(int, format_pnm, FORMAT_PNM)
SYMBOL(int, format_gd2, FORMAT_GD2)
SYMBOL(int, format_psd, FORMAT_PSD)
SYMBOL(int, format_hdr, FORMAT_HDR)
SYMBOL(int, loop_auto, LOOP_AUTO)
SYMBOL(int, loop_force, LOOP_FORCE)
SYMBOL(int, loop_disable, LOOP_DISABLE)
SYMBOL(int, optflag_input, OPTFLAG_INPUT)
SYMBOL(int, optflag_output, OPTFLAG_OUTPUT)
SYMBOL(int, optflag_outfile, OPTFLAG_OUTFILE)
SYMBOL(int, optflag_7bit_mode, OPTFLAG_7BIT_MODE)
SYMBOL(int, optflag_8bit_mode, OPTFLAG_8BIT_MODE)
SYMBOL(int, optflag_has_gri_arg_limit, OPTFLAG_HAS_GRI_ARG_LIMIT)
SYMBOL(int, optflag_colors, OPTFLAG_COLORS)
SYMBOL(int, optflag_mapfile, OPTFLAG_MAPFILE)
SYMBOL(int, optflag_monochrome, OPTFLAG_MONOCHROME)
SYMBOL(int, optflag_insecure, OPTFLAG_INSECURE)
SYMBOL(int, optflag_invert, OPTFLAG_INVERT)
SYMBOL(int, optflag_high_color, OPTFLAG_HIGH_COLOR)
SYMBOL(int, optflag_use_macro, OPTFLAG_USE_MACRO)
SYMBOL(int, optflag_macro_number, OPTFLAG_MACRO_NUMBER)
SYMBOL(int, optflag_complexion_score, OPTFLAG_COMPLEXION_SCORE)
SYMBOL(int, optflag_ignore_delay, OPTFLAG_IGNORE_DELAY)
SYMBOL(int, optflag_static, OPTFLAG_STATIC)
SYMBOL(int, optflag_diffusion, OPTFLAG_DIFFUSION)
SYMBOL(int, optflag_find_largest, OPTFLAG_FIND_LARGEST)
SYMBOL(int, optflag_select_color, OPTFLAG_SELECT_COLOR)
SYMBOL(int, optflag_crop, OPTFLAG_CROP)
SYMBOL(int, optflag_width, OPTFLAG_WIDTH)
SYMBOL(int, optflag_height, OPTFLAG_HEIGHT)
SYMBOL(int, optflag_resampling, OPTFLAG_RESAMPLING)
SYMBOL(int, optflag_quality, OPTFLAG_QUALITY)
SYMBOL(int, optflag_loopmode, OPTFLAG_LOOPMODE)
SYMBOL(int, optflag_palette_type, OPTFLAG_PALETTE_TYPE)
SYMBOL(int, optflag_builtin_palette, OPTFLAG_BUILTIN_PALETTE)
SYMBOL(int, optflag_encode_policy, OPTFLAG_ENCODE_POLICY)
SYMBOL(int, optflag_bgcolor, OPTFLAG_BGCOLOR)
SYMBOL(int, optflag_penetrate, OPTFLAG_PENETRATE)
SYMBOL(int, optflag_pipe_mode, OPTFLAG_PIPE_MODE)
SYMBOL(int, optflag_verbose, OPTFLAG_VERBOSE)
SYMBOL(int, optflag_version, OPTFLAG_VERSION)
SYMBOL(int, optflag_help, OPTFLAG_HELP)

const char *
sixel_utils_status_symbol(int status)
{
    switch (status) {
        case SIXEL_OK: return "Ok";
        case SIXEL_RUNTIME_ERROR: return "RuntimeError";
        case SIXEL_LOGIC_ERROR: return "LogicError";
        case SIXEL_FEATURE_ERROR: return "FeatureError";
        case SIXEL_LIBC_ERROR: return "LibcError";
        case SIXEL_CURL_ERROR: return "CurlError";
        case SIXEL_JPEG_ERROR: return "JpegError";
        case SIXEL_PNG_ERROR: return "PngError";
        case SIXEL_GDK_ERROR: return "GdkError";
        case SIXEL_GD_ERROR: return "GdError";
        case SIXEL_STBI_ERROR: return "StbiError";
        case SIXEL_STBIW_ERROR: return "StbiwError";
        case SIXEL_INTERRUPTED: return "Interrupted";
        case SIXEL_BAD_ALLOCATION: return "BadAllocation";
        case SIXEL_BAD_ARGUMENT: return "BadArgument";
        case SIXEL_BAD_INPUT: return "BadInput";
        case SIXEL_BAD_INTEGER_OVERFLOW: return "BadIntegerOverflow";
        case SIXEL_NOT_IMPLEMENTED: return "NotImplemented";
        default: return NULL;
    }
}

const char *
sixel_utils_large_symbol(int large)
{
    switch (large) {
        case SIXEL_LARGE_AUTO: return "LargeAuto";
        case SIXEL_LARGE_NORM: return "LargeNorm";
        case SIXEL_LARGE_LUM: return "LargeLum";
        default: return NULL;
    }
}

const char *
sixel_utils_rep_symbol(int rep)
{
    switch (rep) {
        case SIXEL_REP_CENTER_BOX: return "RepCenterBox";
        case SIXEL_REP_AVERAGE_COLORS: return "RepAverageColors";
        case SIXEL_REP_AVERAGE_PIXELS: return "RepAveragePixels";
        default: return NULL;
    }
}

const char *
sixel_utils_diffuse_symbol(int diffuse)
{
    switch (diffuse) {
        case SIXEL_DIFFUSE_AUTO: return "DiffuseAuto";
        case SIXEL_DIFFUSE_NONE: return "DiffuseNone";
        case SIXEL_DIFFUSE_ATKINSON: return "DiffuseAtkinson";
        case SIXEL_DIFFUSE_FS: return "DiffuseFs";
        case SIXEL_DIFFUSE_JAJUNI: return "DiffuseJajuni";
        case SIXEL_DIFFUSE_STUCKI: return "DiffuseStucki";
        case SIXEL_DIFFUSE_BURKES: return "DiffuseBurkes";
        case SIXEL_DIFFUSE_A_DITHER: return "DiffuseADither";
        case SIXEL_DIFFUSE_X_DITHER: return "DiffuseXDither";
        default: return NULL;
    }
}

const char *
sixel_utils_quality_symbol(int quality)
{
    switch (quality) {
        case SIXEL_QUALITY_AUTO: return "QualityAuto";
        case SIXEL_QUALITY_HIGH: return "QualityHigh";
        case SIXEL_QUALITY_LOW: return "QualityLow";
        case SIXEL_QUALITY_FULL: return "QualityFull";
        case SIXEL_QUALITY_HIGHCOLOR: return "QualityHighcolor";
        default: return NULL;
    }
}

const char *
sixel_utils_builtin_symbol(int builtin)
{
    switch (builtin) {
        case SIXEL_BUILTIN_MONO_DARK: return "BuiltinMonoDark";
        case SIXEL_BUILTIN_MONO_LIGHT: return "BuiltinMonoLight";
        case SIXEL_BUILTIN_XTERM16: return "BuiltinXterm16";
        case SIXEL_BUILTIN_XTERM256: return "BuiltinXterm256";
        case SIXEL_BUILTIN_VT340_MONO: return "BuiltinVt340Mono";
        case SIXEL_BUILTIN_VT340_COLOR: return "BuiltinVt340Color";
        default: return NULL;
    }
}

const char *
sixel_utils_pixelformat_symbol(int pixelformat)
{
    switch (pixelformat) {
        case SIXEL_PIXELFORMAT_RGB555: return "PixelFormatRgb555";
        case SIXEL_PIXELFORMAT_RGB565: return "PixelFormatRgb565";
        case SIXEL_PIXELFORMAT_RGB888: return "PixelFormatRgb888";
        case SIXEL_PIXELFORMAT_BGR555: return "PixelFormatBgr555";
        case SIXEL_PIXELFORMAT_BGR565: return "PixelFormatBgr565";
        case SIXEL_PIXELFORMAT_BGR888: return "PixelFormatBgr888";
        case SIXEL_PIXELFORMAT_ARGB8888: return "PixelFormatArgb8888";
        case SIXEL_PIXELFORMAT_RGBA8888: return "PixelFormatRgba8888";
        case SIXEL_PIXELFORMAT_ABGR8888: return "PixelFormatAbgr8888";
        case SIXEL_PIXELFORMAT_BGRA8888: return "PixelFormatBgra8888";
        case SIXEL_PIXELFORMAT_G1: return "PixelFormatG1";
        case SIXEL_PIXELFORMAT_G2: return "PixelFormatG2";
        case SIXEL_PIXELFORMAT_G4: return "PixelFormatG4";
        case SIXEL_PIXELFORMAT_G8: return "PixelFormatG8";
        case SIXEL_PIXELFORMAT_AG88: return "PixelFormatAg88";
        case SIXEL_PIXELFORMAT_GA88: return "PixelFormatGa88";
        case SIXEL_PIXELFORMAT_PAL1: return "PixelFormatPal1";
        case SIXEL_PIXELFORMAT_PAL2: return "PixelFormatPal2";
        case SIXEL_PIXELFORMAT_PAL4: return "PixelFormatPal4";
        case SIXEL_PIXELFORMAT_PAL8: return "PixelFormatPal8";
        default: return NULL;
    }
}

const char *
sixel_utils_palettetype_symbol(int palettetype)
{
    switch (palettetype) {
        case SIXEL_PALETTETYPE_AUTO: return "PaletteTypeAuto";
        case SIXEL_PALETTETYPE_HLS: return "PaletteTypeHls";
        case SIXEL_PALETTETYPE_RGB: return "PaletteTypeRgb";
        default: return NULL;
    }
}

const char *
sixel_utils_encodepolicy_symbol(int encodepolicy)
{
    switch (encodepolicy) {
        case SIXEL_ENCODEPOLICY_AUTO: return "EncodePolicyAuto";
        case SIXEL_ENCODEPOLICY_FAST: return "EncodePolicyFast";
        case SIXEL_ENCODEPOLICY_SIZE: return "EncodePolicySize";
        default: return NULL;
    }
}

const char *
sixel_utils_res_symbol(int res)
{
    switch (res) {
        case SIXEL_RES_NEAREST: return "ResNearest";
        case SIXEL_RES_GAUSSIAN: return "ResGaussian";
        case SIXEL_RES_HANNING: return "ResHanning";
        case SIXEL_RES_HAMMING: return "ResHamming";
        case SIXEL_RES_BILINEAR: return "ResBilinear";
        case SIXEL_RES_WELSH: return "ResWelsh";
        case SIXEL_RES_BICUBIC: return "ResBicubic";
        case SIXEL_RES_LANCZOS2: return "ResLanczos2";
        case SIXEL_RES_LANCZOS3: return "ResLanczos3";
        case SIXEL_RES_LANCZOS4: return "ResLanczos4";
        default: return NULL;
    }
}

const char *
sixel_utils_format_symbol(int format)
{
    switch (format) {
        case SIXEL_FORMAT_GIF: return "FormatGif";
        case SIXEL_FORMAT_PNG: return "FormatPng";
        case SIXEL_FORMAT_BMP: return "FormatBmp";
        case SIXEL_FORMAT_JPG: return "FormatJpg";
        case SIXEL_FORMAT_TGA: return "FormatTga";
        case SIXEL_FORMAT_WBMP: return "FormatWbmp";
        case SIXEL_FORMAT_TIFF: return "FormatTiff";
        case SIXEL_FORMAT_SIXEL: return "FormatSixel";
        case SIXEL_FORMAT_PNM: return "FormatPnm";
        case SIXEL_FORMAT_GD2: return "FormatGd2";
        case SIXEL_FORMAT_PSD: return "FormatPsd";
        case SIXEL_FORMAT_HDR: return "FormatHdr";
        default: return NULL;
    }
}

const char *
sixel_utils_loop_symbol(int loop)
{
    switch (loop) {
        case SIXEL_LOOP_AUTO: return "LoopAuto";
        case SIXEL_LOOP_FORCE: return "LoopForce";
        case SIXEL_LOOP_DISABLE: return "LoopDisable";
        default: return NULL;
    }
}

int
sixel_utils_succeeded(int status)
{
    return SIXEL_SUCCEEDED(status);
}

int
sixel_utils_failed(int status)
{
    return SIXEL_FAILED(status);
}

#define STRUCT(n) \
extern_inline \
sixel_##n##_t ** \
sixel_utils_##n##_ptr_new(void) \
{ \
    return alloca(sizeof(sixel_##n##_t *)); \
} \
 \
sixel_##n##_t * \
sixel_utils_##n##_ptr_deref(sixel_##n##_t **ptr) \
{ \
    return *ptr; \
}

STRUCT(allocator)
STRUCT(output)
STRUCT(dither)
STRUCT(encoder)
STRUCT(decoder)
