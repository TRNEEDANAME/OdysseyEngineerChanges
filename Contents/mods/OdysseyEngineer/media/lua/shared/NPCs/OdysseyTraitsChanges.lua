OdysseyTraitsChanges = {}

-- BALANCE MOD -- VANILLA

OdysseyTraitsChanges.DoTraits = function()

	--local test = TraitFactory.addTrait("TR_TEST", getText("UI_trait_sneaky"), 1, getText("UI_trait_sneakydesc"), false);
    local stout = TraitFactory.addTrait("Stout", getText("UI_trait_stout"), 6, getText("UI_trait_stoutDesc3"), false);
    stout:addXPBoost(Perks.Strength, 1);  -- Nerfed to +1

    local fit = TraitFactory.addTrait("Fit", getText("UI_trait_fit"), 6, getText("UI_trait_fitdesc3"), false);
    fit:addXPBoost(Perks.Fitness, 1);  -- Nerfed to +1

-- Change Former Scout from +1 First Aid and Foraging to +1 Trapping and Foraging
    local formerscout = TraitFactory.addTrait("Formerscout", getText("UI_trait_formerscout3"), 4, getText("UI_trait_formerscoutdesc3"), false);
    formerscout:addXPBoost(Perks.Trapping, 1);
    formerscout:addXPBoost(Perks.PlantScavenging, 1);

    local formerscout2 = TraitFactory.addTrait("Formerscout2", getText("UI_trait_formerscout3"), 4, getText("UI_trait_formerscoutdesc3"), true);
    formerscout2:addXPBoost(Perks.Trapping, 1);
    formerscout2:addXPBoost(Perks.PlantScavenging, 1);

    if getActivatedMods():contains("zReBetterLockpicking") then
         local nimblefingers = TraitFactory.addTrait("nimblefingers", getText("UI_trait_nimblefingers"), 0, getText("UI_trait_nimblefingersDesc"), false);
         nimblefingers:getFreeRecipes():add("Lockpicking");
         nimblefingers:getFreeRecipes():add("Alarm check");
         nimblefingers:getFreeRecipes():add("Create BobbyPin");
     end

     local genexp = TraitFactory.addTrait("GenExp", getText("UI_trait_genexp"), 9999, getText("UI_trait_genexpdesc"), true);
     local amcarpenter = TraitFactory.addTrait("AMCarpenter", getText("UI_trait_carpenter"), 9999, getText("UI_trait_carpenterdesc"), true);

     local firstAid = TraitFactory.addTrait("FirstAid", getText("UI_trait_firstaid"), 9999, getText("UI_trait_firstaiddesc"), true);
     local ath = TraitFactory.addTrait("Athletic", getText("UI_trait_athletic"), 9999, getText("UI_trait_athleticdesc"), true);
     local strong = TraitFactory.addTrait("Strong", getText("UI_trait_strong"), 9999, getText("UI_trait_strongdesc"), true);
     local taut = TraitFactory.addTrait("Taut", getText("UI_trait_taut"), 9999, getText("UI_trait_tautdesc"), true);

     local gunfan2 = TraitFactory.addTrait("Gunfan2", getText("UI_trait_gunfan2"), 8, getText("UI_trait_gunfan2desc"), true);
     local sharpshooter = TraitFactory.addTrait("Sharpshooter", getText("UI_trait_sharpshooter"), 0, getText("UI_trait_sharpshooterdesc"), true);


end

Events.OnGameBoot.Add(OdysseyTraitsChanges.DoTraits);
