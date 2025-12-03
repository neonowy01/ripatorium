function Activate() 
    player = Entities:GetLocalPlayer()
    spawnpoints = Entities:FindAllByName("spawn_points")
    --thisEntity:SetThink(function() SpawnNPC("grunt") return 5 end, "TestThink", 1)
end 

swTemplates = { --NPC templates with specified unique delays
    ["zombie"] = function() return Entities:FindByName(nil, "zombie_template") end,
    ["armored"] = function() return Entities:FindByName(nil, "armored_template") end,
    ["headcrab"] = function() return Entities:FindByName(nil, "headcrab_template") end,
    ["poison"] = function() return Entities:FindByName(nil, "poison_template") end,
    ["antlion"] = function() return Entities:FindByName(nil, "antlion_template")  end,
    ["spitter"] = function() return Entities:FindByName(nil, "spitter_template")  end,
    ["grunt"] = function() return Entities:FindByName(nil, "grunt_template")  end,
    ["captain"] = function() return Entities:FindByName(nil, "captain_template")  end,
    ["charger"] = function() return Entities:FindByName(nil, "charger_template")  end,
    ["suppressor"] = function() return Entities:FindByName(nil, "suppressor_template")  end,
    ["manhack"] = function() return Entities:FindByName(nil, "manhack_template")  end,
}

function SpawnNPC(NPC)
    local template =  swTemplates[NPC]()
    template:ForceSpawn()
    local SpawnedEntities = template:GetSpawnedEntities()
    for  i = #SpawnedEntities, 1, -1
            do  
                if SearchForNPC(SpawnedEntities[i]) == true
                    then
                    SpawnedEntities[i]:SetOrigin(GetAvailableSpawnpoint()) 
                    break
                end
            end
end

function GetAvailableSpawnpoint()
    while true do
        local RandomPoint = spawnpoints[RandomInt(1, #spawnpoints)]:GetOrigin() 
        if TraceTo(RandomPoint) == true 
            then return RandomPoint 
        end 
    end
end

function TraceTo(target)
        local traceTable = {
            startpos = player:EyePosition(),
            endpos = target,
            mask = MASK_BLOCKLOS_AND_NPCS,
            ignore = player
        }

        TraceLine(traceTable)

        if traceTable.hit 
        then
            DebugDrawLine(traceTable.startpos, traceTable.pos, 0, 255, 0, true, 5)
            return true
        else
            DebugDrawLine(traceTable.startpos, traceTable.endpos, 255, 0, 0, true, 5)
            return nil
        end
end




function SearchForNPC(entity) --This functions searches for the actual npcs inside point_templates GetSpawnedEntities Table
    if entity:GetName() == "enemy_zombie" or entity:GetName() == "enemy_armored" or entity:GetName() == "enemy_grunt"  or entity:GetName() == "enemy_charger" or entity:GetName() == "enemy_captain" or  entity:GetName() == "enemy_suppressor" or entity:GetName() == "enemy_headcrab" or entity:GetName() == "enemy_poison" or entity:GetName() == "enemy_antlion" or entity:GetName() == "top_enemy_spitter" or entity:GetName() == "grub" or entity:GetName() == "enemy_burrowcrab"
        then 
                return true 
        else
                return false
        end
end