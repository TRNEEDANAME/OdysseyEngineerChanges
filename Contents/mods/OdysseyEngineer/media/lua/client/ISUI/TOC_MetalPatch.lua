-- Store the original function for compatibility.
local original_doClothingPatchMenu = ISInventoryPaneContextMenu.doClothingPatchMenu

-- Create a wrapper function.
ISInventoryPaneContextMenu.doClothingPatchMenu = function(player, clothing, context)
    -- Call the original function.
    original_doClothingPatchMenu(player, clothing, context)


    local playerObj = getSpecificPlayer(player)
    if not playerObj or not clothing:getFabricType() then
        return
    end

    local thread = playerObj:getInventory():getItemFromType("Thread", true, true)
    local needle = playerObj:getInventory():getItemFromType("Needle", true, true) or playerObj:getInventory():getFirstTagRecurse("SewingNeedle")
    local fabric1 = playerObj:getInventory():getItemFromType("RippedSheets", true, true)
    local fabric2 = playerObj:getInventory():getItemFromType("DenimStrips", true, true)
    local fabric3 = playerObj:getInventory():getItemFromType("LeatherStrips", true, true)
    local fabric4 = playerObj:getInventory():getItemFromType("MetalStrips", true, true)


    if not thread or not needle or (not fabric1 and not fabric2 and not fabric3 and not fabric4) then
        local patchOption = context:addOption(getText("ContextMenu_Patch"))
        patchOption.notAvailable = true
        local tooltip = ISInventoryPaneContextMenu.addToolTip()
        tooltip.description = getText("ContextMenu_CantRepair")
        patchOption.toolTip = tooltip
        return
    end
end