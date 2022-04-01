# -*- coding: utf-8 -*-
# @Time    : 2021/11/17 10:00 下午
# @Author  : Jiaming Zhang
# @FileName: Setup.py
# @Github  ：https://github.com/CharmingZh

from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext

setup(
    cmdclass = {'build_ext': build_ext},
    ext_modules = [Extension("lic_internal", ["lic_internal.pyx"])]
)

