from build.ab import export
from build.ack import ackcfile, exportheaders
from mach.proto.cg.build import build_cg
#from plat.build import build_plat_libs
import importlib

build_as = importlib.import_module("mach.proto.as.build").build_as

cflags = ["-DMC6800"]

build_as(name="as", arch="6800")
build_cg(name="cg", arch="6800")
#build_plat_libs(name="plat_libs", arch="6800", plat="emu6800")

ackcfile(name="boot", srcs=["./boot.s"], plat="emu6800", cflags=cflags)

export(
    name="tools",
    items={
        "$(PLATDEP)/emu6800/as$(EXT)": ".+as",
        "$(PLATDEP)/emu6800/cg$(EXT)": ".+cg",
        "$(PLATIND)/descr/emu6800": "./descr",
    },
)

export(
    name="all",
    items={
        "$(PLATIND)/emu6800/boot.o": ".+boot",
    }
    | exportheaders("./include", prefix="$(PLATIND)/emu6800/include"),
    deps=[".+tools", "util/ack+all"],
)
