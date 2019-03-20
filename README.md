# Android setools

## About
This repo contains a bundled Debian package (`deb`) with the patched SELinux libaries (`libsepol`, `libselinux`) and supporting headers (`libbz2`) that allow SE for Android ("SEAndroid") v30 binary policy files to be parsed. In addition, it includes a `Makefile` that will build a patched version of `setools` version 4.0.0 that exposes the following SELinux utilities:

* sesearch
* sediff
* sedta

All other `setools` binaries (such as any GUI components) are _not tested_.

This project is based largely on StackOverflow user `WhiteWinterWolf`'s verbose and _extremely_ helpful write-up regarding parsing v30 Android policy files. Big thanks to `WhiteWinterWolf`; I simply bundled the code together!

## Supported Platforms
Building has been testing on:

* Ubuntu 14.04.5 LTS (the recommended distro/version for build AOSP)
* Ubuntu 18.04.1 LTS

You'll also need the following core components:

* make
* git
* python2.7 (python3 is untested)
* gcc (versions 4.8.4 - 7.3.0 have been tested)

## Installing
First, install dependences:

	sudo apt update
	sudo apt install make git swig flex bison python-dev python-setuptools python-networkx

Next, clone this repo and use the bundled `Makefile` to build and install:

	git clone --recursive https://github.com/jakev/android-setools.git
	cd android-setools
	make build
	sudo make install

If for some reason your build fails, consider using the `clean` task to revert to a clean slate:

	make clean
	...

## Usage
After installing, you can use `seinfo` or `sesearch` to perform queries against a device's `sepolicy` file:

	adb pull /sepolicy
	sesearch -A -s shell -c file -p write sepolicy

## Known Limitations
Currently, only Android 6.0.0 `sepolicy` files have been tested. If you're using 8.0.0+, this tool will likely not work. Newer versions will work against this version.
