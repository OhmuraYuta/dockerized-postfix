FROM debian:bookworm-slim
RUN apt-get update &&\
	apt-get upgrade -y &&\
	apt-get install -y locales &&\
	locale-gen ja_JP.UTF-8 &&\
	echo "export LANG=ja_JP.UTF-8" >> ~/.bashrc
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y postfix mailutils
RUN apt-get install -y sasl2-bin
RUN apt-get install -y telnet dnsutils
COPY saslauthd /etc/default/saslauthd
COPY main.cf /etc/postfix/main.cf
COPY resolv.conf /var/spool/postfix/etc/resolv.conf
CMD ["postfix", "start-fg"]
