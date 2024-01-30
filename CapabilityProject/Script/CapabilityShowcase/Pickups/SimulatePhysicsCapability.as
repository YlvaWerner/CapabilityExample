class USimulatePhysicsCapability : UCapability
{
    default Tags.Add(CapabilityTags::Physics);

    UStaticMeshComponent MeshComponent = nullptr;

    void Setup() override
    {
        MeshComponent = UStaticMeshComponent::Get(Owner);
    }

    bool ShouldActivate() const override
    {
        if (MeshComponent == nullptr)
            return false;
        return true;
    }

    bool ShouldDeactivate() const override
    {
        return false;
    }

    void OnActivated() override
    {
        MeshComponent.SetSimulatePhysics(true);
    }

    void OnDeactivated() override
    {
        MeshComponent.SetSimulatePhysics(false);
    }
}