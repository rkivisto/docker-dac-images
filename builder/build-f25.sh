#!/bin/bash -ex

HERE=$(dirname "$0")

# We don't install packages with Ansible, it's much faster directly
dnf install -y \
  java-1.8.0-openjdk java-1.8.0-openjdk-devel \
  postfix \
  jq curl wget gnupg rsync \
  git cvs bzr mercurial subversion \
  bind-utils \
  rpm-build dpkg dpkg-devel fakeroot \
  python-devel python-setuptools python-virtualenv \
  pylint python-coverage python3-coverage \
  chromium chromedriver firefox tigervnc-server x11vnc xorg-x11-server-Xvfb \
  asciidoc pandoc ImageMagick \
  bison flex byacc \
  clang clang-analyzer doxygen cmake yasm \
  cppunit cppunit-devel boost-test gtest valgrind \
  docbook-dtds docbook-style-xsl docbook5-style-xsl docbook-simple \
  graphviz \
  openvpn \
  uuid-devel libuuid-devel \
  ansible

dnf builddep -y ruby php nodejs python2 python3 redis postgresql

cd "$HERE/playbook"
ansible-playbook build-agent-template.yml
