module Sixel.Helpers

import Data.Buffer

import Sixel.Library
import Sixel.Symbols
import Sixel.Allocator

%foreign (sixel "sixel_helper_get_additional_message")
sixel_helper_get_additional_message : String

%foreign (sixel "sixel_helper_set_additional_message")
sixel_helper_set_additional_message : String -> ()

%foreign (sixel "sixel_helper_format_error")
sixel_helper_format_error : Int -> String

export %inline
getAdditionalMessage : String
getAdditionalMessage = sixel_helper_get_additional_message

export %inline
setAdditionalMessage : String -> IO ()
setAdditionalMessage = pure . sixel_helper_set_additional_message

export %inline
format : Status -> String
format (MkStatus s) = sixel_helper_format_error s
