-- table.insert(ctrls,{Name = "code",ControlType = "Text",PinStyle = "Input",Count = 1})

table.insert(
  ctrls,
  {
    Name = "IPAddress",
    ControlType = "Text",
    PinStyle = "Both",
    UserPin = true
  }
)
table.insert(
  ctrls,
  {
    Name = "Status",
    ControlType = "Indicator",
    IndicatorType = Reflect and "StatusGP" or "Status",
    UserPin = true,
    PinStyle = "Output"
  }
)
table.insert(ctrls, {
  Name = "DeviceFirmware",
  ControlType = "Indicator",
  IndicatorType = "Text",
  UserPin = true,
  PinStyle = "Output"
})
table.insert(ctrls, {
  Name = "SerialNumber",
  ControlType = "Indicator",
  IndicatorType = "Text",
  UserPin = true,
  PinStyle = "Output"
})
table.insert(ctrls, {
  Name = "Model",
  ControlType = "Indicator",
  IndicatorType = "Text",
  UserPin = true,
  PinStyle = "Output"
})
table.insert(ctrls, {
  Name = "WifiSignal",
  ControlType = "Indicator",
  IndicatorType = "Text",
  UserPin = true,
  PinStyle = "Output"
})

table.insert(ctrls, {
  Name = "LedBrightness",
  ControlType = "Knob",
  ControlUnit = "Integer",
  UserPin = true,
  PinStyle = "Both",
  Min = 0,
  Max = 100,
  DefaultValue = 100
})
table.insert(ctrls, {
  Name = "DisplayBrightness",
  ControlType = "Knob",
  ControlUnit = "Integer",
  UserPin = true,
  PinStyle = "Both",
  Min = 0,
  Max = 100,
  DefaultValue = 100
})

table.insert(ctrls, {
  Name = "TemperatureString",
  ControlType = "Indicator",
  IndicatorType = "Text",
  PinStyle = "None"
})
table.insert(ctrls, {
  Name = "Temperature",
  ControlType = "Knob",
  ControlUnit = "Float",
  UserPin = true,
  PinStyle = "Output",
  Min = -20,
  Max = 122,
  DefaultValue = 32
})
table.insert(ctrls, {
  Name = "Humidity",
  ControlType = "Knob",
  ControlUnit = "Percent",
  UserPin = true,
  PinStyle = "Output",
})
table.insert(ctrls, {
  Name = "CO2",
  ControlType = "Knob",
  ControlUnit = "Integer",
  UserPin = true,
  PinStyle = "Output",
  Min = 0,
  Max = 3000,
  DefaultValue = 430
})
table.insert(ctrls, {
  Name = "PM2_5",
  ControlType = "Knob",
  ControlUnit = "Float",
  UserPin = true,
  PinStyle = "Output",
  Min = 0,
  Max = 500
})
table.insert(ctrls,{
  Name = "LedMode",
  ControlType = "Text",
  UserPin = true,
  PinStyle = "Both"
})