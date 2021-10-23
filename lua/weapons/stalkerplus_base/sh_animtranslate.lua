function SWEP:TranslateSequence(seq)
    seq = self:RunHook("Hook_TranslateSequence", seq) or seq

    if self:GetSightAmount() > 0 and self:HasSequence(seq .. "_iron") then
        seq = seq .. "_iron"

        print(seq)
    end

    if (self:Clip1() == 0 or self:GetEmptyReload()) and self:HasSequence(seq .. "_empty") then
        seq = seq .. "_empty"
    end

    seq = self.AnimationTranslationTable[seq] or seq

    if istable(seq) then
        seq["BaseClass"] = nil
        seq = seq[math.Round(util.SharedRandom("STALKERPLUS_animtr", 1, #seq))]
    end

    return seq
end

function SWEP:HasSequence(seq)
    -- seq = self:TranslateSequence(seq)
    local vm = self:GetVM()
    seq = vm:LookupSequence(seq)

    return seq != -1
end