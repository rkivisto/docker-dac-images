#!/bin/bash

HERE="$(dirname "$0")"

dnf install -y expect

cd /opt/android

wget --output-document=android-sdk.tgz --continue https://dl.google.com/android/android-sdk_${ANDROID_SDK_VERSION}-linux.tgz && \
  tar xzf android-sdk.tgz && \
  rm -f android-sdk.tgz

# Setup environment
export ANDROID_HOME=/opt/android/android-sdk-linux
export PATH="${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools"

# list created with /opt/android/android-sdk-linux/tools/android list sdk -e -a|grep "^id:"
# we want everything but system images, they are way too big!
ANDROID_PACKAGES=(
platform-tools
tools
build-tools-24.0.1
build-tools-24.0.0
build-tools-23.0.3
build-tools-23.0.2
build-tools-23.0.1
build-tools-23.0.0
build-tools-22.0.1
build-tools-22.0.0
build-tools-21.1.2
build-tools-21.1.1
build-tools-21.1.0
build-tools-21.0.2
build-tools-21.0.1
build-tools-21.0.0
build-tools-20.0.0
build-tools-19.1.0
build-tools-19.0.3
build-tools-19.0.2
build-tools-19.0.1
build-tools-19.0.0
build-tools-18.1.1
build-tools-18.1.0
build-tools-18.0.1
build-tools-17.0.0
build-tools-24.0.1
build-tools-24.0.0
build-tools-23.0.3
build-tools-23.0.2
build-tools-23.0.1
build-tools-23.0.0
build-tools-22.0.1
build-tools-22.0.0
build-tools-21.1.2
build-tools-21.1.1
build-tools-21.1.0
build-tools-21.0.2
build-tools-21.0.1
build-tools-21.0.0
build-tools-20.0.0
build-tools-19.1.0
build-tools-19.0.3
build-tools-19.0.2
build-tools-19.0.1
build-tools-19.0.0
build-tools-18.1.1
build-tools-18.1.0
build-tools-18.0.1
build-tools-17.0.0
android-24
android-23
android-22
android-21
android-20
android-19
android-18
android-17
android-16
android-15
android-14
android-13
android-12
android-11
android-10
android-9
android-8
android-7
addon-google_apis-google-23
addon-google_apis-google-22
addon-google_apis-google-21
addon-google_apis-google-19
addon-google_apis-google-18
addon-google_apis-google-17
addon-google_apis-google-16
addon-google_apis-google-15
addon-google_apis-google-14
addon-google_apis-google-13
addon-google_apis-google-12
addon-google_apis-google-11
addon-google_apis-google-10
addon-google_apis-google-9
addon-google_apis-google-8
addon-google_apis-google-7
addon-google_apis-google-6
addon-google_apis-google-5
addon-google_apis-google-4
addon-google_apis-google-3
extra-android-m2repository
extra-android-support
extra-google-admob_ads_sdk
extra-google-analytics_sdk_v2
extra-google-auto
extra-google-gcm
extra-google-google_play_services_froyo
extra-google-google_play_services
extra-google-m2repository
extra-google-market_apk_expansion
extra-google-market_licensing
extra-google-play_billing
extra-google-simulators
extra-google-webdriver
)

function join { local IFS="$1"; shift; echo "$*"; }
PACKAGE_LIST=$(join , ${ANDROID_PACKAGES[@]})

"$HERE/accept-licenses" "android update sdk --no-ui --all --filter platform-tools"
"$HERE/accept-licenses" "android update sdk --no-ui --all --filter tools"
"$HERE/accept-licenses" "android update sdk --no-ui --all --force --filter $PACKAGE_LIST"

# Remove all samples, docs and sources
rm -rf "$ANDROID_HOME/samples/*"  "$ANDROID_HOME/docs/*"  "$ANDROID_HOME/sources/*"
