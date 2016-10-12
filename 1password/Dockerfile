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
RUN dpkg --add-architecture i386
RUN apt-get clean && apt-get update --fix-missing
RUN apt-get install -y software-properties-common --no-install-recommends
RUN add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ xenial universe multiverse"
RUN add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ xenial-updates universe multiverse"

RUN apt-get clean && apt-get update --fix-missing
RUN apt-get install -y \
  wine1.6 \
  wine1.6-i386 \
  wine-development \
  wine-mono0.0.8 \
  wine-gecko2.21 \
  xauth \
  xvfb \
  --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

# for some reason wine-gecko2.21 did not install the 32bit version of the installer
# https://sourceforge.net/projects/wine/files/
ADD http://pilotfiber.dl.sourceforge.net/project/wine/Wine%20Gecko/2.21/wine_gecko-2.21-x86.msi /usr/share/wine/gecko/wine_gecko-2.21-x86.msi

ADD https://app-updates.agilebits.com/download/OPW4 /usr/src/1Password.exe

RUN xvfb-run -a bash -c "\
  WINEDLLOVERRIDES=mscoree=d wine /usr/src/1Password.exe /VERYSILENT && \
  wineserver -k"

ENV HOME /root
WORKDIR $HOME

CMD [ "wine", "/root/.wine/drive_c/Program Files (x86)/1Password 4/1Password.exe" ]
