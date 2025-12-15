local menu = nil

local Lib = require("extensions.sn_mod_support_apis.ui.Library")

local function debugTrace(message)
  local text = "ShowMeMoreOffers: " .. message
  if type(DebugError) == "function" then
    DebugError(text)
  end
end

local function Init()
  menu = Lib.Get_Egosoft_Menu("MapMenu")
  debugTrace("MapMenu is " .. tostring(menu))
  if type(menu.uix_getConfig) == "function" then
    debugTrace("UIX getConfig is found!")
    local config = menu.uix_getConfig()
    if type(config) == "table" then
      if type(config.layersettings) == "table" then
        if type(config.layersettings.layer_trade) == "table" then
          if type(config.layersettings.layer_trade[7]) == "table" then
            if type(config.layersettings.layer_trade[7][1]) == "table" then
              if type(config.layersettings.layer_trade[7][1].scale) == "table" then
                if type(config.layersettings.layer_trade[7][1].scale.max) == "number" then
                  debugTrace("Current max scale for Trades on map is " .. tostring(config.layersettings.layer_trade[7][1].scale.max) .. ".")
                  config.layersettings.layer_trade[7][1].scale.max = 50
                  debugTrace("New max scale for Trades on map is set to " .. tostring(config.layersettings.layer_trade[7][1].scale.max) .. ".")
                else
                  debugTrace("Max scale for Trades on map is not a number!")
                end
              else
                debugTrace("Scale for Trades on map is not a table!")
              end
            else
              debugTrace("Layer Trade [7][1] is not a table!")
            end
          else
            debugTrace("Layer Trade [7] is not a table!")
          end
        else
          debugTrace("Layer Trade is not a table!")
        end
      else
        debugTrace("Layer settings is not a table!")
      end
    else
      debugTrace("Config is not a table!")
    end
  else
    debugTrace("UIX getConfig is NOT found!")
  end
end

Register_Require_With_Init("extensions.show_me_more_offers.ui.show_me_more_offers", nil, Init)


