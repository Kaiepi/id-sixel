# Sixel

Idris 2 bindings for [libsixel](https://github.com/saitoha/libsixel/).

Refer to `examples/` for usage.

## Dependencies

Refer to [libsixel's README](https://github.com/saitoha/libsixel#install) for
instructions for your platform. Ensure `libsixel.so` (wherever it may be) is
loadable by `idris2`; if it isn't by default, append its directory to the
`IDRIS2_LIBS` environment variable.

Builds and installation of this module depend on
[cmake](https://cmake.org/install/).

## Install

```sh
$ cmake .
$ cmake --build .
$ cmake --install .
```

## Notes

- Bindings should match the level of support of those for Python. This implies
  `sixel_decode_raw` is NYI.
- In general, bindings are named after a libsixel function stripped of any
  namespace, with the exception of constructors, which are given a
  `Mk`-prefixed name, e.g. `sixel_allocator_new` becomes `MkAllocator` and
  `sixel_allocator_malloc` becomes `malloc`.
- With the exception of `Allocator`, libsixel structures are garbage collected.
  Allocators can be freed with `destroy`.
- Reference count bounds are enforced statically, so too many `unref`s will
  throw a typechecking error.
- Tested on OpenBSD -current amd64 as of 2021/06.
