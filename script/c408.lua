--Great Catastrophe
--DarkayStudios - Fantino Custom
local s,id=GetID()
function s.initial_effect(c)
	-- Regresar monstruos a la mano e infiglir 600 de daño
	local e0=Effect.CreateEffect(c)
	e0:SetDescription(aux.Stringid(id,0))
    e0:SetCategory(CATEGORY_DAMAGE+CATEGORY_TOHAND)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	e0:SetCondition(s.atkcon)
	e0:SetTarget(s.atktg)
	e0:SetOperation(s.atkop)
	c:RegisterEffect(e0)
end
function s.atkcon(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetAttackTarget()
	return tc and tc:IsFaceup() and tc:IsControler(tp) and tc:IsRace(RACE_FIEND) and tc:IsLevel(6)
end
function s.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(s.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,#g,0,0)
    Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(600)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,600)
end
function s.filter(c)
	return c:IsFaceup() and c:IsAbleToHand()
end
function s.atkop(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetMatchingGroup(s.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
	end
    local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end