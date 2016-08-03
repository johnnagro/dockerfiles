# Run letsencrypt in a container
#
# docker run -it --rm  \
#   -v /etc/localtime:/etc/localtime:ro \
#   -v $HOME/ownCloud/letsencrypt:/etc/letsencrypt \
#   johnnagro/letsencrypt "$@"

FROM ubuntu:16.04
MAINTAINER John Nagro <john.nagro@gmail.com>

RUN apt-get clean && apt-get update
RUN apt-get install -y letsencrypt

ENTRYPOINT [ "letsencrypt" ]
