matproxy.Add({
    name = "CTGHairsColor", 
    init = function(self, mat, values)
        self.ResultTo = values.resultvar
    end,
    bind = function(self, mat, ent)
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

        mat:SetVector(self.ResultTo, ent:GetNWVector("CTG_MatProxies:CTGHairsColor", Color(255, 255, 255):ToVector()))
    end 
})