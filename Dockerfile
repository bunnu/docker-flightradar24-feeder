FROM ubuntu:16.04

#  $ docker run -d \
#    --name flightradar24_feeder \
#    --restart=always \
#    --privileged \
#    -p 8754:8754 \
#    fr24feed \
#      --fr24key=<key>

RUN apt-get update && \
    apt-get install -y wget unzip make librtlsdr0 librtlsdr-dev gcc pkg-config && \
    mkdir /usr/lib/fr24/ && \
    cd /tmp && \
    wget http://feed.flightradar24.com/linux/fr24feed_1.0.18-5_amd64.tgz && \
    tar zxf /tmp/fr24feed_1.0.18-5_amd64.tgz && \
    cp fr24feed_amd64/fr24feed /usr/lib/fr24/ && \
    wget https://github.com/antirez/dump1090/archive/master.zip && \
    unzip /tmp/master.zip && \
    cd dump1090-master && \
    make && \
    cp dump1090 /usr/lib/fr24/ && \
    cd /tmp && \
    rm -rf * && \
    apt-get remove -y wget unzip make gcc pkg-config && \
    apt-get autoremove -y && \
    apt-get clean -y
ADD fr24feed.ini /etc/fr24feed.ini

WORKDIR /usr/lib/fr24/

EXPOSE 8754
ENTRYPOINT ["./fr24feed"]

