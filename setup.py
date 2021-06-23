import os

from setuptools import (
    find_packages,
    setup
)

with open(os.path.join('requirements.txt'), 'r') as f:
    REQUIRED_PACKAGES = f.readlines()

PACKAGES = find_packages()

packages = [x for x in PACKAGES
            if x not in {'tests'}]

setup(
    name='elife_data_hub_utils',
    version='0.0.1',
    install_requires=REQUIRED_PACKAGES,
    packages=packages,
    description='Elife Data Hub Utils',
)
