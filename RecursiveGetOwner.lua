local RecursiveGetOwnerError = {}
RecursiveGetOwnerError.ButtonDebugNow = Menu.AddKeyOption({"RecursiveGetOwnerError"}, "Debug Now", Enum.ButtonCode.KEY_U)

function DebugNow()
    Log.Write("1")
    local tableAllNPC = NPCs.GetAll()
    Log.Write("GetLocal: "..Heroes.GetLocal())
    for indexNumberNPC, objectNPC in pairs(tableAllNPC) do
        if NPC.HasModifier( objectNPC, "modifier_kill") or (NPC.IsIllusion(objectNPC) and NPC.GetUnitName(objectNPC) == NPC.GetUnitName(Heroes.GetLocal()) ) then
            Log.Write("indexNumberNPC: "..indexNumberNPC.." objectNPC: "..objectNPC.." name:"..NPC.GetUnitName(objectNPC))
            Log.Write(tostring(Entity.OwnedBy(objectNPC, Heroes.GetLocal())))
            Log.Write(Entity.GetOwner(objectNPC)) -- Оказывается, не я владелец иллюзии
            --Log.Write( NPC.GetUnitName( Entity.GetOwner(objectNPC) ) ) -- У владельца моих иллюзий нет имени (bad argument)
            --Log.Write(Entity.RecursiveGetOwner(objectNPC)) -- Critial Error 
        end
    end
end

function RecursiveGetOwnerError.OnGameStart()
end

function RecursiveGetOwnerError.OnGameEnd()    
end

function RecursiveGetOwnerError.OnUpdate()
    if Menu.IsKeyDownOnce(RecursiveGetOwnerError.ButtonDebugNow) then
        DebugNow()
    end
end

return RecursiveGetOwnerError