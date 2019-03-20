deb:
	sudo dpkg -i packages/*.deb

setools-patch:
	cd setools; \
		git checkout 4.0.0-beta; \
		git apply ../patches/setools.patch

setools-build:
	cd setools; \
		python setup.py build

setools-install:
	cd setools; \
		sudo python setup.py install

build: deb setools-patch setools-build

install: setools-install
