matproxy.Add({
    name = "CTGNeckColor", 
    init = function(self, mat, values)
        self.ResultTo = values.resultvar
    end,
    bind = function(self, mat, ent)
        if not IsValid(ent) then return end
        if not IsValid(ent) then return end
        if IsValid(ent:GetOwner()) and ent:GetOwner():IsPlayer() then
            ent = ent:GetOwner()
        elseif IsValid(ent:GetParent()) and (ent:GetParent():IsPlayer() or ent:GetParent():IsRagdoll()) then
            ent = ent:GetParent()
            -- print("parent", ent)
        end

        if ent.GetRagdollOwner and IsValid(ent:GetRagdollOwner()) then
            ent = ent:GetRagdollOwner()         
        end

        local char
        if ent.CTG_GetCharacter then char = ent:CTG_GetCharacter() end
        if char and string.find(char.face, "mask") then
            mat:SetVector(self.ResultTo, Color(255, 255, 255):ToVector())
            mat:SetTexture("$basetexture", "models/skylyxx/ctg/characters/man/faces/face_mask")
        else
            mat:SetTexture("$basetexture", "models/skylyxx/ctg/characters/mat_proxy")
            mat:SetVector(self.ResultTo, ent:GetNWVector("CTG_MatProxies:CTGSkinColor", Color(255, 255, 255):ToVector()))
        end
    end 
})