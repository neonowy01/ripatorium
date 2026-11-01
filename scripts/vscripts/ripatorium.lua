require 'misc'
local json = require 'json'

SelectedEnemy = "Headcrab"
bGameFailed = false

PanoramaValues = {
    Headcrab = 0,
    ArmoredHeadcrab = 0,
    PoisonHeadcrab = 0,
    Manhack = 0,
    Zombie = 0,
    ArmoredZombie = 0,
    Antlion = 0,
    AntlionWorker = 0,
    CombineGrunt = 0,
    CombineCharger = 0,
    CombineOrdinal = 0,
    CombineSuppressor = 0,
    Reviver = 0,
    Jeff = 0,

    SelectedEnemy = SelectedEnemy,
    SelectedEnemyAmount = 0,
    EnemyMaxAmount = 25,
    Killcount = 0,
    EnemySum = 0,
    SetupStage = true
}

PanoramaValues.SelectedEnemyAmount =
    PanoramaValues[SelectedEnemy]

function Activate() 
    player = Entities:GetLocalPlayer()
    spawnpoints = Entities:FindAllByName("spawn_points")
    PlayerSpawnpoints = Entities:FindAllByName("PlayerSpawnpoints*")
    --thisEntity:SetThink(function() SpawnNPC("grunt") return 5 end, "TestThink", 1)
    thisEntity:SetThink(function() 
        SendToConsole("@panorama_dispatch_event AddStyle(\'"..json.encode(PanoramaValues).." \')") --sending stuff to panorama ui
        return 0.1 
    end, "PanoramaThink",0 )
    cvar_setf("buddha", 1)
end 

function TeleportPlayerToRandomSpawn()
    local Int = RandomInt(1,#PlayerSpawnpoints)
    print(PlayerSpawnpoints[Int]:GetName())
    EntFireByHandle(thisEntity, PlayerSpawnpoints[Int], "Teleport", " ")
    --player:SetOrigin(PlayerSpawnpoints[RandomInt(1,#PlayerSpawnpoints)]:GetOrigin())
end

function SelectEnemy(enemy)
    print(enemy.." Selected")
    SelectedEnemy = enemy
    PanoramaValues["SelectedEnemy"] = SelectedEnemy
    PanoramaValues["SelectedEnemyAmount"] = PanoramaValues[SelectedEnemy]
end

function SetMaxEnemyAmount(f)
    PanoramaValues["EnemyMaxAmount"] = f
end

function Add()
    if PanoramaValues["EnemySum"] < PanoramaValues["EnemyMaxAmount"] then 
            PanoramaValues[SelectedEnemy] = PanoramaValues[SelectedEnemy] + 1
        else 
            PlayDenySound()
            print("Can't add to: "..SelectedEnemy)
        end
        print(SelectedEnemy.." "..PanoramaValues[SelectedEnemy])
        PanoramaValues["SelectedEnemyAmount"] = PanoramaValues[SelectedEnemy]
        PanoramaValues["EnemySum"] = PanoramaValues["Headcrab"] + PanoramaValues["ArmoredHeadcrab"] + PanoramaValues["PoisonHeadcrab"] + PanoramaValues["Manhack"] + PanoramaValues["Zombie"] + PanoramaValues["ArmoredZombie"] + PanoramaValues["Antlion"] + PanoramaValues["AntlionWorker"] + PanoramaValues["CombineGrunt"] + PanoramaValues["CombineCharger"] + PanoramaValues["CombineOrdinal"] + PanoramaValues["CombineSuppressor"] + PanoramaValues["Reviver"] + PanoramaValues["Jeff"]
        print("EnemySum is: "..PanoramaValues["EnemySum"])
end

function Subtract()
     if PanoramaValues[SelectedEnemy] > 0 then 
            PanoramaValues[SelectedEnemy] = PanoramaValues[SelectedEnemy] - 1
        else 
            PlayDenySound()
            print("Can't Subtract from to: "..SelectedEnemy)
        end
        print(SelectedEnemy.." "..PanoramaValues[SelectedEnemy])
        PanoramaValues["SelectedEnemyAmount"] = PanoramaValues[SelectedEnemy]
        PanoramaValues["EnemySum"] = PanoramaValues["Headcrab"] + PanoramaValues["ArmoredHeadcrab"] + PanoramaValues["PoisonHeadcrab"] + PanoramaValues["Manhack"] + PanoramaValues["Zombie"] + PanoramaValues["ArmoredZombie"] + PanoramaValues["Antlion"] + PanoramaValues["AntlionWorker"] + PanoramaValues["CombineGrunt"] + PanoramaValues["CombineCharger"] + PanoramaValues["CombineOrdinal"] + PanoramaValues["CombineSuppressor"] + PanoramaValues["Reviver"] + PanoramaValues["Jeff"]
        print("EnemySum is: "..PanoramaValues["EnemySum"])
end

function PlayDenySound()
    EntFireByHandle(thisEntity, Entities:FindByName(nil, "ui_selectnegative"), "StartSound", " ")
end

swTemplates = { --NPC templates 
    ["zombie"] = function() return Entities:FindByName(nil, "zombie_template") end,
    ["armored"] = function() return Entities:FindByName(nil, "armored_template") end,
    ["headcrab"] = function() return Entities:FindByName(nil, "headcrab_template") end,
    ["armored_headcrab"] = function() return Entities:FindByName(nil, "armored_headcrab_template") end,
    ["poison"] = function() return Entities:FindByName(nil, "poison_template") end,
    ["antlion"] = function() return Entities:FindByName(nil, "antlion_template")  end,
    ["spitter"] = function() return Entities:FindByName(nil, "spitter_template")  end,
    ["grunt"] = function() return Entities:FindByName(nil, "grunt_template")  end,
    ["captain"] = function() return Entities:FindByName(nil, "captain_template")  end,
    ["charger"] = function() return Entities:FindByName(nil, "charger_template")  end,
    ["suppressor"] = function() return Entities:FindByName(nil, "suppressor_template")  end,
    ["manhack"] = function() return Entities:FindByName(nil, "manhack_template")  end,
}

function SpawnNPC(NPC, nAmount)
    local template =  swTemplates[NPC]()
    local iteration = 0
    thisEntity:SetThink(function()
    if iteration == nAmount
        then 
            return nil
        else
            template:ForceSpawn()
            iteration = iteration + 1
            local SpawnedEntities = template:GetSpawnedEntities()
            for  kebab = #SpawnedEntities, 1, -1
                    do  
                        if SearchForNPC(SpawnedEntities[kebab]) == true
                            then
                            SpawnedEntities[kebab]:SetOrigin(GetAvailableSpawnpoint()) 
                            break
                        end
            end
            return 2
        end
    end,UniqueString("SpawnThink", 2))
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
            --DebugDrawLine(traceTable.startpos, traceTable.pos, 0, 255, 0, true, 5)
            return true
        else
           -- DebugDrawLine(traceTable.startpos, traceTable.endpos, 255, 0, 0, true, 5)
            return nil
        end
end




function SearchForNPC(entity) --This functions searches for the actual npcs inside point_templates GetSpawnedEntities Table
    if entity:GetName() == "enemy_armored_headcrab" or entity:GetName() ==  "enemy_manhack" or entity:GetName() == "enemy_zombie" or entity:GetName() == "enemy_armored" or entity:GetName() == "enemy_grunt"  or entity:GetName() == "enemy_charger" or entity:GetName() == "enemy_captain" or  entity:GetName() == "enemy_suppressor" or entity:GetName() == "enemy_headcrab" or entity:GetName() == "enemy_poison" or entity:GetName() == "enemy_antlion" or entity:GetName() == "enemy_spitter" or entity:GetName() == "grub" or entity:GetName() == "enemy_burrowcrab"
        then 
                return true 
        else
                return false
        end
end

function QueueSpawns()
    if PanoramaValues["EnemySum"] > 0 then
    thisEntity:SetThink(function() if player:GetHealth() == 1 then ResetArena(0) return nil end return 0.1 end, "PlayerHealthThink", 0)
    PanoramaValues["SetupStage"] = false
    
    print("EnemySum is: "..PanoramaValues["EnemySum"])
    SpawnNPC("headcrab", PanoramaValues["Headcrab"])
    SpawnNPC("armored_headcrab", PanoramaValues["ArmoredHeadcrab"])
    SpawnNPC("poison", PanoramaValues["PoisonHeadcrab"])
    SpawnNPC("manhack", PanoramaValues["Manhack"])

    SpawnNPC("zombie", PanoramaValues["Zombie"])
    SpawnNPC("armored", PanoramaValues["ArmoredZombie"])
    SpawnNPC("antlion", PanoramaValues["Antlion"])
    SpawnNPC("spitter", PanoramaValues["AntlionWorker"])

    SpawnNPC("grunt", PanoramaValues["CombineGrunt"])
    SpawnNPC("captain", PanoramaValues["CombineOrdinal"])
    SpawnNPC("charger", PanoramaValues["CombineCharger"])
    SpawnNPC("suppressor", PanoramaValues["CombineSuppressor"])
    end
end

function NpcDied()
    PanoramaValues["Killcount"] = PanoramaValues["Killcount"] + 1

    if PanoramaValues["Killcount"] == PanoramaValues["EnemySum"]
        then 
            ResetArena(1)
    end
end

function ResetArena(outcome)
    PanoramaValues["SetupStage"] = true
    PanoramaValues["Killcount"] = 0 --Reset progress from previous fight
    Entities:FindByName(nil, "RestartArena"):Trigger(thisEntity, thisEntity) -- this is where the entire logic is really
     if outcome == 1 then 
         print("Victory! You win")
    else
        print("Defeat...")
        
    end
end

function ResetEnemyValues()
    local enemies = {
        "Headcrab",
        "ArmoredHeadcrab",
        "PoisonHeadcrab",
        "Manhack",
        "Zombie",
        "ArmoredZombie",
        "Antlion",
        "AntlionWorker",
        "CombineGrunt",
        "CombineCharger",
        "CombineOrdinal",
        "CombineSuppressor",
        "Reviver",
        "Jeff"
    }

    for _, enemy in ipairs(enemies) do
        PanoramaValues[enemy] = 0
    end

    PanoramaValues["SelectedEnemyAmount"] = 0
    PanoramaValues["EnemySum"] = 0
    PanoramaValues["Killcount"] = 0
end

RandomTemplates = {
    Mix = {
        "Headcrab",
        "ArmoredHeadcrab",
        "PoisonHeadcrab",
        "Manhack",
        "Zombie",
        "ArmoredZombie",
        "Antlion",
        "AntlionWorker",
        "CombineGrunt",
        "CombineCharger",
        "CombineOrdinal",
        "CombineSuppressor",
        "Reviver",
        --"Jeff"
    },

    Combine = {
        "CombineGrunt",
        "CombineCharger",
        "CombineOrdinal",
        "CombineSuppressor",
        "Manhack"
    },

    Xombies = {
        "Headcrab",
        "ArmoredHeadcrab",
        "PoisonHeadcrab",
        "Zombie",
        "ArmoredZombie"
    },

    Xen = {
        "Headcrab",
        "ArmoredHeadcrab",
        "PoisonHeadcrab",
        "Reviver",
        "Antlion",
        "AntlionWorker"
    }--[[,
    Revive = {
        "Zombie",
        "ArmoredZombie",
        "Reviver"
    }]]
}

function RandomizeEnemies()

    local modes = {}

    for mode, _ in pairs(RandomTemplates) do
        table.insert(modes, mode)
    end

    local randomMode = modes[RandomInt(1, #modes)]

    local template = RandomTemplates[randomMode]

    -- 50% of MaxAmount is minimal amount of randomized npcs.
    local targetAmount = RandomInt(math.ceil(PanoramaValues["EnemyMaxAmount"] * 0.5), PanoramaValues["EnemyMaxAmount"])

    ResetEnemyValues()

    --Randomizing
    for i = 1, targetAmount do

        local randomIndex = RandomInt(1, #template)
        local randomEnemy = template[randomIndex]

        PanoramaValues[randomEnemy] =
            PanoramaValues[randomEnemy] + 1

    end

    PanoramaValues["EnemySum"] = targetAmount

    PanoramaValues["SelectedEnemyAmount"] =
        PanoramaValues[SelectedEnemy]

    PanoramaValues["SelectedEnemy"] = SelectedEnemy

    print("Randomized mode: " .. randomMode)
    print("Generated NPCs: " .. targetAmount)

end