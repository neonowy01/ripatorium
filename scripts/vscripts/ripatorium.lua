require 'misc'
local json = require 'json'

SelectedEnemy = "Headcrab"
MaxEnemyAmount = 10 --Default max amount of enemies, specify on map start with logic_auto
bGameFailed = false

PanoramaValues = {} 
a = "Headcrab"
PanoramaValues[a] = 0
b = "ArmoredHeadcrab"
PanoramaValues[b] = 0
c = "PoisonHeadcrab"
PanoramaValues[c] = 0
d = "Manhack"
PanoramaValues[d] = 0
e = "Zombie"
PanoramaValues[e] = 0
f = "ArmoredZombie"
PanoramaValues[f] = 0
g = "Antlion"
PanoramaValues[g] = 0
h = "AntlionWorker"
PanoramaValues[h] = 0
i = "CombineGrunt"
PanoramaValues[i] = 0
j = "CombineCharger"
PanoramaValues[j] = 0
k = "CombineOrdinal"
PanoramaValues[k] = 0
l = "CombineSuppressor"
PanoramaValues[l] = 0
m = "Reviver"
PanoramaValues[m] = 0
n = "Jeff"

PanoramaValues[n] = 0
o = "SelectedEnemy"
PanoramaValues[o] = SelectedEnemy
p = "SelectedEnemyAmount"
PanoramaValues[p] = PanoramaValues[SelectedEnemy]
r = "EnemyMaxAmountValue"
PanoramaValues[r] = MaxEnemyAmount

s = "Killcount"
PanoramaValues[s] = 0
t = "EnemySum"
PanoramaValues[t] = 0
u = "SetupStage"
PanoramaValues[u] = true

function Activate() 
    player = Entities:GetLocalPlayer()
    spawnpoints = Entities:FindAllByName("spawn_points")
    PlayerSpawnpoints = Entities:FindAllByName("PlayerSpawnpoints")
    --thisEntity:SetThink(function() SpawnNPC("grunt") return 5 end, "TestThink", 1)
    thisEntity:SetThink(function() 
        SendToConsole("@panorama_dispatch_event AddStyle(\'"..json.encode(PanoramaValues).." \')") --sending stuff to panorama ui
        return 0.1 
    end, "PanoramaThink",0 )
end 

function TeleportPlayerToRandomSpawn()
    player:SetOrigin(PlayerSpawnpoints[RandomInt(0,#PlayerSpawnpoints)]:GetOrigin())
end

function SelectEnemy(enemy)
    print(enemy.." Selected")
    SelectedEnemy = enemy
    PanoramaValues["SelectedEnemy"] = SelectedEnemy
    PanoramaValues["SelectedEnemyAmount"] = PanoramaValues[SelectedEnemy]
end

function SetMax(value)
    MaxEnemyAmount = value
    PanoramaValues["EnemyMaxAmountValure"] = MaxEnemyAmount
end
function Add()
    if PanoramaValues[SelectedEnemy] < MaxEnemyAmount then 
            PanoramaValues[SelectedEnemy] = PanoramaValues[SelectedEnemy] + 1
        else 
            PlayDenySound()
            print("Can't add to: "..SelectedEnemy)
        end
        print(SelectedEnemy.." "..PanoramaValues[SelectedEnemy])
        PanoramaValues["SelectedEnemyAmount"] = PanoramaValues[SelectedEnemy]
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
            return 3
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
            DebugDrawLine(traceTable.startpos, traceTable.pos, 0, 255, 0, true, 5)
            return true
        else
            DebugDrawLine(traceTable.startpos, traceTable.endpos, 255, 0, 0, true, 5)
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
    PanoramaValues["SetupStage"] = false
    PanoramaValues["EnemySum"] = PanoramaValues["Headcrab"] + PanoramaValues["ArmoredHeadcrab"] + PanoramaValues["PoisonHeadcrab"] + PanoramaValues["Manhack"] + PanoramaValues["Zombie"] + PanoramaValues["ArmoredZombie"] + PanoramaValues["Antlion"] + PanoramaValues["AntlionWorker"] + PanoramaValues["CombineGrunt"] + PanoramaValues["CombineCharger"] + PanoramaValues["CombineOrdinal"] + PanoramaValues["CombineOrdinal"] + PanoramaValues["CombineSuppressor"] + PanoramaValues["Reviver"] + PanoramaValues["Jeff"]
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

function NpcDied()
    PanoramaValues["Killcount"] = PanoramaValues["Killcount"] + 1

    if PanoramaValues["Killcount"] == PanoramaValues["EnemySum"]
        then 
            Victory()
    end
end

function Victory()
    print("Victory! You win")
end