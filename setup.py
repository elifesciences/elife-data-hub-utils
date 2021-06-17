import os

from setuptools import (
    find_packages,
    setup
)


packages = [x for x in find_packages()
            if x not in {'tests'}]

setup(
    name='elife_data_hub_utils',
    version='0.0.1',
    install_requires=[],
    packages=packages,
    description='Elife Data Hub Utils',
)
