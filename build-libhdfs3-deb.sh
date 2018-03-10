#!/bin/bash
set -e

os_release=$(lsb_release -sc)
if [ "$os_release" != trusty ] && [ "$os_release" != xenial ] ; then
    echo "only ubuntu trusty (14.04) or xenial (16.04) are supported (you are on $os_release)"
    exit 1
fi

platform=$(uname -i)
if [ "$platform" != x86_64 ] ; then
    echo "only x86_64 is supported (you are on $platform)"
    exit 1
fi

workdir=$(mktemp -d)
cd $workdir
wget -q https://repo.continuum.io/miniconda/Miniconda3-4.4.10-Linux-x86_64.sh
echo '0c2e9b992b2edd87eddf954a96e5feae86dd66d69b1f6706a99bd7fa75e7a891  Miniconda3-4.4.10-Linux-x86_64.sh' | sha256sum -c - || exit 1

bash Miniconda3-4.4.10-Linux-x86_64.sh -b -p ./miniconda -u
./miniconda/bin/conda install -y -c conda-forge libhdfs3
mkdir -p libhdfs3_1-1/usr/lib/x86_64-linux-gnu/
rsync -l ./miniconda/lib/libprotobuf.so.* ./libhdfs3_1-1/usr/lib/x86_64-linux-gnu/
rsync -l ./miniconda/lib/libhdfs3.so* ./libhdfs3_1-1/usr/lib/x86_64-linux-gnu/

# create metadata items for .deb package
if [ "$os_release" = "xenial" ] ; then
    depends="libasn1-8-heimdal, libc6, libcomerr2, libcurl3, libffi6, libgcc1, libgmp10, libgnutls30, libgsasl7, libgssapi-krb5-2, libgssapi3-heimdal, libhcrypto4-heimdal, libheimbase1-heimdal, libheimntlm0-heimdal, libhogweed4, libhx509-5-heimdal, libicu55, libidn11, libk5crypto3, libkeyutils1, libkrb5-26-heimdal, libkrb5-3, libkrb5support0, libldap-2.4-2, liblzma5, libnettle6, libntlm0, libp11-kit0, libroken18-heimdal, librtmp1, libsasl2-2, libsqlite3-0, libssl1.0.0, libstdc++6, libtasn1-6, libuuid1, libwind0-heimdal, libxml2, zlib1g"
else # trusty
    depends="libasn1-8-heimdal, libc6, libcomerr2, libcurl3, libffi6, libgcc1, libgcrypt11, libgnutls26, libgpg-error0, libgsasl7, libgssapi3-heimdal, libgssapi-krb5-2, libhcrypto4-heimdal, libheimbase1-heimdal, libheimntlm0-heimdal, libhx509-5-heimdal, libidn11, libk5crypto3, libkeyutils1, libkrb5-26-heimdal, libkrb5-3, libkrb5support0, libldap-2.4-2, liblzma5, libntlm0, libp11-kit0, libroken18-heimdal, librtmp0, libsasl2-2, libsqlite3-0, libssl1.0.0, libstdc++6, libtasn1-6, libuuid1, libwind0-heimdal, libxml2, zlib1g"
fi
mkdir libhdfs3_1-1/DEBIAN
cat >libhdfs3_1-1/DEBIAN/control <<EOF
Package: libhdfs3
Version: 1-1
Section: utils
Priority: optional
Architecture: amd64
Depends: $depends
Maintainer: James Kafader <jkafader@archive.org>
Description: Binary package for libhdfs3
 Package to avoid having to install anaconda/miniconda and competing python installations.
EOF

dpkg-deb --build libhdfs3_1-1
dest="/tmp/libhdfs3_1-1-$os_release-$platform.deb"
mv libhdfs3_1-1.deb $dest
cd /tmp
rm -R $workdir
echo "built deb file: $dest"
