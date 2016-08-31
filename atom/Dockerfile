FROM ubuntu:16.04
MAINTAINER John Nagro <john.nagro@gmail.com>

RUN apt-get clean && apt-get update
RUN apt-get install -y \
	git \
	gconf2 \
	gconf-service \
	libgl1-mesa-dri \
	libgl1-mesa-glx \
	libasound2 \
	libgtk2.0-0 \
	libnotify4 \
	libxtst6 \
	libnss3 \
	python \
	gvfs-bin \
	xdg-utils \
	unity-gtk-module-common \
	dbus-x11 \
	unity8 \
	libcanberra-gtk-module \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

ENV ATOM_VERSION 1.10.0

ADD https://github.com/atom/atom/releases/download/v${ATOM_VERSION}/atom-amd64.deb /tmp/atom-amd64.deb

RUN dpkg -i /tmp/atom-amd64.deb

# Autorun atom
ENTRYPOINT [ "atom", "--foreground" ]
