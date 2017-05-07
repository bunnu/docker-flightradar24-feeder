# docker-flightradar24-feeder

This docker image can be used for running a flightradar24 feeder with a R820T/RTL2832U USB DVB receiver dongle

## Create Image
``
docker build . -t fr24feeder
``

## Create Container
``
docker run -d --name flightradar24-feeder --restart=always --privileged -p 8754:8754 fr24feeder --fr24key=<key>
``
