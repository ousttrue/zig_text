from typing import Optional
import logging
import pathlib
import coloredlogs
from rawtypes.parser.header import Header, StructConfiguration
from rawtypes.parser.type_context import ParamContext
from rawtypes.interpreted_types.basetype import BaseType
from rawtypes.interpreted_types import ReferenceType
from rawtypes.generator.zig_generator import ZigGenerator

LOGGER = logging.getLogger(__name__)
HERE = pathlib.Path(__file__).absolute().parent
WORKSPACE = HERE.parent


def generate_libuv():
    HEADER = WORKSPACE / 'pkgs/libuv/deps/libuv/include/uv.h'
    ZIG = WORKSPACE / 'pkgs/libuv/src/main.zig'
    LOGGER.debug(f'{HEADER.name} => {ZIG}')
    generator = ZigGenerator(
        Header(HEADER, definitions=[
            '_WIN32=1',
            'WIN32_LEAN_AND_MEAN=1',
            '_WIN32_WINNT=0x0602',
            # 'WIN32', '_WINDOWS',
            'USING_UV_SHARED=1',
        ]),
        # Header(HEADER.parent / 'uv/win.h'),
    )
    generator.generate(ZIG)


def main():
    coloredlogs.install(level='DEBUG')
    logging.basicConfig(level=logging.DEBUG)
    generate_libuv()


if __name__ == '__main__':
    main()
