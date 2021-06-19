module Sixel.Library

import Data.Buffer

public export
c : String -> String
c symbol = "C:" ++ symbol ++ ",libc"

public export
sixel : String -> String
sixel symbol = "C:" ++ symbol ++ ",libsixel"

public export
sixelutils : String -> String
sixelutils symbol = "C:" ++ symbol ++ ",libsixelutils"

%foreign (sixelutils "sixel_utils_is_concrete")
sixel_utils_is_concrete : Ptr t -> Int

%foreign (sixelutils "sixel_utils_is_concrete")
sixel_utils_is_concrete_any : AnyPtr -> Int

export
prim__isConcrete : Ptr t -> Bool
prim__isConcrete = intToBool . sixel_utils_is_concrete

export
prim__isConcreteAny : AnyPtr -> Bool
prim__isConcreteAny = intToBool . sixel_utils_is_concrete_any

export
%foreign (sixelutils "sixel_utils_pointer_cast")
prim__toString : Ptr t -> String

export
%foreign (sixelutils "sixel_utils_pointer_cast")
prim__toStringAny : AnyPtr -> String

export
%foreign (sixelutils "sixel_utils_buffer_null")
prim__getNullBuffer : Buffer
