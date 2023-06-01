# A simple test for interworking veneers

This is a simple program that contains interworking, and with a sufficient compilation optimization level does tail call optimization. In that case a linker must emit a trampoline to do the switching between ISA's. This repository contains a minimal example to compare emitted veneers between llvm.lld and binutils.ld (from vitasdk fork).

You don't need this repository, go away.
The original problem (that happened on vita) is solved by forcing the linker to emit veneers in a position independent way by adding `-Wl,--pic-veneer` linker flag.
