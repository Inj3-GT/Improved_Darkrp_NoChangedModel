----------- // SCRIPT BY INJ3 
----------- // SCRIPT BY INJ3 
----------- // SCRIPT BY INJ3 
----------- // https://steamcommunity.com/id/Inj3/
----------- https://github.com/Inj3-GT
local ipr_config = {}

--- // Configuration
ipr_config.jb = { --- // Les métiers qui ne seront pas affectés et qui garderont leurs models spéciaux définis dans le fichier job du darkrp ! - Jobs that will not be affected and that will keep their special models defined in the darkrp job file!
    ["Mayor"] = true,
    ["Cook"] = true,
}
ipr_config.md = { -- Le model aléatoire qui sera défini à la première apparition du joueur ou lors du changement de métier // sauf spécifer dans "ipr_config.jb". - The randoms model that will be defined when changing jobs // unless specified in "ipr_config.jb".
    "models/player/eli.mdl",
    "models/player/group01/female_04.mdl",
    "models/player/kleiner.mdl",
    "models/player/barney.mdl",
    "models/player/p2_chell.mdl",
}
ipr_config.kp = true -- Garder la même tenue entre les changements de métier ? - Keeping the same outfit between job changes?
--- //

---- Do not touch the code below
-- //
do
    local function Ipr_RendMdl(p, o)
        if (ipr_config.kp) then
            if (ipr_config.jb[team.GetName(o)] and p.ipr_dkmdl) then
                return p.ipr_dkmdl
            end
            p.ipr_dkmdl = p:GetModel()
            
            return p.ipr_dkmdl
        else
            return table.Random(ipr_config.md)
        end
    end

    local function Ipr_CpTeam(o, n)
        return ((o == 1001) or (n == 1001)) and true or false
    end

    hook.Add("PlayerChangedTeam", "Ipr_NCM:DarkRP_ChangedT", function(ply, old, new)
        if (ipr_config.jb[team.GetName(new)]) or Ipr_CpTeam(old, new) then
            return
        end
        local ipr_c = Ipr_RendMdl(ply, old)

        timer.Simple(0.01, function()
            if not IsValid(ply) then
                return
            end

            ply:SetModel(ipr_c)
        end)
    end)
    
    hook.Add("PlayerSpawn", "Ipr_NCM:DarkRP_Death", function(ply)
        local ipr_c = Ipr_RendMdl(ply, ply:Team())

        timer.Simple(0.01, function()
            if not IsValid(ply) then
                return
            end
            
            ply:SetModel(ipr_c)
        end)
    end)
end

hook.Add("PlayerInitialSpawn", "Ipr_NCM:DarkRP_Init", function(ply)
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