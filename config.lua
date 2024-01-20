Config = {
    Positions = {
        ["Back"] = {
            bone = 24816,
            x = 0.275,
            y = -0.15,
            z = -0.02,
            x_rotation = 0.0,
            y_rotation = 165.0,
            z_rotation = 0.0
        },
        ["Front"] = {
            bone = 10706,
            x = 0.0,
            y = 0.19,
            z = -0.25,
            x_rotation = 0.0,
            y_rotation = 75.0,
            z_rotation = 180.0
        },
        ["Back_Alt"] = {
            bone = 24816,
            x = -0.1,
            y = -0.15,
            z = 0.15,
            x_rotation = 0.0,
            y_rotation = 120.0,
            z_rotation = 0.0
        },
        ["Front_Alt"] = {
            bone = 11816,
            x = -0.1,
            y = 0,
            z = -0.2,
            x_rotation = 335.0,
            y_rotation = 275.0,
            z_rotation = 180.0
        }
    },

    compatable_weapon_hashes = {
         -- assault rifles:
         ["weapon_carbinerifle"]        = { model = "w_ar_carbinerifle",        hash = -2084633992 ,                            gun = true},
         ["weapon_carbinerifle_mk2"]    = { model = "w_ar_carbineriflemk2",     hash = GetHashKey("WEAPON_CARBINERIFLE_MK2") ,  gun = true},
         ["weapon_assaultrifle"]        = { model = "w_ar_assaultrifle",        hash = -1074790547 ,                            gun = true},
         ["weapon_specialcarbine"]      = { model = "w_ar_specialcarbine",      hash = -1063057011 ,                            gun = true},
         ["weapon_bullpuprifle"]        = { model = "w_ar_bullpuprifle",        hash = 2132975508 ,                             gun = true},
         ["weapon_advancedrifle"]       = { model = "w_ar_advancedrifle",       hash = -1357824103 ,                            gun = true},
         -- sub machine guns:
         ["weapon_microsmg"]            = { model = "w_sb_microsmg",            hash = 324215364 ,                              gun = true},
         ["weapon_assaultsmg"]          = { model = "w_sb_assaultsmg",          hash = -270015777 ,                             gun = true},
         ["weapon_smg"]                 = { model = "w_sb_smg",                 hash = 736523883 ,                              gun = true},
         ["weapon_smgmk2"]              = { model = "w_sb_smgmk2",              hash = GetHashKey("WEAPON_SMG_MK2") ,           gun = true},
         ["weapon_gusenberg"]           = { model = "w_sb_gusenberg",           hash = 1627465347 ,                             gun = true},
         -- sniper rifles:
         ["weapon_sniperrifle"]         = { model = "w_sr_sniperrifle",         hash = 100416529 ,                              gun = true},
         ["weapon_heavysniper"]         = { model = "w_sr_heavysniper",         hash = 205991906 ,                              gun = true},
         ["weapon_marksmanrifle"]         = { model = "w_sr_marksmanrifle",         hash = -952879014 ,                         gun = true},
         -- shotguns:
         ["weapon_assaultshotgun"]      = { model = "w_sg_assaultshotgun",      hash = -494615257 ,                             gun = true},
         ["weapon_bullpupshotgun"]      = { model = "w_sg_bullpupshotgun",      hash = -1654528753 ,                            gun = true},
         ["weapon_pumpshotgun"]         = { model = "w_sg_pumpshotgun",         hash = 487013001 ,                              gun = true},
         ["weapon_musket"]              = { model = "w_ar_musket",              hash = -1466123874 ,                            gun = true},
         ["weapon_heavyshotgun"]        = { model = "w_sg_heavyshotgun",        hash = GetHashKey("WEAPON_HEAVYSHOTGUN") ,      gun = true},
         -- big guns lol
         ["weapon_minigun"]        = { model = "w_mg_minigun",                  hash = 1119849093 ,                             gun = true},
		 -- melee weapons:
		 ['weapon_bat']                 = { model = "w_me_bat",                 hash = -1786099057 ,                            gun = false},
		 ['weapon_crowbar']             = { model = "w_me_crowbar",             hash = -2067956739 ,                            gun = false},
		 ['weapon_golfclub']            = { model = "w_me_gclub",               hash = 1141786504 ,                             gun = false},

      }
}