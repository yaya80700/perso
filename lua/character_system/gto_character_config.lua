--
GTOCharSys.Resources = {
    Materials = {
        Background = Material("materials/solve_naruto_base/case_04.png"),
        Effect = Material("materials/charachtercrator/gto_charsys_effect.png"),
        Cloud = Material("materials/charachtercrator/nuage.png"),
        Disconect = Material("materials/charachtercrator/gto_charsys_disconect.png"),
        Create = Material("materials/charachtercrator/vreationperso1.png"),
        Buton = Material("materials/charachtercrator/gto_charsys_buton.png"),
        ButonNoHvr = Material("materials/charachtercrator/gto_charsys_buton_no_hover.png"),
        BackgroundCreation = Material("materials/solve_naruto_base/case_02.png"),
        Panel = Material("materials/charachtercrator/gto_charsys_panel.png"),
        Vip = Material("materials/charachtercrator/charsys_createsvip.png"),
        Staff = Material("materials/charachtercrator/charsys_createsvip.png"),
        Man = Material("materials/charachtercrator/men.png"),
        Woman = Material("materials/charachtercrator/woman.png"),
        Text = Material("materials/charachtercrator/gto_charsys_txtentry.png"),
        IdentityHover = Material("materials/charachtercrator/identity_backgoud_hover.png"),
        Identity = Material("materials/charachtercrator/identity_backgoud_nohover.png"),
        face = Material("materials/charachtercrator/face.png"),
        face_hover = Material("materials/charachtercrator/face_hover.png"),
        body = Material("materials/charachtercrator/body.png"),
        body_hover = Material("materials/charachtercrator/body_hover.png"),
        konoha_logo = Material("materials/solve_naruto_base/konoha_logo_scoreboard.png"),
        kiri_logo = Material("materials/solve_naruto_base/kiri_logo.png"),
        Save =  Material("materials/charachtercrator/gto_charsys_save.png"),
        SaveHover =  Material("materials/charachtercrator/gto_charsys_save_hover.png"),
        Play =  Material("materials/charachtercrator/perso1.png"),
        PlayButon =  Material("materials/charachtercrator/play.png"),
        Poubelle = Material("materials/solve_naruto_base/quit_red.png"),
        Color_Select = Material("materials/charachtercrator/gto_charsys_txtentry.png"),
        Color_Select_Hover = Material("materials/charachtercrator/gto_charsys_txtentry.png"),
        Pallete = Material("materials/charachtercrator/pallette.png"),



        Infos = "materials/charachtercrator/gto_charsys_identity.png"


    },
    Ranks = {
        [1] = { -- SLOT 1
            ["user"] = true,
            ["vip"] = true,
	        ["animateur"] = true,
            ["administrateur"] = true,
            ["moderateur"] = true,
            ["responsable"] = true,
            ["admin"] = true,
            ["superadmin"] = true,
        },
        [2] = { -- SLOT 2
            ["user"] = false,
            ["animateur"] = true,
            ["vip"] = true,
            ["admin"] = true,
            ["administrateur"] = true,
            ["moderateur"] = true,
            ["responsable"] = true,
            ["superadmin"] = true,
        },
        [3] = { -- SLOT 3 
            ["user"] = false,
            ["vip"] = false,
	        ["animateur"] = false,
            ["admin"] = true,
            ["administrateur"] = true,
            ["moderateur"] = true,
            ["responsable"] = true,
            ["superadmin"] = true,
        },
    },

    Access = {
        ["superadmin"] = true,
        ["admin"] = true,
    }

}