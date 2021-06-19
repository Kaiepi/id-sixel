module Main

import Sixel

partial
main : IO ()
main = do
  Right decoder <- MkDecoder
    | Left error => putStrLn getAdditionalMessage
  Right _ <- setOpt decoder OptFlagInput "lena512.sixel"
    | Left error => putStrLn getAdditionalMessage
  Right _ <- setOpt decoder OptFlagOutput "lena512.bmp"
    | Left error => putStrLn getAdditionalMessage
  Right _ <- decode decoder
    | Left error => putStrLn getAdditionalMessage
  pure ()
