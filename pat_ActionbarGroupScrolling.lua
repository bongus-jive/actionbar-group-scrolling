function init()
  if not starExtensions and script.updateDt() ~= 0 then
    sb.logWarn("'Actionbar Group Scrolling' requires StarExtensions - https://github.com/StarExtensions/StarExtensions/releases")
    script.setUpdateDelta(0)
    update = nil
  end
end

local lastSlot = false

function update()
  if not input.key("LAlt") then
    lastSlot = false
    return
  end
  
  if lastSlot == false then
    lastSlot = player.selectedActionBarSlot()
  end
  
  local events = input.events()
  if #events == 0 then
    return
  end
  
  for _, event in ipairs(events) do
    if event.type == "MouseWheel" then
      local group = player.actionBarGroup() + event.data.mouseWheel
      player.setActionBarGroup(group)
      player.setSelectedActionBarSlot(lastSlot)
    end
  end
  
  lastSlot = player.selectedActionBarSlot()
end