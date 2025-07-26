from build.ack import ackclibrary
from glob import glob

ackclibrary(
    name="libsys",
    plat="emu6800",
    srcs=(
        glob("plat/emu6800/libsys/*.s")
        + glob("plat/emu6800/libsys/*.c")
        + glob("plat/emu6800/libsys/*.h")
    ),
    deps=["lang/cem/libcc.ansi/headers", "plat/emu6800/include"],
)

