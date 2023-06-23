--- // Configuration
local ipr_job_bl = { --- // Les métiers qui ne seront pas affectés et qui garderont leur model spéciaux défini dans le fichier job du darkrp !
    ["Hobo"] = true,
    ["Pompier"] = true,
}
local ipr_mdl_c = { -- Les models randoms qui seront définis lors du changement de job // sauf spécifer dans "ipr_job_bl".
    "models/player/combine_soldier_prisonguard.mdl",
    "models/player/group01/female_04.mdl",
}
local ipr_keep = true -- Garder la même tenue entre les changements de métier ?
---

hook.Add("PlayerChangedTeam", "ipr_nochanged_model", function(ply, old, new)
    if (ipr_job_bl[team.GetName(old)] or ipr_job_bl[team.GetName(new)]) then
        return
    end
    local ipr_c = (ipr_keep) and ply:GetModel() or table.Random(ipr_mdl_c)

    timer.Simple(0.01, function()
        if not IsValid(ply) then
            return
        end

        ply:SetModel(ipr_c)
    end)
end)

hook.Add("PlayerInitialSpawn", "ipr_nochanged_init", function(ply)
    timer.Simple(1, function()
        if not IsValid(ply) then
            return
        end
        if ipr_job_bl[team.GetName(ply:Team())] then
            return
        end
        local ipr_m = table.Random(ipr_mdl_c)

        ply:SetModel(ipr_m)
    end)
end)
