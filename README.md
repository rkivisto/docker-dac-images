# DEV@cloud agent image

This repository contains sources to build Docker images reproducing the build agent images used on DEV@cloud.
It is here to help people migrate off DEV@cloud service, which will be terminated on December 15th 2018.

To build the Fedora 25 image, run:

    docker build -t dac-f25 -f Dockerfile.f25 .

To build the Fedora 25 image with Android bits, run:

    docker build -t dac-android -f Dockerfile.android .

Builds should run with `jenkins` user under `/workspace`.

## Limitations

DEV@cloud plugin providing pre-installed tools is not available in backup archives.
As such, tools like Maven or Oracle JDK are not pre-installed in this image.
Only tools installed as system packages are available (like Git, Subversion, system OpenJDK and so on)

You will need to reconfigure Jenkins to automatically install such tools on first use.

Note that Android SDK is available if image was built using `Dockerfile.android`.