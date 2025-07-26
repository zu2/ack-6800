from build.ab import export
from build.ack import ackcfile, exportheaders
from mach.proto.cg.build import build_cg
from build.ab import Rule, export
import importlib

@Rule
def build_custom_plat_libs(self, name, arch, plat):
    export(
        replaces=self,
        items={
            "$(PLATIND)/emu6800/libend.a": "mach/mc6800/libend+lib_emu6800",
            "$(PLATIND)/emu6800/libem.a": "mach/mc6800/libem+lib_emu6800",
            "$(PLATIND)/emu6800/libmon.a": "mach/mc6800/libmon+lib_emu6800",
        },
        deps=[
        ],
    )



build_as = importlib.import_module("mach.proto.as.build").build_as

cflags = ["-DMC6800"]

build_as(name="as", arch="mc6800")
build_cg(name="cg", arch="mc6800")
build_custom_plat_libs(name="my_plat_libs", arch="mc6800", plat="emu6800")

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
        "$(PLATIND)/emu6800/libend.a": "mach/mc6800/libend+lib_emu6800",
        "$(PLATIND)/emu6800/libem.a": "mach/mc6800/libem+lib_emu6800",
        "$(PLATIND)/emu6800/libmon.a": "mach/mc6800/libmon+lib_emu6800",

    }
    | exportheaders("./include", prefix="$(PLATIND)/emu6800/include"),
    deps=[".+tools", "util/ack+all"],
)
