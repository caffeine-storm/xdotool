FROM ubuntu:24.04 as build

RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y \
		build-essential \
		libx11-dev \
		libxinerama-dev \
		libxkbcommon-dev \
		libxtst-dev \
	&& rm -rf /var/lib/apt/lists/*

COPY . /build
RUN make -C /build update-version
RUN make -C /build all install
RUN rm -rf /build

# for testing on Ubuntu, still need following packages:
#   - xterm
#   - xvfb
#   - ruby
#   ? xdpyinfo, xwininfo
CMD /usr/local/bin/xdotool
