FROM ubuntu:16.04

RUN set -eux; \
	apt-get update; \
	apt-get install -y \
	wget \
	gnupg2 \
	apt-transport-https \
	ca-certificates \
	curl \
	--no-install-recommends

RUN { \
		echo 'deb http://dl.google.com/linux/chrome/deb/ stable main'; \
	} > /etc/apt/sources.list.d/google-chrome.list

RUN set -eux; \
	wget https://dl-ssl.google.com/linux/linux_signing_key.pub; \
	apt-key add linux_signing_key.pub; \
	apt-get update && apt-get install -y \
	google-chrome-unstable \
	fontconfig \
	fonts-ipafont-gothic \
	fonts-wqy-zenhei \
	fonts-thai-tlwg \
	fonts-kacst \
	fonts-symbola \
	fonts-noto \
	fonts-freefont-ttf \
	--no-install-recommends

EXPOSE 9222

ADD start.sh import_cert.sh /usr/bin/

RUN mkdir /data
VOLUME /data
ENV HOME=/data DEBUG_ADDRESS=0.0.0.0 DEBUG_PORT=9222

CMD ["/usr/bin/start.sh"]
