rapidjson = require("rapidjson")

Controls.Status.Value = 4 -- start status as missing

DebounceTime = 0.5 -- time in seconds to debounce config changes

PollInterval = tonumber(Properties["Poll Interval"].Value)
PollTimer = Timer.New()

tempUnit = "c"

LedModes = {
  co2 = "CO2",
  pm = "PM2.5",
  off = "Off"
}
-- build reverse lookup for LedModes
for mode, label in pairs(LedModes) do
  LedModes[label] = mode
end

Controls.LedMode.Choices = {"CO2","PM2.5","Off"}

function Poll()
  GetConfig()
  Timer.CallAfter(
    function()
      GetCurrent()
    end,
    1
  )
end
PollTimer.EventHandler = Poll

function GetConfig()
  HttpClient.Get(
    {
      Url = "http://" .. Controls.IPAddress.String .. "/config",
      Headers = {},
      Timeout = 5,
      EventHandler = function(table, code, data, error, headers)
        if code == 200 then
          Controls.Status.Value = 0
          local payload, err = rapidjson.decode(data)
          if payload ~= nil and type(payload) == "table" then
            ParseConfig(payload)
          else
            print("GetConfig failed to parse json data", err)
            print(data)
          end
        else
          print("GetConfig unsuccessful: " .. tostring(code))
          Controls.Status.Value = 4
        end
        data = nil
      end
    }
  )
end
function GetCurrent()
  HttpClient.Get(
    {
      Url = "http://" .. Controls.IPAddress.String .. "/measures/current",
      Headers = {},
      Timeout = 5,
      EventHandler = function(table, code, data, error, headers)
        if code == 200 then
          Controls.Status.Value = 0
          local payload, err = rapidjson.decode(data)
          if payload ~= nil and type(payload) == "table" then
            ParseCurrent(payload)
          else
            print("GetCurrent failed to parse json data", err)
            print(data)
          end
        else
          print("GetCurrent unsuccessful: " .. tostring(code))
          Controls.Status.Value = 4
        end
        data = nil
      end
    }
  )
end

function ParseConfig(config)
  if config.model then
    Controls.Model.String = config.model
  end
  if config.ledBarBrightness then
    Controls.LedBrightness.Value = tonumber(config.ledBarBrightness)
  end
  if config.displayBrightness then
    Controls.DisplayBrightness.Value = tonumber(config.displayBrightness)
  end
  if config.temperatureUnit then
    tempUnit = config.temperatureUnit
  end
end

function ParseCurrent(data)
  if data.firmware then
    Controls.DeviceFirmware.String = data.firmware
  end
  if data.serialno then
    Controls.SerialNumber.String = data.serialno
  end
  if data.wifi then
    Controls.WifiSignal.String = tostring(data.wifi)
  end
  if data.atmpCompensated then
    Controls.Temperature.Value = tonumber(data.atmpCompensated)
    if tempUnit == "f" then
      local tempF = tonumber(data.atmpCompensated) * 9 / 5 + 32
      Controls.TemperatureString.String = string.format("%.1f °F", tempF)
    else
      Controls.TemperatureString.String = string.format("%.1f °C", tonumber(data.atmpCompensated))
    end
  end
  if data.rhumCompensated then
    Controls.Humidity.Value = tonumber(data.rhumCompensated)
  end
  if data.rco2 then
    Controls.CO2.Value = tonumber(data.rco2)
  end
  if data.pm02Compensated then
    Controls.PM2_5.Value = tonumber(data.pm02Compensated)
  end
  if data.ledMode then
    Controls.LedMode.String = LedModes[data.ledMode] or data.ledMode
  end
end

function SendConfigChange(config)
  HttpClient.Put(
    {
      Url = "http://" .. Controls.IPAddress.String .. "/config",
      Headers = {["Content-Type"] = "application/json"},
      Timeout = 5,
      Data = rapidjson.encode(config),
      EventHandler = function(table, code, data, error, headers)
        if code == 200 then
          Controls.Status.Value = 0
          print("Config updated successfully")
          print("Config sent: " .. rapidjson.encode(config))
        else
          print("Failed to update config: " .. tostring(code))
          print("Config attempted: " .. rapidjson.encode(config))
          Controls.Status.Value = 4
        end
        data = nil
      end
    }
  )
end

LedBrightnessDebounce = Timer.New()
LedBrightnessDebounce.EventHandler = function()
  LedBrightnessDebounce:Stop()
  SendConfigChange({ledBarBrightness = math.floor(Controls.LedBrightness.Value)})
end
function Controls.LedBrightness.EventHandler()
  LedBrightnessDebounce:Stop()
  LedBrightnessDebounce:Start(DebounceTime)
end

DisplayBrightnessDebounce = Timer.New()
DisplayBrightnessDebounce.EventHandler = function()
  DisplayBrightnessDebounce:Stop()
  SendConfigChange({displayBrightness = math.floor(Controls.DisplayBrightness.Value)})
end
function Controls.DisplayBrightness.EventHandler()
  DisplayBrightnessDebounce:Stop()
  DisplayBrightnessDebounce:Start(DebounceTime)
end

Controls.LedMode.EventHandler = function()
  SendConfigChange({ledMode = LedModes[Controls.LedMode.String] or Controls.LedMode.String})
end

function Init()
  PollTimer:Stop()
  if Controls.IPAddress.String ~= "" then
    PollTimer:Start(PollInterval)
    Poll()
  end
end
Controls.IPAddress.EventHandler = Init

Init()
