#!/bin/bash
#
echo "updating git..."
yum -y groupinstall "Development Tools"
yum -y install zlib-devel perl-ExtUtils-MakeMaker asciidoc xmlto openssl-devel
yum -y curl-devel

cd ~
wget -O v1.8.5.5.tar.gz https://github.com/git/git/archive/v1.8.5.5.tar.gz
tar -xzvf ./v1.8.5.5.tar.gz
cd git-1.8.5.5
make configure
./configure --prefix=/usr/local
make all doc
make install install-doc install-html