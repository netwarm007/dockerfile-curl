FROM tim03/openssl-ca-certification
LABEL maintainer Chen, Wenli <chenwenli@chenwenli.com>

WORKDIR /usr/src
COPY md5sums .
ADD https://curl.haxx.se/download/curl-7.52.1.tar.lzma .
RUN md5sum -c md5sums
ADD http://www.linuxfromscratch.org/patches/blfs/8.0/curl-7.52.1-valgrind_filter-1.patch .
RUN \
	tar xvf curl-7.52.1.tar.lzma && \
	mv -v curl-7.52.1 curl && \
	cd curl && \
	cat ../curl-7.52.1-valgrind_filter-1.patch | patch -p1 && \
	./configure --prefix=/usr                           \
	            --disable-static                        \
	            --enable-threaded-resolver              \
	            --with-ca-path=/etc/ssl/certs && \
	make -j"$(nproc)" && \
	make install && \
	rm -rf docs/examples/.deps && \
	find docs \( -name Makefile\* \
	          -o -name \*.1       \
	          -o -name \*.3 \)    \
	          -exec rm {} \;      && \
	install -v -d -m755 /usr/share/doc/curl-7.52.1 && \
	cp -v -R docs/*     /usr/share/doc/curl-7.52.1 && \
	cd /usr/src && \
	rm -rf curl

