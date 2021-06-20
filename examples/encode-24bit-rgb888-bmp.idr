module Main

import Data.Buffer
import System.File

import Sixel
import Sixel.Library

%foreign (c "fwrite")
fwrite : (buf : AnyPtr) -> (size : Int) -> (elems : Int) -> (file : AnyPtr) -> PrimIO Int

||| Writer callback for sixel_output_new.
writer : (buf : AnyPtr) -> (size : Int) -> (priv : AnyPtr) -> PrimIO Int
writer buf size priv = fwrite buf 1 size priv

||| Get the FILE* handle of an Idris file.
getHandle : File -> FilePtr
getHandle (FHandle fh) = fh

||| Swaps the endianness of a buffer.
swap : Buffer -> IO ()
swap buf = if !(getByte buf 7) == 0xFF then pure () else do
  size <- rawSize buf
  go buf 0 (size - 1)
  where go : Buffer -> Int -> Int -> IO ()
        go buf start end =
          if start >= end
             then pure ()
             else do
               first <- getBits8 buf start
               last  <- getBits8 buf end
               setBits8 buf end first
               setBits8 buf start last
               go buf (start + 1) (end - 1)

||| Frees unmanaged memory for main.
cleanup : List Buffer -> IO ()
cleanup bufs = do
  _ <-  traverse freeBuffer bufs
  pure ()

||| File input.
filename : String
filename = "sample_1920×1280.bmp"

main : IO ()
main = do
  Right image <- createBufferFromFile filename
    | Left error => putStrLn ("Could not open sample bitmap: " ++ show error)

  offset <- cast {to=Int} <$> getBits32 image 14
  width  <- cast {to=Int} <$> getBits32 image 18
  height <- cast {to=Int} <$> getBits32 image 22

  Just (header, pixels) <- splitBuffer image offset
    | Nothing => cleanup [image] >> putStrLn ("Could not extract pixel data from " ++ filename)
  swap pixels

  Right output <- MkOutput writer {priv=getHandle stdout}
    | Left error => cleanup [pixels, header, image] >> putStrLn getAdditionalMessage
  Right dither <- MkDither {ncolors=256}
    | Left error => cleanup [pixels, header, image] >> putStrLn getAdditionalMessage
  Right _ <- initialize dither pixels width height PixelFormatRgb888 LargeNorm RepAverageColors QualityFull
    | Left error => cleanup [pixels, header, image] >> putStrLn getAdditionalMessage
  Right _ <- encode pixels width height 1 dither output
    | Left error => cleanup [pixels, header, image] >> putStrLn getAdditionalMessage

  cleanup [pixels, header, image]
