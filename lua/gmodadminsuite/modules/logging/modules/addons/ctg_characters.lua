CTG_BLOGS = CTG_BLOGS or {}

-- CTGCharactersSystem.Config.Loggers = {
-- 	[0] = "(Admin) Modification d'un personnage",
-- 	[1] = "(Admin) Suppression d'un personnage",
-- 	[2] = "(Admin) PSS - Ajout",
-- 	[3] = "(Admin) PSS - Retrait",
-- 	[4] = "Création d'un personnage",
-- 	[5] = "Suppression d'un personnage",
-- 	[6] = "Modification d'un personnage",
-- }

CTG_BLOGS["Characters"] = {
	["admin-edit"] = GAS.Logging:MODULE(),
	["admin-del"] = GAS.Logging:MODULE(),
	["admin-pss-add"] = GAS.Logging:MODULE(),
	["admin-pss-del"] = GAS.Logging:MODULE(),
	["create"] = GAS.Logging:MODULE(),
	["del"] = GAS.Logging:MODULE(),
	["edit"] = GAS.Logging:MODULE(),
}

CTG_BLOGS["Characters"]["admin-edit"].Category = "CTG - Characters"
CTG_BLOGS["Characters"]["admin-edit"].Name = "(Admin) Modification"
CTG_BLOGS["Characters"]["admin-edit"].Colour = Color(190, 0, 0)
GAS.Logging:AddModule(CTG_BLOGS["Characters"]["admin-edit"])

CTG_BLOGS["Characters"]["admin-del"].Category = "CTG - Characters"
CTG_BLOGS["Characters"]["admin-del"].Name = "(Admin) Suppression"
CTG_BLOGS["Characters"]["admin-del"].Colour = Color(190, 0, 0)
GAS.Logging:AddModule(CTG_BLOGS["Characters"]["admin-del"])

CTG_BLOGS["Characters"]["admin-pss-add"].Category = "CTG - Characters"
CTG_BLOGS["Characters"]["admin-pss-add"].Name = "(Admin) PSS Ajout"
CTG_BLOGS["Characters"]["admin-pss-add"].Colour = Color(190, 0, 0)
GAS.Logging:AddModule(CTG_BLOGS["Characters"]["admin-pss-add"])

CTG_BLOGS["Characters"]["admin-pss-del"].Category = "CTG - Characters"
CTG_BLOGS["Characters"]["admin-pss-del"].Name = "(Admin) PSS Suppression"
CTG_BLOGS["Characters"]["admin-pss-del"].Colour = Color(190, 0, 0)
GAS.Logging:AddModule(CTG_BLOGS["Characters"]["admin-pss-del"])

CTG_BLOGS["Characters"]["create"].Category = "CTG - Characters"
CTG_BLOGS["Characters"]["create"].Name = "Creation"
CTG_BLOGS["Characters"]["create"].Colour = Color(190, 0, 0)
GAS.Logging:AddModule(CTG_BLOGS["Characters"]["create"])

CTG_BLOGS["Characters"]["del"].Category = "CTG - Characters"
CTG_BLOGS["Characters"]["del"].Name = "Suppression"
CTG_BLOGS["Characters"]["del"].Colour = Color(190, 0, 0)
GAS.Logging:AddModule(CTG_BLOGS["Characters"]["del"])

CTG_BLOGS["Characters"]["edit"].Category = "CTG - Characters"
CTG_BLOGS["Characters"]["edit"].Name = "Modification"
CTG_BLOGS["Characters"]["edit"].Colour = Color(190, 0, 0)
GAS.Logging:AddModule(CTG_BLOGS["Characters"]["edit"])