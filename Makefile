#!/usr/bin/make -f

SHELL := /bin/bash


deb:
	mkdir -p build
	chmod -R 777 build
	docker run -ti -v `pwd`/build:/home/bob phlax/debian-build bash -c "\
	  sudo apt-get -y -qq build-dep -t sid criu \
	  && apt source -t sid criu \
	  && cd ~/criu-*/ \
	  && export DEBFULLNAME=\"Bob the builder\" \
	  && dch --bpo \"Adding backport!\" \
	  && dpkg-buildpackage -us -uc"

docker: deb
	docker run -v `pwd`/gnutls-build:/tmp/build phlax/gnutls-backport bash -c "cp -a /usr/share/gnutls-backport/* /tmp/build"
	cp -a gnutls-build/*deb build
	docker run --name=criu -v `pwd`/build:/tmp/build debian:buster-slim bash -c "\
		ls /tmp/build -lh \
		&& mkdir -p /usr/share/criu-backport \
		&& cp -a /tmp/build/* /usr/share/criu-backport/ \
		&& apt update \
		&& apt install -y /tmp/build/libtasn1-6_*deb \
		&& apt install -y /tmp/build/libffi7_*deb \
		&& apt install -y /tmp/build/libp11-kit0_*deb \
		&& apt install -y /tmp/build/libnettle7_*deb \
		&& apt install -y /tmp/build/libhogweed5_*deb \
		&& apt install -y /tmp/build/libgnutls30_*deb \
		&& apt install -y /tmp/build/criu_*deb"
	docker commit criu phlax/criu-backport

hub-image:
	docker push phlax/criu-backport
