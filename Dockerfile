FROM ubuntu:16.04 as base
RUN apt-get update && \
    apt-get install -y curl ca-certificates unzip librtlsdr0 librtlsdr-dev pkg-config apt-utils && \
    mkdir /usr/lib/fr24/ && \
    cd /tmp && \
    curl -sLO http://feed.flightradar24.com/linux/fr24feed_1.0.18-5_amd64.tgz && \
    tar zxf /tmp/fr24feed_1.0.18-5_amd64.tgz && \
    mv fr24feed_amd64/fr24feed /usr/lib/fr24/ && \
    rm /tmp/fr24feed_1.0.18-5_amd64.tgz
ADD fr24feed.ini /etc/fr24feed.ini

FROM base as build
RUN cd /tmp && \
    curl -sLO https://github.com/antirez/dump1090/archive/master.zip && \
    unzip /tmp/master.zip && \
    cd dump1090-master && \
    make

FROM base as run
COPY --from=build /tmp/dump1090-master/dump1090 /usr/lib/fr24/
WORKDIR /usr/lib/fr24/
EXPOSE 8754
ENTRYPOINT ["./fr24feed"]

