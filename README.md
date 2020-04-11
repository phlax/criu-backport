
# criu-backport


Backport recipe for the `criu` package for Debian Buster.

Requires backported version of `gnutls`, available from https://github.com/phlax/gnutls-backport

See https://github.com/checkpoint-restore/criu for information about `criu`.


## Building

Building requires `docker`. The following commands will create a `build` folder containing the built `deb` for `criu`.

You will need to install updated packages for `gnutls` before installing the built `deb`.

```

git clone https://github.com/phlax/criu-backport
cd criu-backport
make deb

```

## Usage

There are unsigned prebuilt debs available for `criu` and `gnutls` in the docker image `phlax/criu-backport`.

These can be accessed with the following command

```
mkdir criu-build
docker run \
	-v `pwd`/criu-build:/tmp/build phlax/criu-backport \
	bash -c "cp -a /usr/share/criu-backport/*deb /tmp/build"

```

The prebuilt debs are useful for testing checkpoint restore functionality.

For production use you are strongly recommended to build your own versions of `gnutls` and `criu`.
