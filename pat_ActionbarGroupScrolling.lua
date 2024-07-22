local maxGroups
local lastSlot = false

function init()
  if not input then
    sb.logWarn("'Actionbar Group Scrolling' requires StarExtensions or OpenStarbound")
    script.setUpdateDelta(0)
    update = nil
    return
  end

  maxGroups = root.assetJson("/player.config:inventory.customBarGroups")
end

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
      local group = ((player.actionBarGroup() + event.data.mouseWheel - 1) % maxGroups) + 1
      player.setActionBarGroup(group)
      player.setSelectedActionBarSlot(lastSlot)
    end
  end
  
  lastSlot = player.selectedActionBarSlot()
end