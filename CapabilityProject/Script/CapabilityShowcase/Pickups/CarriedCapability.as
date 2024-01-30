class UCarriedCapability : UCapability
{
    UCapabilityComponent CapabilityComponent = nullptr;
    UOverlapComponent OverlapComponent = nullptr;
    UCarriedComponent CarriedComp;

    const float PickupDuration = 1.0; // should be in a setting maybe
    FVector OriginalLocation;
    FRotator OriginalRotation;
    bool bPickedUp = false;

    void Setup() override
    {
        CarriedComp = UCarriedComponent::GetOrCreate(Owner);
        OverlapComponent = UOverlapComponent::Get(Owner);
        CapabilityComponent = UCapabilityComponent::Get(Owner);
    }

    bool IsPlayerInRange() const
    {
        if (OverlapComponent.Overlappers.Num() == 0)
            return false;
        for (auto Overlapper : OverlapComponent.Overlappers)
        {
            if (Overlapper.IsA(ACapabilityPlayer::StaticClass()))
                return true;
        }
        return false;
    }

    bool ShouldActivate() const override
    {
        if (InactiveDuration < 2.0)
            return false;
        if (!IsPlayerInRange())
            return false;
        return true;
    }

    bool ShouldDeactivate() const override
    {
        return false; 
    }

    void OnActivated() override
    {
        CapabilityComponent.BlockCapabilities(CapabilityTags::Physics, this);
        for (auto Overlapper : OverlapComponent.Overlappers)
        {
            ACapabilityPlayer Player = Cast<ACapabilityPlayer>(Overlapper);
            if (Player != nullptr)
            {
                CarriedComp.CarryingPlayer = Player;
            }
        }
        OriginalLocation = Owner.ActorLocation;
        OriginalRotation = Owner.ActorRotation;
        bPickedUp = false;
    }

    void OnDeactivated() override
    {
        CapabilityComponent.UnblockCapabilities(CapabilityTags::Physics, this);
        if (bPickedUp)
            Owner.DetachFromActor();
        bPickedUp = false;
    }

    void TickActive(float DeltaTime) override
    {
        if (!bPickedUp)
            InterpolatePickup();
    }

    void InterpolatePickup()
    {
        FVector LocationInFrontOfPlayer = CarriedComp.CarryingPlayer.ActorLocation + CarriedComp.CarryingPlayer.ActorUpVector * 40.0 + CarriedComp.CarryingPlayer.ActorForwardVector * 60.0;
        if (ActiveDuration > PickupDuration)
        {
            Owner.SetActorLocation(LocationInFrontOfPlayer);
            Owner.SetActorRotation(CarriedComp.CarryingPlayer.ActorRotation);
            Owner.AttachToActor(CarriedComp.CarryingPlayer, NAME_None, EAttachmentRule::KeepWorld);
            bPickedUp = true;
        }
        else
        {
            float Alpha = Math::Clamp(ActiveDuration / PickupDuration, 0.0, 1.0);
            FVector InterpolatedLocation = Math::EaseOut(OriginalLocation, LocationInFrontOfPlayer, Alpha, 2.0);
            FHitResult Unused;
            Owner.SetActorLocation(InterpolatedLocation, false, Unused, true);
            FQuat LerpedRotation = FQuat::Slerp(OriginalRotation.Quaternion(), CarriedComp.CarryingPlayer.ActorRotation.Quaternion(), Alpha);
            Owner.SetActorRotation(LerpedRotation.Rotator());
        }
    }
}