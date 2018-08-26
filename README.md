# docker-flightradar24-feeder

This docker image can be used for running a flightradar24 feeder with a R820T/RTL2832U USB DVB receiver dongle

## Prerequisites
On your Docker host blacklist dvb_usb_rtl28xxu.
```
sudo nano /etc/modprobe.d/blacklist.conf
```
Append following line
```` 
blacklist dvb_usb_rtl28xxu
````
Restart your Docker host.

## Create Image
``
docker build . -t fr24feeder
``

## Create Container
``
docker run -d --name fr24feeder --restart=always --privileged -p 8754:8754 fr24feeder --fr24key=<key>
``
