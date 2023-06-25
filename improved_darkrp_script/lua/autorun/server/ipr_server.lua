----------- // SCRIPT BY INJ3 
----------- // SCRIPT BY INJ3 
----------- // SCRIPT BY INJ3 
----------- // https://steamcommunity.com/id/Inj3/
----------- https://github.com/Inj3-GT
local ipr_config = {}

--- // Configuration
ipr_config.jb = { --- // Les métiers qui ne seront pas affectés et qui garderont leurs models spéciaux définis dans le fichier job du darkrp !
    ["Hobo"] = true,
    ["Pompier"] = true,
}
ipr_config.md = { -- Les models randoms qui seront définis lors du changement de job // sauf spécifer dans "ipr_job_bl".
    "models/player/combine_soldier_prisonguard.mdl",
    "models/player/group01/female_04.mdl",
}
ipr_config.kp = true -- Garder la même tenue entre les changements de métier ?
---

---- Do not touch the code below
-- //
do
    local function ipr_m(p, o)
        if (ipr_config.kp) then
            if (ipr_config.jb[team.GetName(o)]) then
                return p.ipr_dkmdl
            end
            p.ipr_dkmdl = p:GetModel()
            return p.ipr_dkmdl
        else
            return table.Random(ipr_config.md)
        end

        return p:GetModel()
    end

    local function ipr_d(o, n)
        return ((o == 1001) or (n == 1001)) and true or false
    end

    hook.Add("PlayerChangedTeam", "ipr_nochanged_model", function(ply, old, new)
        if (ipr_config.jb[team.GetName(new)]) or ipr_d(old, new) then
            return
        end
        local ipr_c = ipr_m(ply, old)

        timer.Simple(0.01, function()
            if not IsValid(ply) then
                return
            end

            ply:SetModel(ipr_c)
        end)
    end)
end

hook.Add("PlayerInitialSpawn", "ipr_nochanged_init", function(ply)
    timer.Simple(1, function()
        if not IsValid(ply) then
            return
        end
        if ipr_config.jb[team.GetName(ply:Team())] then
            return
        end
        local ipr_r = table.Random(ipr_config.md)

        ply:SetModel(ipr_r)
    end)
end)
