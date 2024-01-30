class UCapabilityComponent : UActorComponent
{
    bool bPerformedLateSetup = false;

    UPROPERTY(EditAnywhere)
    TArray<TSubclassOf<UCapability>> DefaultCapabilities;

    private TArray<UCapability> Capabilities;

    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
        for (auto CapabilityClass : DefaultCapabilities)
        {
            UCapability CapabilityInstance = Cast<UCapability>(NewObject(this, CapabilityClass));
            AddCapability(CapabilityInstance);
        }
    }

    void AddCapability(UCapability Capability)
    {
        auto TickWorld = UCapabilityTickWorld::Get();
        if (TickWorld == nullptr)
            return;
        
        Capability.Owner = Owner;
        Capabilities.Add(Capability);
        TickWorld.RegisterCapability(Capability);
    }

    void BlockCapabilities(FName CapabilityTag, UObject Instigator)
    {
        for (auto Capability : Capabilities)
        {
            if (Capability.Tags.Contains(CapabilityTag))
            {
                bool bAlreadyBlocking = Capability.Blockers.Contains(Instigator);
                check(!bAlreadyBlocking, "" + Instigator.GetName() + " is already blocking capability!");
                if (!bAlreadyBlocking)
                {
                    Capability.Blockers.Add(Instigator);
                }
            }
        }
    }

    void UnblockCapabilities(FName CapabilityTag, UObject Instigator)
    {
        for (auto Capability : Capabilities)
        {
            if (Capability.Tags.Contains(CapabilityTag))
            {
                bool bAlreadyBlocking = Capability.Blockers.Contains(Instigator);
                check(bAlreadyBlocking, "" + Instigator.GetName() + " isn't blocking capability!");
                if (bAlreadyBlocking)
                {
                    Capability.Blockers.Remove(Instigator);
                }
            }
        }
    }

    UFUNCTION(BlueprintOverride)
    void Tick(float DeltaSeconds)
    {
        PrintCapabilities();
    }

    private void PrintCapabilities()
    {
        for (auto Capability : Capabilities)
        {
            FLinearColor ActiveColor = Capability.bActive ? FLinearColor::Green : FLinearColor::Red;
            FString Activeness = Capability.bActive ? "Active" : "Inactive";
            PrintToScreen("" + Capability.GetName() + " " + Activeness, 0.0, ActiveColor);
        }
        PrintToScreen("" + Owner.GetName() + " CAPABILITIES:", 0.0, FLinearColor::LucBlue);
    }
}