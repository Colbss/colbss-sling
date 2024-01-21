Config = {
    Positions = {
        ["Back"] = {
            bone = 24816,
            x = 0.275,
            y = -0.15,
            z = -0.02,
            x_rotation = 0.0,
            y_rotation = 165.0,
            z_rotation = 0.0,
            offset_plane = "y",
            offset_dir = "-1"
        },
        ["Front"] = {
            bone = 10706,
            x = 0.0,
            y = 0.19,
            z = -0.25,
            x_rotation = 0.0,
            y_rotation = 75.0,
            z_rotation = 180.0,
            offset_plane = "y",
            offset_dir = "1"
        },
        ["Back_Low"] = {
            bone = 24816,
            x = 0.15,
            y = -0.15,
            z = -0.02,
            x_rotation = 0.0,
            y_rotation = 145.0,
            z_rotation = 0.0,
            offset_plane = "y",
            offset_dir = "-1"
        },
        ["Front_Low"] = {
            bone = 10706,
            x = 0.0,
            y = 0.19,
            z = -0.25,
            x_rotation = 0.0,
            y_rotation = 75.0,
            z_rotation = 180.0,
            offset_plane = "y",
            offset_dir = "1"
        },
        ["Back_Melee"] = {
            bone = 24816,
            x = 0.4,
            y = -0.15,
            z = -0.15,
            x_rotation = 0.0,
            y_rotation = 300.0,
            z_rotation = 0.0,
            offset_plane = "y",
            offset_dir = "-1"
        },
        ["Front_Melee"] = {
            bone = 11816,
            x = -0.1,
            y = 0,
            z = -0.2,
            x_rotation = 90.0, 
            y_rotation = 0.0, 
            z_rotation = 70.0,
            offset_plane = "y",
            offset_dir = "1"
        },
        ["Holster"] = {
            bone = 11816,
            x = 0,
            y = 0,
            z = 0.21,
            x_rotation = 270.0,
            y_rotation = 355.0,
            z_rotation = 340.0,
            offset_plane = "z",
            offset_dir = "1"
        }
    },

    -- Offset Directions:
    -- Back        : y negative
    -- Front       : y positive
    -- Back Melee  : y negative
    -- Front Melee : y positive
    -- Holster     : z postive

    -- Weapon names and hashes
    -- https://gist.github.com/BeyondPvP/f8ab34c8b207afddfa9dd5a1b864c7fe
    -- https://gist.github.com/root-cause/3f29d38179b12245a003fb4fff615335

    compatable_weapon_hashes = {

        -- Melee Weapons :
		 ['weapon_bat']                 = { model = "w_me_bat",                 hash = -1786099057 ,                            pos = "Back_Melee"},
		 ['weapon_crowbar']             = { model = "w_me_crowbar",             hash = -2067956739 ,                            pos = "Back_Melee"},
		 ['weapon_golfclub']            = { model = "w_me_gclub",               hash = 1141786504 ,                             pos = "Back_Melee"},
         ['weapon_hatchet']             = { model = "w_me_hatchet",             hash = -102973651 ,                             pos = "Back_Melee"},
         ['weapon_machete']             = { model = "w_me_machette_lr",         hash = -581044007 ,                             pos = "Back_Melee"},
         ['weapon_battleaxe']           = { model = "w_me_battleaxe",           hash = GetHashKey("weapon_battleaxe") ,         pos = "Back_Melee"},
         ['weapon_poolcue']             = { model = "w_me_poolcue",             hash = -1810795771 ,                            pos = "Back_Melee"},
         ['weapon_stone_hatchet']       = { model = "w_me_stonehatchet",        hash = 940833800 ,                              pos = "Back_Melee"},

         -- Assault Rifles :
         ["weapon_carbinerifle"]        = { model = "w_ar_carbinerifle",        hash = -2084633992 ,                            pos = "Back"},
         ["weapon_carbinerifle_mk2"]    = { model = "w_ar_carbineriflemk2",     hash = GetHashKey("weapon_carbinerifle_mk2") ,  pos = "Back"},
         ["weapon_assaultrifle"]        = { model = "w_ar_assaultrifle",        hash = -1074790547 ,                            pos = "Back"},
         ["weapon_assaultrifle_mk2"]    = { model = "w_ar_assaultriflemk2",     hash = 961495388 ,                              pos = "Back"},
         ["weapon_specialcarbine"]      = { model = "w_ar_specialcarbine",      hash = -1063057011 ,                            pos = "Back"},
         ["weapon_specialcarbine_mk2"]  = { model = "w_ar_specialcarbine",      hash = -1063057011 ,                            pos = "Back"},
         ["weapon_bullpuprifle"]        = { model = "w_ar_bullpuprifle",        hash = 2132975508 ,                             pos = "Back"},
         ["weapon_bullpuprifle_mk2"]    = { model = "w_ar_bullpupriflemk2",     hash = -2066285827 ,                            pos = "Back"},
         ["weapon_advancedrifle"]       = { model = "w_ar_advancedrifle",       hash = -1357824103 ,                            pos = "Back"},
         ["weapon_compactrifle"]        = { model = "w_ar_assaultrifle_smg",    hash = 1649403952 ,                             pos = "Back"},
         ["weapon_militaryrifle"]       = { model = "w_ar_bullpuprifleh4",      hash = -1658906650 ,                            pos = "Back"},

         -- Submachine Guns :
         ["weapon_microsmg"]            = { model = "w_sb_microsmg",            hash = 324215364 ,                              pos = "Back"},
         ["weapon_assaultsmg"]          = { model = "w_sb_assaultsmg",          hash = -270015777 ,                             pos = "Back_Low"},
         ["weapon_smg"]                 = { model = "w_sb_smg",                 hash = 736523883 ,                              pos = "Back_Low"},
         ["weapon_smgmk2"]              = { model = "w_sb_smgmk2",              hash = GetHashKey("weapon_smgmk2") ,           pos = "Back"},
         ["weapon_gusenberg"]           = { model = "w_sb_gusenberg",           hash = 1627465347 ,                             pos = "Back"},
         ["171789620"]                  = { model = "w_sb_pdw",                 hash = 1627465347 ,                             pos = "Back_Low"},

         -- Sniper Rifles :
         ["weapon_sniperrifle"]         = { model = "w_sr_sniperrifle",         hash = 100416529 ,                              pos = "Back"},
         ["weapon_heavysniper"]         = { model = "w_sr_heavysniper",         hash = 205991906 ,                              pos = "Back"},
         ["weapon_marksmanrifle"]       = { model = "w_sr_marksmanrifle",       hash = -952879014 ,                             pos = "Back"},
         ["weapon_heavysniper_mk2"]     = { model = "w_sr_heavysnipermk2",      hash = 177293209 ,                              pos = "Back"},
         ["weapon_marksmanrifle_mk2"]   = { model = "w_sr_marksmanriflemk2",    hash = 1785463520 ,                             pos = "Back"},

         -- Shotguns :
         ["weapon_assaultshotgun"]      = { model = "w_sg_assaultshotgun",      hash = -494615257 ,                             pos = "Back"},
         ["weapon_bullpupshotgun"]      = { model = "w_sg_bullpupshotgun",      hash = -1654528753 ,                            pos = "Back"},
         ["weapon_pumpshotgun"]         = { model = "w_sg_pumpshotgun",         hash = 487013001 ,                              pos = "Back"},
         ["weapon_musket"]              = { model = "w_ar_musket",              hash = -1466123874 ,                            pos = "Back"},
         ["weapon_heavyshotgun"]        = { model = "w_sg_heavyshotgun",        hash = 984333226 ,                              pos = "Back"},
         ["weapon_sawnoffshotgun"]      = { model = "w_sg_sawnoff",             hash = 2017895192 ,                             pos = "Back"},
         ["weapon_dbshotgun"]           = { model = "w_sg_doublebarrel",        hash = -275439685 ,                             pos = "Back"},
         ["weapon_autoshotgun"]         = { model = "w_sg_sweeper",             hash = 317205821 ,                              pos = "Back"},
         ["weapon_pumpshotgun_mk2"]     = { model = "w_sg_pumpshotgunmk2",      hash = 1432025498 ,                             pos = "Back"},
         ["weapon_combatshotgun"]       = { model = "w_sg_pumpshotgunh4",       hash = 94989220 ,                               pos = "Back"},

         -- LMGs :
         ["weapon_mg"]                  = { model = "w_mg_mg",                  hash = -1660422300 ,                            pos = "Back"},
         ["weapon_combatmg"]            = { model = "w_mg_combatmg",            hash = 2144741730 ,                             pos = "Back"},
         ["weapon_combatmg_mk2"]        = { model = "w_mg_combatmgmk2",         hash = -608341376 ,                             pos = "Back"},

        -- Pistols / Smaller SMGs :
		 ['weapon_heavypistol']         = { model = "w_pi_heavypistol",         hash = -771403250 ,                             pos = "Holster"},
         ['weapon_pistol50']            = { model = "w_pi_pistol50",            hash = -1716589765 ,                            pos = "Holster"},
         ["weapon_pistol"]              = { model = "w_pi_pistol",              hash = 453432689 ,                              pos = "Holster"},
         ["weapon_pistol_mk2"]          = { model = "w_pi_pistolmk2",           hash = -1075685676 ,                            pos = "Holster"},
         ["weapon_combatpistol"]        = { model = "w_pi_combatpistol",        hash = 1593441988 ,                             pos = "Holster"},
         ["weapon_appistol"]            = { model = "w_pi_appistol",            hash = 584646201 ,                              pos = "Holster"},
         ["weapon_snspistol"]           = { model = "w_pi_sns_pistol",          hash = -1076751822 ,                            pos = "Holster"},
         ["weapon_marksmanpistol"]      = { model = "W_PI_SingleShot",          hash = -598887786 ,                             pos = "Holster"},
         ["weapon_revolver"]            = { model = "w_pi_revolver",            hash = -1045183535 ,                            pos = "Holster"},
         ["weapon_revolver_mk2"]        = { model = "w_pi_revolvermk2",         hash = -879347409 ,                             pos = "Holster"},
         ["weapon_doubleaction"]        = { model = "w_pi_wep1_gun",            hash = -1746263880 ,                            pos = "Holster"},
         ["weapon_snspistol_mk2"]       = { model = "w_pi_sns_pistolmk2",       hash = -2009644972 ,                            pos = "Holster"},
         ["weapon_ceramicpistol"]       = { model = "w_pi_ceramic_pistol",      hash = 727643628 ,                              pos = "Holster"},
         ["weapon_navyrevolver"]        = { model = "w_pi_wep2_gun",            hash = -1853920116 ,                            pos = "Holster"},
         ["weapon_gadgetpistol"]        = { model = "w_pi_singleshoth4",        hash = 1470379660 ,                             pos = "Holster"}, -- Perico Pistol
         ["weapon_pistolxm3"]           = { model = "W_PI_Pistol_XM3",          hash = GetHashKey("weapon_pistolxm3") ,         pos = "Holster"}, -- WM 29 Pistol
         ["weapon_vintagepistol"]       = { model = "w_pi_vintage_pistol",      hash = 137902532 ,                              pos = "Holster"},
         ["weapon_minismg"]             = { model = "w_sb_minismg",             hash = -1121678507 ,                            pos = "Holster"},
         ["weapon_machinepistol"]       = { model = "w_sb_compactsmg",          hash = -619010992 ,                             pos = "Holster"},
         ["weapon_minismg"]             = { model = "w_sb_minismg",             hash = -1121678507 ,                            pos = "Holster"},

         -- Heavy Weapons :
         ["weapon_minigun"]             = { model = "w_mg_minigun",             hash = 1119849093 ,                             pos = "Back"},
         ["weapon_rpg"]                 = { model = "w_lr_rpg",                 hash = -1312131151 ,                            pos = "Back"},
         ["weapon_grenadelauncher"]     = { model = "w_lr_grenadelauncher",     hash = -1813897027 ,                            pos = "Back"},
         ["weapon_grenadelauncher_smoke"]= { model = "w_lr_grenadelauncher",    hash = 1305664598 ,                             pos = "Back"},
         ["weapon_firework"]            = { model = "w_lr_firework",            hash = 2138347493 ,                             pos = "Back"},
         ["weapon_railgun"]             = { model = "w_ar_railgun",             hash = 1834241177 ,                             pos = "Back"},
         ["weapon_hominglauncher"]      = { model = "w_lr_homing",              hash = 1672152130 ,                             pos = "Back"},
      }
}