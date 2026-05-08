-- layout["code"] = {PrettyName = "Code",Style = "None"}

x,y = 0,0

StandardHeight = 20
Margin = 4

LabelSize = {120,StandardHeight}
ControlSize = {150,StandardHeight}

layout["Status"] = {
  PrettyName = "Status",
  Style = "Text",
  Position = {x,y},
  Size = {LabelSize[1] + ControlSize[1],StandardHeight}
}
y = y + StandardHeight + Margin

table.insert(graphics, {
  Type = "Label",
  Text = "IPAddress/Hostname",
  Position = {x,y},
  Size = LabelSize
})
layout["IPAddress"] = {
  PrettyName = "Connection Address",
  Style = "Text",
  Position = {x + LabelSize[1], y},
  Size = ControlSize
}
y = y + StandardHeight + Margin

UnitInfo = {
  {
    label = "Model",
    controlName = "Model"
  },
  {
    label = "Firmware",
    controlName = "DeviceFirmware"
  },
  {
    label = "Serial Number",
    controlName = "SerialNumber"
  },
  {
    label = "WiFi Signal",
    controlName = "WifiSignal"}
}

for _, info in ipairs(UnitInfo) do
  table.insert(graphics, {
    Type = "Label",
    Text = info.label,
    Position = {x,y},
    Size = {LabelSize[1] - Margin,LabelSize[2]},
    HTextAlign = "Right"
  })
  layout[info.controlName] = {
    PrettyName = "Unit Info~" .. info.label,
    Style = "Text",
    Position = {x + LabelSize[1], y},
    Size = ControlSize,
  }
  y = y + StandardHeight + Margin
end

ConfigKnobs = {
  {
    label = "LED Brightness",
    controlName = "LedBrightness"
  },
  {
    label = "Display Brightness",
    controlName = "DisplayBrightness"

  },
  {
    label = "LED Mode",
    controlName = "LedMode",
    layoutType = "ComboBox"
  }
}

for _, info in ipairs(ConfigKnobs) do
  table.insert(graphics, {
    Type = "Label",
    Text = info.label,
    Position = {x,y},
    Size = {LabelSize[1] - Margin,LabelSize[2]},
    HTextAlign = "Right"
  })
  layout[info.controlName] = {
    PrettyName = "Config~" .. info.label,
    Style = info.layoutType and info.layoutType or "Text",
    Position = {x + LabelSize[1], y},
    Size = ControlSize,
  }
  y = y + StandardHeight + Margin
end

MeasurementInfo = {
  {
    label = "Temperature",
    controlName = "Temperature",
    unit = "°C"
  },
  {
    label = "Temperature String",
    controlName = "TemperatureString",
  },
  {
    label = "Relative Humidity",
    controlName = "Humidity"
  },
  {
    label = "CO2",
    controlName = "CO2",
    unit = "ppm"
  },
  {
    label = "PM 2.5",
    controlName = "PM2_5",
    unit = "µg/m³"
  }
}

for _, info in ipairs(MeasurementInfo) do
  table.insert(graphics, {
    Type = "Label",
    Text = info.unit and info.label .. " (" .. info.unit .. ")" or info.label,
    Position = {x,y},
    Size = {LabelSize[1] - Margin,LabelSize[2]},
    HTextAlign = "Right"
  })
  layout[info.controlName] = {
    PrettyName = "Measurements~" .. info.label,
    Style = "Text",
    Position = {x + LabelSize[1], y},
    Size = ControlSize,
    IsReadOnly = true
  }
  y = y + StandardHeight + Margin
end