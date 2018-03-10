FROM ubuntu:xenial
RUN apt-get update
RUN apt-get install -y lsb-release wget bzip2 rsync
WORKDIR /root
COPY . libhdfs3-deb/
WORKDIR /root/libhdfs3-deb
RUN /bin/bash ./build-libhdfs3-deb.sh
CMD /bin/bash -c 'cp -v /tmp/*.deb /root/dist'
