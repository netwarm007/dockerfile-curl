FROM tim03/ubuntu
MAINTAINER Chen, Wenli <chenwenli@chenwenli.com>
RUN apt-get -qq update && apt-get install -qqy --no-install-recommends \
		ca-certificates \
		curl \
		wget \
        && apt-get -y autoremove \
        && apt-get clean \
	&& rm -rf /var/lib/apt/lists/*
