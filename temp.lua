-- ***************************************************************************
-- DHT11 temperature/humidity sensor with ESP8266 and nodeMCU: ESP8266 
-- with TCP socket for reading t/h data.
-- 
-- ***************************************************************************

local moduleName = ...
local M = {}
_G[moduleName] = M

pin = 4
DHT = require("dht_lib")

local curTemperature = 0
local curHumidity = 0

local serv = nil

local function getTempHumidity()
    local temp = nil
    local hum = nil
    DHT.read11(pin)
    temp = DHT.getTemperature()
    hum = DHT.getHumidity()
    
    if (temp ~= nil) then
        curTemperature = temp
    end
    
    if (hum ~= nil) then
        curHumidity = hum 
    end

    return curTemperature, curHumidity
end

function M.getReadsings()
    return getTempHumidity()
end

function M.initServ()
    serv = net.createServer(net.TCP)
    serv:listen(80, function(c)
        t,h = getTempHumidity()
        c:on("receive", function(c,l) print("New Connection") end)
        -- local sendString = respHeader .. content
        c:send("<head><title>ESP8266 + DHT11 temperature sensor</title></head><body><h1>temperature and humidity</h1><br>" .. t .. ", " .. h .. "%</body>")
        c:on("sent", function(c) c:close() end)
        end)
end

return M
