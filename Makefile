# Tasks for APIs through 23.
deb-pre7:
	sudo dpkg -i packages/android-setools-pre7.deb

setools-patch-pre7:
	cd setools; \
		git checkout 4.0.0-beta; \
		git apply ../patches/setools-pre7.patch


# Tasks for 24+
deb:
	sudo dpkg -i packages/android-setools-7.deb

setools-patch:
	cd setools; \
		git checkout 4.1; \
		git apply ../patches/setools.patch


# Same for both.
setools-install:
	cd setools; \
		sudo python setup.py install

setools-build:
	cd setools; \
		python setup.py build


# Internal
internal-build-debs:
	cd deb-files; \
		dpkg-deb --build ./android-setools-pre7; \
		mv android-setools-pre7.deb ../packages/; \
		dpkg-deb --build ./android-setools-7; \
		mv android-setools-7.deb ../packages/


# Users run these.
build-pre7: deb-pre7 setools-patch-pre7 setools-build
build: deb setools-patch setools-build

install: setools-install

clean:
	cd setools; \
		git reset --hard
	git submodule update --init
	sudo apt remove -y android-setools*
