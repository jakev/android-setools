# Android setools

## About
This repo contains a bundled Debian package (`deb`) with the patched SELinux libaries (`libsepol`, `libselinux`) and supporting headers (`libbz2`) that allow SE for Android ("SEAndroid") v30 binary policy files to be parsed. In addition, it includes a `Makefile` that will build a patched version of `setools` version 4 that exposes the following SELinux utilities:

* sesearch
* sediff
* sedta

All other `setools` binaries (such as any GUI components) are _not tested_.

This project is based largely on StackOverflow user `WhiteWinterWolf`'s verbose and _extremely_ helpful write-up regarding parsing v30 Android policy files. Big thanks to `WhiteWinterWolf`; I simply bundled the code together!

**Warning:** Google made non-backwards compatible changes after API 23 ("M") which affects the underlying SELinux libraries. What this means is you'll need to make sure you build the correct version depending on which API you plan on analyzing. More on this can be found in the "Installing" section.

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
	sudo apt install make git swig flex bison python-dev python-setuptools python-networkx python-enum34

Next, clone this repo and `cd` to the directory:

	git clone --recursive https://github.com/jakev/android-setools.git
	cd android-setools

### Building for Modern APIs (7.0.0 - 9.0.0)

	make build
	sudo make install

### Building for Older APIs (Pre-7.0.0)

	make build-pre7
	sudo make install

### Cleanup

If for some reason your build fails or you need to switch versions, you can use the `clean` task to revert to a clean slate:

	make clean
	...

## Usage
After installing, you can use `seinfo` or `sesearch` to perform queries against a device's `sepolicy` file:

	adb pull /sepolicy
	sesearch -A -s shell -c file -p write sepolicy

## Known Limitations
Only 1 version (either pre7 or post7) of `setools` can be installed a given time. I don't see an easy way around this, so the best way to handle this situation is to remove the old and rebuild the new version. For example, if you had the "new" API version installed, but wanted to analyze an old `sepolicy`, you can run the following commands:

	cd android-setools
	make clean build-pre7
	sudo make install
