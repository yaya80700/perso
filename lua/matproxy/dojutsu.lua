matproxy.Add({
    name = "CTGDojutsu", 
    init = function(self, mat, values)
        self.ResultTo = values.resultvar
    end,
    bind = function(self, mat, ent)
        if not IsValid(ent) then return end
        
        if IsValid(ent:GetOwner()) and ent:GetOwner():IsPlayer() then
            ent = ent:GetOwner()
        elseif IsValid(ent:GetParent()) and (ent:GetParent():IsPlayer() or ent:GetParent():IsRagdoll()) then
            ent = ent:GetParent()
        end

        if ent.GetRagdollOwner and IsValid(ent:GetRagdollOwner()) then
            ent = ent:GetRagdollOwner()         
        end

        -- mat:SetString("basetexture", "models/skylyxx/ctg/characters/eyes/eyes")
        local texture = "models/skylyxx/ctg/characters/eyes/"..ent:GetNWString("CTG_MatProxies:CTGDojutsu", "eyes")
        mat:SetTexture(self.ResultTo, texture)
    end 
})