# Data Science Tool set in a Container
# docker run -v `pwd`:/data -it appsecco/data-science-toolbox sh

FROM alpine:latest as stage1
LABEL MAINTAINER="alucab"

#RUN apk --no-cache add py-pip groff bash bc git curl \
#		coreutils imagemagick findutils grep man \
#		less parallel p7zip nodejs-lts sudo \
#		sed tar tree unrar unzip jq

#RUN pip install awscli nose bigmler csvkit \
#   && npm install -g cowsay json2csv xml2json-command

#COPY scripts/* /usr/local/bin/

#RUN rm -rf /var/cache/apk/*

#RUN apk add curl

WORKDIR /tmpdl
#RUN curl -LJO https://github.com/johnkerl/miller/releases/download/v6.10.0/miller-6.10.0-linux-amd64.tar.gz
ADD https://github.com/johnkerl/miller/releases/download/v6.10.0/miller-6.10.0-linux-amd64.tar.gz /tmpdl
RUN tar -xzvf miller-6.10.0-linux-amd64.tar.gz
RUN mv /tmpdl/miller-6.10.0-linux-amd64/mlr /usr/local/bin
RUN chmod +x /usr/local/bin/mlr
RUN chown root:root /usr/local/bin/mlr
RUN rm -rf /tmpdl/*


WORKDIR /data

#ENTRYPOINT  ["/bin/sh"]