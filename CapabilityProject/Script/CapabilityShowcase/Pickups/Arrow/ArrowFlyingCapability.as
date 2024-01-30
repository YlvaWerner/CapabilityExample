class UArrowFlyingCapability : UCapability
{
    AArrow ArrowOwner;

    float Speed = 1000.0;

    void Setup() override
    {
       ArrowOwner = Cast<AArrow>(Owner);
    }

    bool ShouldActivate() const override
    {
        if (ArrowOwner.bIsFlying)
            return true;
        return false;
    }

    bool ShouldDeactivate() const override
    {
        if (!ArrowOwner.bIsFlying)
            return true;
        return false;
    }

    void TickActive(float DeltaTime) override
    {
        if (ArrowOwner.OverlapComponent.Overlappers.Num() > 0)
            ArrowOwner.bIsFlying = false;
        
        ArrowOwner.SetActorLocation(ArrowOwner.ActorLocation + ArrowOwner.ActorForwardVector * Speed * DeltaTime);
    }
}