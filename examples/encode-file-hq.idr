module Main

import Data.Fin
import Data.List
import System

import Sixel

partial
main : IO ()
main = do
  (_ :: filename :: _) <- getArgs
    | (script :: _) => putStrLn ("Usage: " ++ script ++ " <filename>")

  Right encoder <- MkEncoder
    | Left error => putStrLn getAdditionalMessage
  Right _ <- setOpt encoder OptFlagQuality "high"
    | Left error => putStrLn getAdditionalMessage
  Right _ <- setOpt encoder OptFlagResampling "hamming"
    | Left error => putStrLn getAdditionalMessage
  Right _ <- setOpt encoder OptFlagSelectColor "histogram"
    | Left error => putStrLn getAdditionalMessage
  Right _ <- setOpt encoder OptFlagEncodePolicy "size"
    | Left error => putStrLn getAdditionalMessage
  Right _ <- encode encoder filename
    | Left error => putStrLn getAdditionalMessage

  pure ()
