function Activate() 
        thisEntity:SetThink(Thinking, "Thinking", 0)
end

function Thinking()
    if player ~= nil then
        local handModel = Entities:FindByModel(nil, "models/hands/alyx_glove_left.vmdl")
        local attachment = handModel:ScriptLookupAttachment("vr_palm")
        local angles = handModel:GetAngles()
        local QAngles = QAngle(angles.x, angles.y, angles.z)
        thisEntity:SetOrigin(handModel:GetAttachmentOrigin(attachment))
        thisEntity:SetAngles(angles.x, angles.y, angles.z)
    end
    return FrameTime()
end