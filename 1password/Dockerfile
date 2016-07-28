# Run 1Password4 (for windows) via Wine in a container
#
# (assuming you've done the `xhost +local:root` trick)
#
# docker run -it --name 1password \
#  -v /tmp/.X11-unix:/tmp/.X11-unix \
#  -v $HOME/Dropbox:/root/Dropbox \
#  -e DISPLAY=unix$DISPLAY

FROM ubuntu:16.04
MAINTAINER John Nagro <john.nagro@gmail.com>

# install wine
run dpkg --add-architecture i386
RUN apt-get clean && apt-get update --fix-missing
RUN apt-get install -y \
  wine1.6 \
  wine1.6-i386 \
  --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

# https://d13itkw33a7sus.cloudfront.net/dist/1P/win4/1Password-4.6.0.604.exe
ADD https://d13itkw33a7sus.cloudfront.net/dist/1P/win4/1Password-4.6.0.604.exe /usr/src/1Password-4.6.0.604.exe

COPY run.sh /root

ENV HOME /root
WORKDIR $HOME

# CMD [ "bash" ]
ENTRYPOINT ["/root/run.sh"]
