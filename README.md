# esp8266_dht11_nodemcu
Nodemcu scripts for esp8266 and DHT11 temperature and humidity sensor

The project contains:

- A simple script "temp.lua", which uses the DHTxx library for esp8266 with nodemcu from Javier Yanez, to read data
from a DHT11 temperature and humidity sensor. The script also intializes a TCP socket listening on port 80 for incoming
connections and sends back an HTML string containing the sensor data (the string does not contain any http headers or http 
status).
- The DHTxx library for esp8266
- Initialization script - init.lua

