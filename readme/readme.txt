2024.03.18
----------
Fresh start
Buildroot: 2024.02

Add submodule
-------------
git submodule add https://gitlab.com/buildroot.org/buildroot.git buildroot
cd buildroot
git tag --list | grep 2024
git checkout 2024.02
cd ..
git  commit -m "update to 2024.02" buildroot

GIT submodule and branch
------------------------
If working with a branch we may update the submodule like this
git submodule update --init

GIT tag
-------
git tag -m "update to buildroot 2020.05, using FIT Image" V1.1.0
git push --tags

GIT submodul
------------
git pull --recurse-submodules
git submodule update --recursive --remote
cd buildroot
git tag --list | grep 2023
git checkout 2023.11
cd ..
git  commit -m "update to 2023.11" buildroot

gitk compare tags
-----------------
gitk tags/2020.05..tags/2020.08

update buildroot def config
---------------------------
make update-defconfig

rebuild u-boot (dtb change)
---------------------------
make uboot-dirclean && make uboot

rebuild uboot-env
-----------------
cd out/images
../host/bin/mkenvimage -s 0x4000 -o uboot-env.bin ../../board/rpi3/uboot.env.txt
