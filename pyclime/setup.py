from distutils.core import setup, Extension
import numpy as np
import numpy.distutils.misc_util
from Cython.Distutils import build_ext
import platform

if platform.system() == 'Darwin':
    extra_compile_args = [
        '-I/System/Library/Frameworks/vecLib.framework/Headers'
    ]
    if 'ppc' in platform.machine():
        extra_compile_args.append('-faltivec')

    extra_link_args = ["-Wl,-framework", "-Wl,Accelerate"]
    include_dirs = [numpy.get_include()]

else:
    include_dirs = [numpy.get_include(), "/usr/local/include"]
    extra_compile_args = ['-msse2', '-O2', '-fPIC', '-w']
    extra_link_args = ["-llapack"]

parametric_module = Extension(
    name="parametric",
    sources=["parametric.c",
            "_parametric.pyx",
            "lu.c",
            "tree.c",
            "linalg.c",
            "heap.c"
            ],
    include_dirs=include_dirs,
    extra_compile_args=extra_compile_args,
    extra_link_args=extra_link_args,
    language="c"
)

dantzig_module = Extension(
    name="dantzig",
    sources=["dantzig.c",
            "_dantzig.pyx",
            "lu.c",
            "linalg.c"
            ],
    include_dirs=include_dirs,
    extra_compile_args=extra_compile_args,
    extra_link_args=extra_link_args,
    language="c"
)

if __name__ == "__main__":
    setup(
        name = 'pyclime',
        version = '1.0',
        description = 'Cython wrapper for fastclime package',
        author = 'Manjari Narayan',
        author_email = 'mnarayan@noreply.users.github.com',
        cmdclass={'build_ext': build_ext},
        ext_modules=[parametric_module,dantzig_module],
    )