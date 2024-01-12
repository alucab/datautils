# Data Science Tool set in a Container
# docker run -v `pwd`:/data -it alucab:datautils sh
# docker run --rm -i alucab:datautils mlr --csv sort -f shape < ./example.csv

FROM alpine:latest as build
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
ADD https://github.com/johnkerl/miller/releases/download/v6.10.0/miller-6.10.0-linux-amd64.tar.gz /tmpdl
RUN tar -xzvf miller-6.10.0-linux-amd64.tar.gz
RUN chmod +x /tmpdl/miller-6.10.0-linux-amd64/mlr
RUN chown root:root /tmpdl/miller-6.10.0-linux-amd64/mlr
#RUN rm -rf /tmpdl/*

FROM alpine:latest 

LABEL org.opencontainers.image.authors="Luca Barba <alucab@users.noreply.github.com>"
LABEL org.opencontainers.image.url="https://github.com/alucab/datautils"
LABEL org.opencontainers.image.documentation="https://github.com/alucab/datautils"
LABEL org.opencontainers.image.source="https://github.com/alucab/datautils"
LABEL org.opencontainers.image.title="alucab/datautils"
LABEL org.opencontainers.image.description="A set of dockerized utilities to elaborate data on the CLI"


COPY --from=build /tmpdl/miller-6.10.0-linux-amd64/mlr /usr/local/bin
WORKDIR /data


#ENTRYPOINT  ["/bin/sh"]