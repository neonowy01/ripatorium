require 'misc'
local json = require 'json'

SelectedEnemy = "Headcrab"
MaxEnemyAmount = 10 --Default max amount of enemies, specify on map start with logic_auto

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

function Activate() 
    player = Entities:GetLocalPlayer()
    spawnpoints = Entities:FindAllByName("spawn_points")
    --thisEntity:SetThink(function() SpawnNPC("grunt") return 5 end, "TestThink", 1)
    thisEntity:SetThink(function() 
        SendToConsole("@panorama_dispatch_event AddStyle(\'"..json.encode(PanoramaValues).." \')") --sending stuff to panorama ui
        return 0.1 
    end, "PanoramaThink",0 )
end 

function SelectEnemy(enemy)
    print(enemy.." Selected")
    SelectedEnemy = enemy
    PanoramaValues["SelectedEnemy"] = SelectedEnemy
    PanoramaValues["SelectedEnemyAmount"] = PanoramaValues[SelectedEnemy]
end

function SetMax(value)
    MaxEnemyAmount = value
    PanoramaValues["EnemyMaxAmountValue"] = MaxEnemyAmount
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

--[[function AddTo(enemy)
     if GetMaxNPCAmonutValues(enemy) and GetMaxAllNPCAmount()}then 
        PanoramaValues[enemy] = PanoramaValues[enemy] - 1
    else 
        PlayDenySound()
        
    end
    PanoramaValues[enemy] = PanoramaValues[enemy] + 1
end 

function SubtractFrom(enemy)
    if PanoramaValues[enemy] > 0 then 
        PanoramaValues[enemy] = PanoramaValues[enemy] - 1
    else 
        PlayDenySound()
        
    end
end]]

function PlayDenySound()
    EntFireByHandle(thisEntity, Entities:FindByName(nil, "ui_selectnegative"), "StartSound", " ")
end

swTemplates = { --NPC templates 
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