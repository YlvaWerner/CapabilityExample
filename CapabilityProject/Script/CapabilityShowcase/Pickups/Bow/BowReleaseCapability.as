class UBowReleaseCapability : UCapability
{
    default Tags.Add(BowTags::Bow);
    default Tags.Add(BowTags::Release);

    UCarriedComponent CarriedComp;
    ABow BowOwner = nullptr;

    void Setup() override
    {
        BowOwner = Cast<ABow>(Owner);
        CarriedComp = UCarriedComponent::GetOrCreate(Owner);
    }

    bool ShouldActivate() const override
    {
        if (CarriedComp.CarryingPlayer == nullptr)
            return false;
        if (CarriedComp.CarryingPlayer.bIsHoldingBowInput)
            return false;
        if (BowOwner.ChargedUpAlpha < KINDA_SMALL_NUMBER)
            return false;
        return true;
    }

    bool ShouldDeactivate() const override
    {
        if (CarriedComp.CarryingPlayer == nullptr)
            return true;
        if (BowOwner.ChargedUpAlpha < KINDA_SMALL_NUMBER)
            return true;
        return false;
    }

    void TickActive(float DeltaTime) override
    {
        BowOwner.ChargedUpAlpha *= 0.5;
        BowOwner.ChargedUpAlpha -= DeltaTime;
        BowOwner.ChargedUpAlpha = Math::Clamp(BowOwner.ChargedUpAlpha, 0.0, 1.0);
    }
}