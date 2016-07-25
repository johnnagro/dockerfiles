FROM ubuntu:16.04
MAINTAINER John Nagro <john.nagro@gmail.com>

RUN apt-get clean && apt-get update
RUN apt-get install -y \
	torbrowser-launcher

ENTRYPOINT [ "torbrowser-launcher" ]
