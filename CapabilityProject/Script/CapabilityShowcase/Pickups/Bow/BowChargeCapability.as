class UBowChargeCapability : UCapability
{
    default Tags.Add(BowTags::Bow);
   
    UCarriedComponent CarriedComp;
    UCapabilityComponent CapabilityComponent = nullptr;
    ABow BowOwner = nullptr;

    float ChargeDuration = 2.0;

    void Setup() override
    {
        BowOwner = Cast<ABow>(Owner);
        CarriedComp = UCarriedComponent::GetOrCreate(Owner);
        CapabilityComponent = UCapabilityComponent::Get(Owner);
    }

    bool ShouldActivate() const override
    {
        if (CarriedComp.CarryingPlayer == nullptr)
            return false;
        if (!CarriedComp.CarryingPlayer.bIsHoldingBowInput)
            return false;
        if (BowOwner.ChargedUpAlpha > 1.0 - KINDA_SMALL_NUMBER)
            return false;
        return true;
    }

    bool ShouldDeactivate() const override
    {
        if (CarriedComp.CarryingPlayer == nullptr)
            return true;
        if (!CarriedComp.CarryingPlayer.bIsHoldingBowInput)
            return true;
        if (BowOwner.ChargedUpAlpha > 1.0 - KINDA_SMALL_NUMBER)
            return true;
        return false;
    }

    void TickActive(float DeltaTime) override
    {
        float RealAlphaValue = Math::Clamp(ActiveDuration / ChargeDuration, 0.0, 1.0);
        BowOwner.ChargedUpAlpha = Math::EaseOut(0.0, 1.0, RealAlphaValue, 2.0);
    }
}