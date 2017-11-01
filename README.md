# libhdfs3-deb
Steps to produce a .deb that can be installed dpkg for libhdfs3 (for use with python)

The script 'build-libhdfs3-deb.sh' works, but only with Ubuntu Xenial x86-64.

The debian file will end up in /tmp

This command was used to install dependencies on Xenial for this package:

    sudo apt-get install -y libasn1-8-heimdal libc6 libcomerr2 libcurl3 libffi6 libgcc1 libgmp10 libgnutls30 libgsasl7 libgssapi-krb5-2 libgssapi3-heimdal libhcrypto4-heimdal libheimbase1-heimdal libheimntlm0-heimdal libhogweed4 libhx509-5-heimdal libicu55 libidn11 libk5crypto3 libkeyutils1 libkrb5-26-heimdal libkrb5-3 libkrb5support0 libldap-2.4-2 liblzma5 libnettle6 libntlm0 libp11-kit0 libroken18-heimdal librtmp1 libsasl2-2 libsqlite3-0 libssl1.0.0 libstdc++6 libtasn1-6 libuuid1 libwind0-heimdal libxml2 zlib1g

On Trusty:

    sudo apt-get -y install libasn1-8-heimdal libc6 libcomerr2 libcurl3 libffi6 libgcc1 libgcrypt11 libgnutls26 libgpg-error0 libgsasl7 libgssapi3-heimdal libgssapi-krb5-2 libhcrypto4-heimdal libheimbase1-heimdal libheimntlm0-heimdal libhx509-5-heimdal libidn11 libk5crypto3 libkeyutils1 libkrb5-26-heimdal libkrb5-3 libkrb5support0 libldap-2.4-2 liblzma5 libntlm0 libp11-kit0 libroken18-heimdal librtmp0 libsasl2-2 libsqlite3-0 libssl1.0.0 libstdc++6 libtasn1-6 libuuid1 libwind0-heimdal libxml2 zlib1g
