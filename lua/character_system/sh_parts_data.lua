ATGCharactersSystem = ATGCharactersSystem or {}
ATGCharactersSystem.Parts = ATGCharactersSystem.Parts or {}

local jobs = {
	["all"] = {
		["genin"] = {
			TEAM_KONO_ELEVE, TEAM_KONO_GENIN1, TEAM_KONO_GENIN2, TEAM_KONO_CHUNIN1, TEAM_KONO_CHUNIN2, TEAM_KONO_CHUNIN3, TEAM_KONO_GRANDCHUNIN, TEAM_KONO_JONIN, TEAM_KONO_TOKUBETSU, TEAM_KONO_CMD, TEAM_KONO_CONSEILLER, TEAM_KONO_HOKAGE,
			TEAM_KIRI_ELEVE, TEAM_KIRI_GENIN1, TEAM_KIRI_GENIN2, TEAM_KIRI_CHUNIN1, TEAM_KIRI_CHUNIN2, TEAM_KIRI_CHUNIN3, TEAM_KIRI_GRANDCHUNIN, TEAM_KIRI_JONIN, TEAM_KIRI_TOKUBETSU, TEAM_KIRI_CMD, TEAM_KIRI_TOKUBETSU, TEAM_KIRI_CONSEILLER, TEAM_KIRI_MIZUKAGE,
			TEAM_KUMO_ELEVE, TEAM_KUMO_GENIN1, TEAM_KUMO_GENIN2, TEAM_KUMO_CHUNIN1, TEAM_KUMO_CHUNIN2, TEAM_KUMO_CHUNIN3, TEAM_KUMO_GRANDCHUNIN, TEAM_KUMO_JONIN, TEAM_KUMO_CONSEILLER, TEAM_KUMO_RAIKAGE,
		
			TEAM_UCHIHA_JEUNE, TEAM_UCHIHA_MEMBRE, TEAM_UCHIHA_CONFIRMEE, TEAM_UCHIHA_CHEF,
			TEAM_HYUGA_JEUNE, TEAM_HYUGA_MEMBRE, TEAM_HYUGA_CONFIRMEE, TEAM_HYUGA_CHEF,
			TEAM_NARA_JEUNE, TEAM_NARA_MEMBRE, TEAM_NARA_CONFIRMEE, TEAM_NARA_CHEF,

			TEAM_YUKI_JEUNE, TEAM_YUKI_MEMBRE, TEAM_YUKI_CONFIRMEE, TEAM_YUKI_CHEF,
			TEAM_TERUMI_JEUNE, TEAM_TERUMI_MEMBRE, TEAM_TERUMI_CONFIRMEE, TEAM_TERUMI_CHEF,
			TEAM_HOZUKI_JEUNE, TEAM_HOZUKI_MEMBRE, TEAM_HOZUKI_CONFIRMEE, TEAM_HOZUKI_CHEF,

			TEAM_CHINOIKE_JEUNE, TEAM_CHINOIKE_MEMBRE, TEAM_CHINOIKE_CONFIRMEE, TEAM_CHINOIKE_CHEF,
			TEAM_MARIO_JEUNE, TEAM_MARIO_MEMBRE, TEAM_MARIO_CONFIRMEE, TEAM_MARIO_CHEF,
			TEAM_RANTON_JEUNE, TEAM_RANTON_MEMBRE, TEAM_RANTON_CONFIRMEE, TEAM_RANTON_CHEF,
            
            TEAM_SENJU_JMEMBRE, TEAM_SENJU_MEMBRE, TEAM_SENJU_MEMBRECONFIRME, TEAM_SENJU_CHEF,

		},
		["chunin"] = {
			TEAM_KONO_CHUNIN1, TEAM_KONO_CHUNIN2, TEAM_KONO_CHUNIN3, TEAM_KONO_GRANDCHUNIN, TEAM_KONO_JONIN, TEAM_KONO_TOKUBETSU, TEAM_KONO_CMD, TEAM_KONO_CONSEILLER, TEAM_KONO_HOKAGE,
			TEAM_KIRI_CHUNIN1, TEAM_KIRI_CHUNIN2, TEAM_KIRI_CHUNIN3, TEAM_KIRI_GRANDCHUNIN, TEAM_KIRI_JONIN, TEAM_KIRI_TOKUBETSU, TEAM_KIRI_CMD, TEAM_KIRI_CONSEILLER, TEAM_KIRI_MIZUKAGE,
			TEAM_KUMO_CHUNIN1, TEAM_KUMO_CHUNIN2, TEAM_KUMO_CHUNIN3, TEAM_KUMO_GRANDCHUNIN, TEAM_KUMO_JONIN, TEAM_KUMO_CONSEILLER, TEAM_KUMO_RAIKAGE,

			TEAM_UCHIHA_MEMBRE, TEAM_UCHIHA_CONFIRMEE, TEAM_UCHIHA_CHEF,
			TEAM_HYUGA_MEMBRE, TEAM_HYUGA_CONFIRMEE, TEAM_HYUGA_CHEF,
			TEAM_NARA_MEMBRE, TEAM_NARA_CONFIRMEE, TEAM_NARA_CHEF,

			TEAM_YUKI_MEMBRE, TEAM_YUKI_CONFIRMEE, TEAM_YUKI_CHEF,
			TEAM_TERUMI_MEMBRE, TEAM_TERUMI_CONFIRMEE, TEAM_TERUMI_CHEF,
			TEAM_HOZUKI_MEMBRE, TEAM_HOZUKI_CONFIRMEE, TEAM_HOZUKI_CHEF,

			TEAM_CHINOIKE_MEMBRE, TEAM_CHINOIKE_CONFIRMEE, TEAM_CHINOIKE_CHEF,
			TEAM_MARIO_MEMBRE, TEAM_MARIO_CONFIRMEE, TEAM_MARIO_CHEF,
			TEAM_RANTON_MEMBRE, TEAM_RANTON_CONFIRMEE, TEAM_RANTON_CHEF,

            TEAM_SENJU_MEMBRE, TEAM_SENJU_MEMBRECONFIRME, TEAM_SENJU_CHEF,
		},

		["jonin"] = {
			TEAM_KONO_JONIN, TEAM_KONO_TOKUBETSU, TEAM_KONO_CMD, TEAM_KONO_CONSEILLER, TEAM_KONO_HOKAGE,
			TEAM_KIRI_JONIN, TEAM_KIRI_TOKUBETSU, TEAM_KIRI_CMD, TEAM_KIRI_CONSEILLER, TEAM_KIRI_MIZUKAGE,
			TEAM_KUMO_JONIN, TEAM_KUMO_TOKUBETSU, TEAM_KUMO_CMD, TEAM_KUMO_CONSEILLER, TEAM_KUMO_RAIKAGE,

			TEAM_UCHIHA_CONFIRMEE, TEAM_UCHIHA_CHEF,
			TEAM_HYUGA_CONFIRMEE, TEAM_HYUGA_CHEF,
			TEAM_NARA_CONFIRMEE, TEAM_NARA_CHEF,

			TEAM_YUKI_CONFIRMEE, TEAM_YUKI_CHEF,
			TEAM_TERUMI_CONFIRMEE, TEAM_TERUMI_CHEF,
			TEAM_HOZUKI_CONFIRMEE, TEAM_HOZUKI_CHEF,

			TEAM_CHINOIKE_CONFIRMEE, TEAM_CHINOIKE_CHEF,
			TEAM_MARIO_CONFIRMEE, TEAM_MARIO_CHEF,
			TEAM_RANTON_CONFIRMEE, TEAM_RANTON_CHEF,
            TEAM_SENJU_MEMBRECONFIRME, TEAM_SENJU_CHEF,
		}
	},

	["konoha"] = {
		["genin"] = {
			TEAM_KONO_ELEVE, TEAM_KONO_GENIN1, TEAM_KONO_GENIN2, TEAM_KONO_CHUNIN1, TEAM_KONO_CHUNIN2, TEAM_KONO_CHUNIN3, TEAM_KONO_GRANDCHUNIN, TEAM_KONO_JONIN, TEAM_KONO_TOKUBETSU, TEAM_KONO_CMD, TEAM_KONO_CONSEILLER, TEAM_KONO_HOKAGE,		

			TEAM_UCHIHA_JEUNE, TEAM_UCHIHA_MEMBRE, TEAM_UCHIHA_CONFIRMEE, TEAM_UCHIHA_CHEF,
			TEAM_HYUGA_JEUNE, TEAM_HYUGA_MEMBRE, TEAM_HYUGA_CONFIRMEE, TEAM_HYUGA_CHEF,
			TEAM_NARA_JEUNE, TEAM_NARA_MEMBRE, TEAM_NARA_CONFIRMEE, TEAM_NARA_CHEF,
            TEAM_SENJU_JMEMBRE, TEAM_SENJU_MEMBRE, TEAM_SENJU_MEMBRECONFIRME, TEAM_SENJU_CHEF,
		},
		["chunin"] = {
			TEAM_KONO_CHUNIN1, TEAM_KONO_CHUNIN2, TEAM_KONO_CHUNIN3, TEAM_KONO_GRANDCHUNIN, TEAM_KONO_JONIN, TEAM_KONO_TOKUBETSU, TEAM_KONO_CMD,TEAM_KONO_CONSEILLER, TEAM_KONO_HOKAGE,

			TEAM_UCHIHA_MEMBRE, TEAM_UCHIHA_CONFIRMEE, TEAM_UCHIHA_CHEF,
			TEAM_HYUGA_MEMBRE, TEAM_HYUGA_CONFIRMEE, TEAM_HYUGA_CHEF,
			TEAM_NARA_MEMBRE, TEAM_NARA_CONFIRMEE, TEAM_NARA_CHEF,
            TEAM_SENJU_MEMBRE, TEAM_SENJU_MEMBRECONFIRME, TEAM_SENJU_CHEF,
		},

		["jonin"] = {
			TEAM_KONO_JONIN, TEAM_KONO_CONSEILLER, TEAM_KONO_TOKUBETSU, TEAM_KONO_CMD, TEAM_KONO_HOKAGE,

			TEAM_UCHIHA_CONFIRMEE, TEAM_UCHIHA_CHEF,
			TEAM_HYUGA_CONFIRMEE, TEAM_HYUGA_CHEF,
			TEAM_NARA_CONFIRMEE, TEAM_NARA_CHEF,
            TEAM_SENJU_MEMBRECONFIRME, TEAM_SENJU_CHEF,
		},
	},
	["uchiha"] = {
		["genin"] = {
			TEAM_UCHIHA_JEUNE, TEAM_UCHIHA_MEMBRE, TEAM_UCHIHA_CONFIRMEE, TEAM_UCHIHA_CHEF,
		},
		["chunin"] = {
			TEAM_UCHIHA_MEMBRE, TEAM_UCHIHA_CONFIRMEE, TEAM_UCHIHA_CHEF,
		},
		["jonin"] = {
			TEAM_UCHIHA_CONFIRMEE, TEAM_UCHIHA_CHEF
		}
	},
	["hyuga"] = {
		["genin"] = {
			TEAM_HYUGA_JEUNE, TEAM_HYUGA_MEMBRE, TEAM_HYUGA_CONFIRMEE, TEAM_HYUGA_CHEF,
		},
		["chunin"] = {
			TEAM_HYUGA_MEMBRE, TEAM_HYUGA_CONFIRMEE, TEAM_HYUGA_CHEF,
		},
		["jonin"] = {
			TEAM_HYUGA_CONFIRMEE, TEAM_HYUGA_CHEF,
		},
	},
	["nara"] = {
		["genin"] = {
			TEAM_NARA_JEUNE, TEAM_NARA_MEMBRE, TEAM_NARA_CONFIRMEE, TEAM_NARA_CHEF,
		},
		["chunin"] = {
			TEAM_NARA_MEMBRE, TEAM_NARA_CONFIRMEE, TEAM_NARA_CHEF,
		},
		["jonin"] = {
			TEAM_NARA_CONFIRMEE, TEAM_NARA_CHEF,
		},
	},
    ["senju"] = {
        ["genin"] = {
            TEAM_SENJU_JMEMBRE, TEAM_SENJU_MEMBRE, TEAM_SENJU_MEMBRECONFIRME, TEAM_SENJU_CHEF,
        },
        ["chunin"] = {
            TEAM_SENJU_MEMBRE, TEAM_SENJU_MEMBRECONFIRME, TEAM_SENJU_CHEF,
        },
        ["jonin"] = {
            TEAM_SENJU_MEMBRECONFIRME, TEAM_SENJU_CHEF,
        },
    },

	["kiri"] = {
		["genin"] = {
			TEAM_KIRI_ELEVE, TEAM_KIRI_GENIN1, TEAM_KIRI_GENIN2, TEAM_KIRI_CHUNIN1, TEAM_KIRI_CHUNIN2, TEAM_KIRI_CHUNIN3, TEAM_KIRI_GRANDCHUNIN, TEAM_KIRI_TOKUBETSU, TEAM_KIRI_TOKUBETSU, TEAM_KIRI_JONIN, TEAM_KIRI_CONSEILLER, TEAM_KIRI_MIZUKAGE,

			TEAM_YUKI_JEUNE, TEAM_YUKI_MEMBRE, TEAM_YUKI_CONFIRMEE, TEAM_YUKI_CHEF,
			TEAM_TERUMI_JEUNE, TEAM_TERUMI_MEMBRE, TEAM_TERUMI_CONFIRMEE, TEAM_TERUMI_CHEF,
			TEAM_HOZUKI_JEUNE, TEAM_HOZUKI_MEMBRE, TEAM_HOZUKI_CONFIRMEE, TEAM_HOZUKI_CHEF,
		},
		["chunin"] = {
			TEAM_KIRI_CHUNIN1, TEAM_KIRI_CHUNIN2, TEAM_KIRI_CHUNIN3, TEAM_KIRI_GRANDCHUNIN, TEAM_KIRI_JONIN, TEAM_KONO_TOKUBETS, TEAM_KIRI_CONSEILLER, TEAM_KIRI_MIZUKAGE,

			TEAM_YUKI_MEMBRE, TEAM_YUKI_CONFIRMEE, TEAM_YUKI_CHEF,
			TEAM_TERUMI_MEMBRE, TEAM_TERUMI_CONFIRMEE, TEAM_TERUMI_CHEF,
			TEAM_HOZUKI_MEMBRE, TEAM_HOZUKI_CONFIRMEE, TEAM_HOZUKI_CHEF,
		},
		["jonin"] = {
			TEAM_KIRI_JONIN, TEAM_KIRI_TOKUBETSU, TEAM_KIRI_CMD, TEAM_KIRI_CONSEILLER, TEAM_KIRI_MIZUKAGE,

			TEAM_YUKI_CONFIRMEE, TEAM_YUKI_CHEF,
			TEAM_TERUMI_CONFIRMEE, TEAM_TERUMI_CHEF,
			TEAM_HOZUKI_CONFIRMEE, TEAM_HOZUKI_CHEF,
		},
	},
	["yuki"] = {
		["genin"] = {
			TEAM_YUKI_JEUNE, TEAM_YUKI_MEMBRE, TEAM_YUKI_CONFIRMEE, TEAM_YUKI_CHEF,
		},
		["chunin"] = {
			TEAM_YUKI_MEMBRE, TEAM_YUKI_CONFIRMEE, TEAM_YUKI_CHEF,
		},
		["jonin"] = {
			TEAM_YUKI_CONFIRMEE, TEAM_YUKI_CHEF,
		},
	},
	["terumi"] = {
		["genin"] = {
			TEAM_TERUMI_JEUNE, TEAM_TERUMI_MEMBRE, TEAM_TERUMI_CONFIRMEE, TEAM_TERUMI_CHEF,
		},
		["chunin"] = {
			TEAM_TERUMI_MEMBRE, TEAM_TERUMI_CONFIRMEE, TEAM_TERUMI_CHEF,
		},
		["jonin"] = {
			TEAM_YUKI_CONFIRMEE, TEAM_YUKI_CHEF,
		},
	},
	["hozuki"] = {
		["genin"] = {
			TEAM_HOZUKI_JEUNE, TEAM_HOZUKI_MEMBRE, TEAM_HOZUKI_CONFIRMEE, TEAM_HOZUKI_CHEF,
		},
		["chunin"] = {
			TEAM_HOZUKI_MEMBRE, TEAM_HOZUKI_CONFIRMEE, TEAM_HOZUKI_CHEF,
		},
		["jonin"] = {
			TEAM_HOZUKI_CONFIRMEE, TEAM_HOZUKI_CHEF,
		},
	},

	["kumo"] = {
		["genin"] = {
			TEAM_KUMO_ELEVE, TEAM_KUMO_GENIN1, TEAM_KUMO_GENIN2, TEAM_KUMO_CHUNIN1, TEAM_KUMO_CHUNIN2, TEAM_KUMO_CHUNIN3, TEAM_KUMO_GRANDCHUNIN, TEAM_KUMO_JONIN, TEAM_KUMO_CONSEILLER, TEAM_KUMO_RAIKAGE,

			TEAM_CHINOIKE_JEUNE, TEAM_CHINOIKE_MEMBRE, TEAM_CHINOIKE_CONFIRMEE, TEAM_CHINOIKE_CHEF,
			TEAM_MARIO_JEUNE, TEAM_MARIO_MEMBRE, TEAM_MARIO_CONFIRMEE, TEAM_MARIO_CHEF,
			TEAM_RANTON_JEUNE, TEAM_RANTON_MEMBRE, TEAM_RANTON_CONFIRMEE, TEAM_RANTON_CHEF,
		},
		["chunin"] = {
			TEAM_KUMO_CHUNIN1, TEAM_KUMO_CHUNIN2, TEAM_KUMO_CHUNIN3, TEAM_KUMO_GRANDCHUNIN, TEAM_KUMO_JONIN, TEAM_KUMO_CONSEILLER, TEAM_KUMO_RAIKAGE,

			TEAM_CHINOIKE_MEMBRE, TEAM_CHINOIKE_CONFIRMEE, TEAM_CHINOIKE_CHEF,
			TEAM_MARIO_MEMBRE, TEAM_MARIO_CONFIRMEE, TEAM_MARIO_CHEF,
			TEAM_RANTON_MEMBRE, TEAM_RANTON_CONFIRMEE, TEAM_RANTON_CHEF,
		},
		["jonin"] = {
			TEAM_KUMO_JONIN, TEAM_KUMO_CONSEILLER, TEAM_KUMO_RAIKAGE,

			TEAM_CHINOIKE_CONFIRMEE, TEAM_CHINOIKE_CHEF,
			TEAM_MARIO_CONFIRMEE, TEAM_MARIO_CHEF,
			TEAM_RANTON_CONFIRMEE, TEAM_RANTON_CHEF,
		},
	},
	["chinoike"] = {
		["genin"] = {
			TEAM_CHINOIKE_JEUNE, TEAM_CHINOIKE_MEMBRE, TEAM_CHINOIKE_CONFIRMEE, TEAM_CHINOIKE_CHEF,
		},
		["chunin"] = {
			TEAM_CHINOIKE_MEMBRE, TEAM_CHINOIKE_CONFIRMEE, TEAM_CHINOIKE_CHEF,
		},
		["jonin"] = {
			TEAM_CHINOIKE_CONFIRMEE, TEAM_CHINOIKE_CHEF,
		},
	},
	["marionnettistes"] = {
		["genin"] = {
			TEAM_MARIO_JEUNE, TEAM_MARIO_MEMBRE, TEAM_MARIO_CONFIRMEE, TEAM_MARIO_CHEF,
		},
		["chunin"] = {
			TEAM_MARIO_MEMBRE, TEAM_MARIO_CONFIRMEE, TEAM_MARIO_CHEF,
		},
		["jonin"] = {
			TEAM_MARIO_CONFIRMEE, TEAM_MARIO_CHEF,
		},
	},
	["ranton"] = {
		["genin"] = {
			TEAM_RANTON_JEUNE, TEAM_RANTON_MEMBRE, TEAM_RANTON_CONFIRMEE, TEAM_RANTON_CHEF,
		},
		["chunin"] = {
			TEAM_RANTON_MEMBRE, TEAM_RANTON_CONFIRMEE, TEAM_RANTON_CHEF,
		},
		["jonin"] = {
			TEAM_RANTON_CONFIRMEE, TEAM_RANTON_CHEF,
		},
	},
}


function ATG_Clothes_CanWear(clothe, sex, job)
	
	if job then
		if clothe.sex ~= nil then
			return clothe.sex == sex && table.HasValue(clothe.jobs, job)
		else
			return table.HasValue(clothe.jobs, job)
		end
	else
		return clothe.sex == sex
	end
end

-- function ATG_Clothes_CanWear(clothe, sex, job)
-- 	if clothe.sex == nil then
-- 		return true
-- 	else
-- 		return clothe.sex == sex
-- 	end
-- end

ATGCharactersSystem.Parts.Hairs = {
    -------------
    ---- MAN ----
    -------------
    ["hairs_baki"] = {
        name = "Coupe baki",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/hairs_baki.mdl",
    },
    ["hairs_cee"] = {
        name = "Coupe cee",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/hairs_cee.mdl",
    },
    ["hairs_darui"] = {
        name = "Coupe Darui",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/hairs_darui.mdl",
    },
    ["hairs_erwin"] = {
        name = "Coupe Kobayabite",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/hairs_erwin.mdl",
    },
    ["hairs_hidan"] = {
        name = "Coupe Hidan",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/hairs_hidan.mdl",
    },
    ["hairs_inoichi"] = {
        name = "Coupe Inoichi",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/hairs_inoichi.mdl",
    },
    ["hairs_kotetsu_3"] = {
        name = "Coupe Kotetsu",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/hairs_kotetsu_3.mdl",
    },
    ["hairs_obito_uchiha"] = {
        name = "Coupe Obito 2",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/hairs_obito_uchiha.mdl",
    },
    ["hairs_sasuke_v2"] = {
        name = "Coupe Danjuro sans bandeau",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/hairs_sasuke_v2.mdl",
    },
    ["hairs_tsume"] = {
        name = "Coupe Tsume",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/hairs_tsume.mdl",
    },
    ["hairs_obito"] = {
        name = "Coupe Obito",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/hairs_obito.mdl",
    },
    ["hairs_lee"] = {
        name = "Coupe Lee",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/hairs_lee.mdl",
    },
    ["hairs_kiba"] = {
        name = "Coupe Kiba",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/hairs_kiba.mdl",
    },
    ["hairs_kankuro"] = {
        name = "Coupe Kankuro",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/hairs_kankuro.mdl",
    },
    ["hairs_jiraya"] = {
        name = "Coupe Jiraya Gros Porc",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/hairs_jiraya.mdl",
    },
    ["hairs_iwabe"] = {
        name = "Coupe Iwabe",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/hairs_iwabe.mdl",
    },
    ["hairs_hashirama"] = {
        name = "Coupe Hashirama",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/hairs_hashirama.mdl",
    },
    ["hairs_gaara_2"] = {
        name = "Coupe Gaara 2",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/hairs_gaara_2.mdl",
    },
    ["hairs_gaara_1"] = {
        name = "Coupe Gaara 1",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/hairs_gaara_1.mdl",
    },
    ["hairs_denki"] = {
        name = "Coupe Denki",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/hairs_denki.mdl",
    },
    ["hairs_deidara"] = {
        name = "Coupe Deidara",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/hairs_deidara.mdl",
    },
    ["hairs_boruto_2"] = {
        name = "Coupe Boruto",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/hairs_boruto_2.mdl",
    },
    ["hairs_bonnet"] = {
        name = "Coupe Bonnet",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/hairs_bonnet.mdl",
    },
    ["hairs_a"] = {
        name = "A (Raikage)",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_a.mdl",
    },
    ["hairs_asuma"] = {
        name = "Asuma",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_asuma.mdl",
    },
    ["hairs_bee"] = {
        name = "Killer B",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_bee.mdl",
    },
    ["hairs_boruto"] = {
        name = "Boruto",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_boruto.mdl",
    },
    ["hairs_gai"] = {
        name = "Gai/Lee",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_gai.mdl",
    },
    ["hairs_haku"] = {
        name = "Haku",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_haku.mdl",
    },
    ["hairs_indra"] = {
        name = "Indra",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_indra.mdl",
    },
    ["hairs_inojin"] = {
        name = "Inojin",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_inojin.mdl",
    },
    ["hairs_iruka"] = {
        name = "Iruka",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_iruka.mdl",
    },
    ["hairs_itachi-noheadband"] = {
        name = "Itachi (Sans bandeau)",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_itachi-noheadband.mdl",
    },
    ["hairs_itachi"] = {
        name = "Itachi",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_itachi.mdl",
    },
    ["hairs_kakashi-gaiden"] = {
        name = "Kakashi (Enfant)",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_kakashi-gaiden.mdl",
    },
    ["hairs_kakashi-hokage"] = {
        name = "Kakashi (Hokage)",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_kakashi-hokage.mdl",
    },
    ["hairs_kakashi_twoeyes"] = {
        name = "Kakashi",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_kakashi_twoeyes.mdl",
    },
    ["hairs_kawaki"] = {
        name = "Kawaki",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_kawaki.mdl",
    },
    ["hairs_kisame"] = {
        name = "Kisame",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_kisame.mdl",
    },
    ["hairs_madara"] = {
        name = "Madara",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_madara.mdl",
    },
    ["hairs_man_01"] = {
        name = "Coupe diverse #1",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_man_01.mdl",
    },
    ["hairs_man_02"] = {
        name = "Coupe diverse #2", 
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_man_02.mdl",
    },
    ["hairs_man_03"] = {
        name = "Coupe diverse #3",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_man_03.mdl",
    },
    ["hairs_minato"] = {
        name = "Minato",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_minato.mdl",
    },
    ["hairs_mitsuki"] = {
        name = "Mitsuki",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_mitsuki.mdl",
    },
    ["hairs_nagato"] = {
        name = "Nagato",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_nagato.mdl",
    },
    ["hairs_neji-chunin"] = {
        name = "Neji (Chunin)",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_neji-chunin.mdl",
    },
    ["hairs_neji-genin"] = {
        name = "Neji (Genin)",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_neji-genin.mdl",
    },
    ["hairs_neji-noheadband"] = {
        name = "Neji (Sans bandeau)",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_neji-noheadband.mdl",
    },
    ["hairs_orochimaru"] = {
        name = "Orochimaru",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_orochimaru.mdl",
    },
    ["hairs_sai"] = {
        name = "Sai",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_sai.mdl",
    },
	["hairs_sasuke-boruto"] = {
        name = "Sasuke (Boruto)",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_sasuke-boruto.mdl",
    },
    ["hairs_sasuke-genin"] = {
        name = "Sasuke (Genin)",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_sasuke-genin.mdl",
    },
    ["hairs_sasuke_nukenin"] = {
        name = "Sasuke (Nukenin)",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_sasuke_nukenin.mdl",
    },
    ["hairs_sasuke_thelast"] = {
        name = "Sasuke (The Last)",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_sasuke_thelast.mdl",
    },
    ["hairs_shikaku"] = {
        name = "Shikaku",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_shikaku.mdl",
    },
    ["hairs_shikamaru"] = {
        name = "Shikamaru",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_shikamaru.mdl",
    },
    ["hairs_shisui"] = {
        name = "Shisui",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_shisui.mdl",
    },
    ["hairs_uchiha"] = {
        name = "Coupe Uchiha",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/hairs_uchiha.mdl",
    },
    ["hairs_tobirama"] = {
        name = "Tobirama",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_tobirama.mdl",
    },
    ["hairs_yamato"] = {
        name = "Yamato",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_yamato.mdl",
    },
    ["hairs_zabuza"] = {
        name = "Zabuza",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/hairs/hairs_zabuza.mdl",
    },
    ["hairs_asuma"] = {
        name = "Ashura",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/hairs_asuma.mdl",
    },
    ["hairs_slicked"] = {
        name = "coupe plaquée",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/hairs_slicked.mdl",
    },
    ["hairs_kakashi_v2"] = {
        name = "Kakashi v2",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/hairs_kakashi_v2.mdl",
    },
    ["hairs_tayuya"] = {
        name = "Tayuya",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/woman/hairs/hairs_tayuya.mdl",
    },
    ["cayzi_hairs_1"] = {
        name = "Queue de cheval",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/cayzi_hairs_1.mdl",
    },
    ["orga_hairs_1"] = {
        name = "Boruto Prologue",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/orga_hairs_1.mdl",
    },
    ["cayzi_hairs_2"] = {
        name = "Kureto coupe",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/cayzi_hairs_2.mdl",
    },
    -------------
    --- WOMAN ---
    -------------
    ["hairs_woman_5"] = {
        name = "Coupe Femme 3",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/hairs_woman_5.mdl",
    },
    ["hairs_woman_3"] = {
        name = "Coupe Femme 2",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/hairs_woman_3.mdl",
    },
    ["hairs_woman_1"] = {
        name = "Coupe Femme 1",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/hairs_woman_1.mdl",
    },
    ["hairs_anko"] = {
        name = "Anko",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/woman/hairs/hairs_anko.mdl",
    },
    ["hairs_himawari"] = {
        name = "Himawari",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/woman/hairs/hairs_himawari.mdl",
    },
    ["hairs_hinata-boruto"] = {
        name = "Hinata (Boruto)",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/woman/hairs/hairs_hinata-boruto.mdl",
    },
    ["hairs_hinata-og"] = {
        name = "Hinata (Enfant)",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/woman/hairs/hairs_hinata-og.mdl",
    },
    ["hairs_hinata-shippuden"] = {
        name = "Hinata (Shippuden)",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/woman/hairs/hairs_hinata-shippuden.mdl",
    },
    ["hairs_karin"] = {
        name = "Karin",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/woman/hairs/hairs_karin.mdl",
    },
    ["hairs_konan"] = {
        name = "Konan",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/woman/hairs/hairs_konan.mdl",
    },
    ["hairs_kurenai"] = {
        name = "Kurenai",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/woman/hairs/hairs_kurenai.mdl",
    },
    ["hairs_kushina"] = {
        name = "Kushina",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/woman/hairs/hairs_kushina.mdl",
    },
    ["hairs_mei"] = {
        name = "Mei",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/woman/hairs/hairs_mei.mdl",
    },
    ["hairs_naruto-sexyjutsu"] = {
        name = "Naruto (Sexyjutsu)",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/woman/hairs/hairs_naruto-sexyjutsu.mdl",
    },
    ["hairs_rin"] = {
        name = "Rin",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/woman/hairs/hairs_rin.mdl",
    },
    ["hairs_sakura-boruto-headband"] = {
        name = "Sakura (Sans bandeau)",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/woman/hairs/hairs_sakura-boruto-headband.mdl",
    },
    ["hairs_sakura-boruto"] = {
        name = "Sakura (Boruto)",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/woman/hairs/hairs_sakura-boruto.mdl",
    },
    ["hairs_sakura_og"] = {
        name = "Sakura (Enfant 1)",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/woman/hairs/hairs_sakura_og.mdl",
    },
    ["hairs_sakura_og2"] = {
        name = "Sakura (Enfant 2)",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/woman/hairs/hairs_sakura_og2.mdl",
    },
    ["hairs_sarada"] = {
        name = "Sarada",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/woman/hairs/hairs_sarada.mdl",
    },
    ["hairs_temari"] = {
        name = "Temari",
        sex = "woman",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/woman/hairs/hairs_temari.mdl",
    },
    ["hairs_tenten-og"] = {
        name = "Tenten (Enfant)",
        sex = "woman",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/woman/hairs/hairs_tenten-og.mdl",
    },
    ["hairs_tenten_boruto"] = {
        name = "Tenten (Boruto)",
        sex = "woman",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/woman/hairs/hairs_tenten_boruto.mdl",
    },
    ["hairs_tsunade"] = {
        name = "Tsunade",
        sex = "woman",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/woman/hairs/hairs_tsunade.mdl",
    },
    ["hairs_yugito"] = {
        name = "hairs_yugito",
        sex = "man",
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/woman/hairs/hairs_yugito.mdl",
    },
}

function ATG_Clothes_GetHairs(id)
    if not id then return end
    for key, value in pairs(ATGCharactersSystem.Parts.Hairs) do
        if key == id then
            return value
        end
    end
end

function ATG_Clothes_GetAvailableHairs(sex, job)
    local clothes = {}
    for key, value in pairs(ATGCharactersSystem.Parts.Hairs) do
        if ATG_Clothes_CanWear(value, sex, job) then
            table.insert(clothes, key)
        end
    end
    return ATG_UTILS.sort(clothes)
end

function ATG_Clothes_GetHairsID(model)
    for key, value in pairs(ATGCharactersSystem.Parts.Hairs) do
        if value.model == model then
            return key
        end
    end
    return -1
end


/* FACES */
ATGCharactersSystem.Parts.Faces = {
	["face_genin"] = {
        name = "(Visage enfant)",
        -- sex = "man", -- man / woman
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/faces/face_genin.mdl",
    },
    ["face_bee"] = {
        name = "(Visage Bee)",
        sex = "man", -- man / woman
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/face_bee.mdl",
    },
    ["face_erwin"] = {
        name = "(Visage Man 2)",
        sex = "man", -- man / woman
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/face_erwin.mdl",
    },
    ["face_kabuto"] = {
        name = "(Visage Kabuto)",
        sex = "man", -- man / woman
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/face_kabuto.mdl",
    },
    ["face_asuma"] = {
        name = "(Visage asuma)",
        sex = "man", -- man / woman
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/face_asuma.mdl",
    },
    ["face_orga_tobirama"] = {
        name = "(Visage Tobirama)",
        sex = "man", -- man / woman
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/face_orga_tobirama.mdl",
    },
    ["face_orga_pain"] = {
        name = "(Visage Pain au lait)",
        sex = "man", -- man / woman
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/face_orga_pain.mdl",
    },
    ["face_orga_hyuga"] = {
        name = "(Visage Hyuga)",
        sex = "man", -- man / woman
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/face_orga_hyuga.mdl",
    },
    ["face_woman_4"] = {
        name = "(Visage Fille/femme boucle d'oreille)",
        sex = "woman", -- man / woman
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/face_woman_4.mdl",
    },
    ["face_woman_3"] = {
        name = "(Visage Fille/femme)",
        sex = "woman", -- man / woman
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/face_woman_3.mdl",
    },
    ["face_woman"] = {
        name = "(Visage woman/chunin)",
        sex = "woman", -- man / woman
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/face_woman_2.mdl",
    },
    ["face_woman_1"] = {
        name = "(Visage woman 1)",
        sex = "woman", -- man / woman
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/face_woman_1.mdl",
    },
    ["face_rock"] = {
        name = "(Visage Lee 2)",
        sex = "man", -- man / woman
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/face_rock.mdl",
    },
    ["face_lee"] = {
        name = "(Visage Lee)",
        sex = "man", -- man / woman
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/face_lee.mdl",
    },
    ["face_kotetsu"] = {
        name = "(Visage Kotetsu)",
        sex = "man", -- man / woman
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/face_kotetsu.mdl",
    },
    ["face_shikamaru"] = {
        name = "(Visage shikamaru)",
        sex = "man", -- man / woman
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/face_shikamaru.mdl",
    },
    ["face_kawaki"] = {
        name = "(Visage kawaki)",
        sex = "man", -- man / woman
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/face_orga_kawaki.mdl",
    },
    ["face_mitsuki"] = {
        name = "(Visage mitsuki)",
        sex = "man", -- man / woman
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/face_mitsuki.mdl",
    },
    ["face_knk"] = {
        name = "(Visage knk)",
        sex = "man", -- man / woman
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/face_knk.mdl",
    },
    ["face_irk"] = {
        name = "(Visage irk)",
        sex = "man", -- man / woman
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/face_irk.mdl",
    },
    ["face_jiraya"] = {
        name = "(Visage Jiraya)",
        -- sex = "man", -- man / woman
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/face_jiraya.mdl",
    },
    ["face_madara"] = {
        name = "(Visage Madara)",
        sex = "man", -- man / woman
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/face_madara.mdl",
    },
    ["face_itachi"] = {
        name = "(Visage Itachi)",
        -- sex = "man", -- man / woman
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/face_itachi.mdl",
    },
    ["face_bandage"] = {
        name = "(Visage Bandage Blanc)",
        -- sex = "man", -- man / woman
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/face_bandage.mdl",
    },

    ["face"] = {
        name = "(Visage adulte)",
        -- sex = "man", -- man / woman
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/faces/face.mdl",
    },
    ["face_mask1"] = {
        name = "Masque 1",
        -- sex = "man", -- man / woman
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/faces/face_mask1.mdl",
    },
    ["cayzi_face_ibiki"] = {
        name = "Ibiki ",
        -- sex = "man", -- man / woman
        jobs = jobs["all"]["genin"],
        model = "models/ayko/ctg/characters/man/body/cayzi_face_ibiki.mdl",
    },
    ["face_mask2"] = {
        name = "Masque 2",
        -- sex = "man", -- man / woman
        jobs = jobs["all"]["genin"],
        model = "models/skylyxx/ctg/characters/man/faces/face_mask2.mdl",
    },
}
function ATG_Clothes_GetFace(id)
	if not id then return end
	for key, value in pairs(ATGCharactersSystem.Parts.Faces) do
		if key == id then
			return value
		end
	end
end
function ATG_Clothes_GetAvailableFaces(sex, job)
	local clothes = {}
	for key, value in pairs(ATGCharactersSystem.Parts.Faces) do
		if ATG_Clothes_CanWear(value, sex, job) then
			table.insert(clothes, key)
		end
	end
	return ATG_UTILS.sort(clothes)
end
function ATG_Clothes_GetFaceID(model)
	for key, value in pairs(ATGCharactersSystem.Parts.Faces) do
		if value.model == model then
			return key
		end
	end
	return -1
end

/* BODIES */
ATGCharactersSystem.Parts.Bodies = {

	["man_kakashi_gaiden"] = {
		name = "Genin Konoha - Kakashi (Jeune)",
		sex = "man", -- man / woman
		jobs = jobs["all"]["genin"],
		model = "models/ayko/ctg/characters/man/body/mora_pm_anim3.mdl",
	},
	["man_kakashi_gaiden_woman"] = {
		name = "Genin Konoha - Kakashi (Jeune)",
		sex = "woman", -- man / woman
		jobs = jobs["all"]["genin"],
		model = "models/skylyxx/ctg/characters/woman/body/woman_tenten.mdl",
	},
}

function ATG_Clothes_GetBody(id)
	if not id then return end
	for key, value in pairs(ATGCharactersSystem.Parts.Bodies) do
		if key == id then
			return value
		end
	end
	return ATGCharactersSystem.Parts.Bodies["man_genin1"] 
end

function ATG_Clothes_GetAvailableBodies(sex, job)

	local clothes = {}
	for key, value in pairs(ATGCharactersSystem.Parts.Bodies) do
		if ATG_Clothes_CanWear(value, sex, job) then
			table.insert(clothes, key)
		end
	end
	return ATG_UTILS.sort(clothes)
end


function ATG_Clothes_GetBodyID(model)
	for key, value in pairs(ATGCharactersSystem.Parts.Bodies) do
		if value.model == model then
			return key
		end
	end
	return -1
end

print("sh_parts_data.lua reloadded")