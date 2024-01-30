class UBowShootCapability : UCapability
{
    default Tags.Add(BowTags::Bow);
   
    ABow BowOwner = nullptr;
    UCarriedComponent CarriedComp;

    float ChargeDuration = 2.0;
    float LastChargeValue = 0.0;

    AArrow SpawnedArrow;

    void Setup() override
    {
        BowOwner = Cast<ABow>(Owner);
        CarriedComp = UCarriedComponent::GetOrCreate(Owner);
    }

    bool ShouldActivate() const override
    {
        if (BowOwner.ChargedUpAlpha < 0.8)
            return false;
        return true;
    }

    bool ShouldDeactivate() const override
    {
        if (BowOwner.ChargedUpAlpha > 0.8)
            return false;
        return true;
    }

    void OnActivated() override
    {
        Super::OnActivated();
        SpawnedArrow = Cast<AArrow>(SpawnActor(BowOwner.ArrowClass, BowOwner.ActorLocation + BowOwner.ActorForwardVector * 20.0, BowOwner.ActorRotation));
        SpawnedArrow.AttachToActor(BowOwner, NAME_None, EAttachmentRule::KeepWorld);
    }

    void OnDeactivated() override
    {
        Super::OnDeactivated();
        SpawnedArrow.DetachFromActor(EDetachmentRule::KeepWorld, EDetachmentRule::KeepWorld, EDetachmentRule::KeepWorld);
        SpawnedArrow.bIsFlying = true;
    }
}