# buildroot-rpi-playground
Buildroot based Raspberry Pi playground

## Version
Based on buildroot 2024.02, last updated 2024.03.18

## Clone repository with submodules
You must clone this project with
```
git clone --recursive https://github.com/schenkmi/buildroot-rpi-playground.git
```

## Build instructions plain Linux

### Raspberry Pi Zero W

```
cd buildroot-rpi-playground
mkdir -p build-rpi0w && cd build-rpi0w
make -C ../buildroot O="$(pwd)" BR2_EXTERNAL="../buildroot-external" rpi0w_defconfig
make
```

### Raspberry Pi Zero 2 W

```
cd buildroot-rpi-playground
mkdir -p build-rpi02w && cd build-rpi02w
make -C ../buildroot O="$(pwd)" BR2_EXTERNAL="../buildroot-external" rpi02w_defconfig
make
```

### Raspberry Pi 3B, 3B+, 3A+

```
cd buildroot-rpi-playground
mkdir -p build-rpi3 && cd build-rpi3
make -C ../buildroot O="$(pwd)" BR2_EXTERNAL="../buildroot-external" rpi3_defconfig
make
```

## Build instructions using Docker

The first step is to build the Docker image and create a container. You can specify a directory in your hosts system which will be mounted inside the container. This allows you to copy the built system easily. The current directory must contain the provided Dockerfile which will be compiled into an image. The directory called `build` will contain the sources and the images which will be built later.
```
docker build -t buildroot-rpi-playground .
docker create -it --name buildroot-rpi-playground --mount type=bind,source="$(pwd)",destination=/home/br-user/buildroot-rpi-playground buildroot-rpi-playground
```

You can start the container if it was created successfully. This command gives you an interactive shell inside the container.
```
docker start -ia buildroot-rpi-playground
```

The next step is to create a build directory called `out` which will contain the downloaded package source files and the output images. We will use this directory for an out-of-tree Buildroot build, by adding the `O=` parameter to the make command. We have to specify the directories where the external trees are stored, which can be done by adding the `BR2_EXTERNAL=` parameter to make (We can specify multiple directories by using `:` as a separator). The default config file is called `rpi3_defconfig` which is inside the `configs` directory.
```
cd buildroot-rpi-playground
mkdir -p out && cd out
make -C ../buildroot O="$(pwd)" BR2_EXTERNAL="../buildroot-external" rpi0w_defconfig
```

After the configuration has been finalized you can issue the make command to start building the sources. This can take a long time, so be patient.
```
make
```

## Menuconfig
Precondition: you are inside out/ folder
```
make -C ../buildroot O="$(pwd)" BR2_EXTERNAL="../buildroot-external" menuconfig
```

## Update default configuration
```
make -C ../buildroot O="$(pwd)" BR2_EXTERNAL="../buildroot-external" update-defconfig
```

## Build an SDK
```
make -C ../buildroot O="$(pwd)" BR2_EXTERNAL="../buildroot-external" sdk
```

## Flashing
Please change /dev/sdX with the correct mounting point of your sd card.
```
sudo umount /dev/sdX?*
sudo dd if=images/sdcard.img of=/dev/sdX bs=1M conv=fdatasync status=progress
```

## Console log
```
sudo picocom -b 115200 /dev/ttyUSB0
```

## Tips & Tricks


### WPA password as hash
```
wpa_passphrase
```
/etc/wpa_supplicant.conf
```
country=CH
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
network={
        ssid="SNK-2.4G"
        psk=d4faa7fbcc7410b21b0e507823c1b0ff5cba171b151af4f26cc1a248485b025c
        key_mgmt=WPA-PSK
}
```

### Re-build u-boot
To re-build u-boot we need to build u-boot and arm-trusted-firmware
```
cd out
rm -rf build/uboot-2021.07/
rm -rf build/arm-trusted-firmware-v2.7/
make
```

### Prune all docker images
```
docker system prune -a
```


