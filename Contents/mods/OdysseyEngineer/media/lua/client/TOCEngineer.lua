-- Functions

---@return boolean true if the player has the weapon in their inventory, the gun is the correct type, and he has the correct ammo loaded, 
---@param weapon HandWeapon
--- We check that the current weapon is a gun, and that the ammoType is correct
function TOCCheckGun(weapon)
    --- We get the ammoType
    local ammo = weapon:getAmmoType()
    local isAmmoValid = CorrectAmmoType(weapon)

    if weapon:isRanged() then
        if isAmmoValid then
            return true
        end
    end
    return false
end

---@param weapon HandWeapon
---@return boolean true if the ammoType is correct
function CorrectAmmoType(weapon)
    local ammo = weapon:getAmmoType()
    local listOfAmmos =
    {
        "OdysseyExploShells",
        "OdysseyExplo44",
    }

    for i = 1, #listOfAmmos do
        if ammo == listOfAmmos[i] then
            return true
        end
    end
    return false
end

---@param weapon HandWeapon
--- Make the gun jam, reduce condition by `SandboxVars.TOC.ConditionReduction` amount
function SetGunStuff(weapon)
    --- Set the gun to be jammed
    weapon:setJammed(true)
    local condition = weapon:getCondition()
    --- If the condition is less than the reduction, we set the condition to 0 to avoid fuckery
    if (condition < SandboxVars.TOC.ConditionReduction) then
        weapon:setCondition(0)
    else
        weapon:setCondition(condition - SandboxVars.TOC.ConditionReduction)
    end
end

---@param player IsoPlayer
---@param zombie IsoZombie
--[[ We get the `aimLevel` and `reloadLevel` of the player, the pos of said player, and the pos of the zed we hit.
We then use `SandboxVars.TOC.ReloadLevel` to check if the player is high enough to only have `SandboxVars.TOC.ChanceToJam` to jam
Else, garanteed chance of jam & reduced condition as set by the function `SetGunStuff(weapon)`.
This also use `SandboxVars.TOC.AimingLevel` to check wether the fire start at `PlayerPos` or `ZombiePos`]]--
function StartFunc(player, zombie)
    --- We check the aiming level
    local aimLevel = player:getPerkLevel(Perks.Aiming)
    local reloadLevel = player:getPerkLevel(Perks.Reloading)

    --- Get pos of player
    local PlayerPosX = player:getLlx()
    local PlayerPosY = player:getLly()
    local PlayerPosZ = player:getLlz()

    --- Get pos of zombie we hit
    local ZombiePosX = zombie:getLlX()
    local ZombiePosY = zombie:getLlY()
    local ZombiePosZ = zombie:getLlZ()
    if (TOCCheckGun(player, weapon) and CorrectAmmoType(weapon)) then
        if (reloadLevel < SandboxVars.TOC.ReloadLevel) then
            --- We set the gun to be jammed
            SetGunStuff(player:getPrimaryHandItem())
        --- Else, only a certain chance to jamm
        else
            local HundredChance = ZombRand(100)
            if (HundredChance <= SandboxVars.TOC.ChanceToJam) then
                SetGunStuff(player:getPrimaryHandItem())
            end
        end

        --- We check if the aiming level is high enough, else toasty bunkies
        if (aimLevel <= SandboxVars.TOC.AimingLevel) then
            StartFire(PlayerPosX, PlayerPosY, PlayerPosZ);
        else
            StartFire(ZombiePosX, ZombiePosY, ZombiePosZ);
        end
    end
end

function StartFire(posX, posY, posZ)
    local square = cell:getGridSquare(ZombRand(posX-radius*2, posX+radius*2), ZombRand(posY-radius*2, posY+radius*2), posZ);
    local randomduration = {150,200,250,300}
    if square ~= nil and not square:haveFire() then
        IsoFireManager.StartFire(square:getCell(), square, true, 100, randomduration[ZombRand(4)+1]);
    end
end

Events.OnHitZombie.Add(StartFunc(player, zombie));
