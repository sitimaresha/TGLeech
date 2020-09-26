FROM python:3.8-slim-buster

WORKDIR /app

COPY . .

ENV LANG C.UTF-8 \
	DEBIAN_FRONTEND=noninteractive

RUN apt -qq update \
	&& apt -qq install -y --no-install-recommends \
		curl \
		wget \
		unzip \
		tar \
		ffmpeg \
		gnupg2 \
	&& wget -qO - https://ftp-master.debian.org/keys/archive-key-10.asc | apt-key add - \
	&& echo deb http://deb.debian.org/debian buster main contrib non-free | tee -a /etc/apt/sources.list \
	&& apt -qq update \
	&& apt -qq install -y --no-install-recommends unrar \
	&& pip install --no-cache-dir -r requirements.txt \
	#&& apt remove --purge git \
	&& apt clean autoclean \
	&& apt autoremove -y \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN bash setup.sh \
	&& cd /app \
	&& rm -rf rclone-* \
	&& wget -q https://github.com/P3TERX/aria2.conf/raw/master/dht.dat \
	&& wget -q https://github.com/P3TERX/aria2.conf/raw/master/dht6.dat

CMD ["bash","bot.sh"]
