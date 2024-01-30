class APickupActor : ACapabilityActor
{
    UPROPERTY(DefaultComponent, RootComponent)
    UStaticMeshComponent MeshComponent;

    UPROPERTY(DefaultComponent, Attach = MeshComponent)
    UBillboardComponent Billboard;

    UPROPERTY(DefaultComponent, Attach = MeshComponent)
    UOverlapComponent OverlapComponent;

    default CapabilityComponent.DefaultCapabilities.Add(USimulatePhysicsCapability::StaticClass());
    default CapabilityComponent.DefaultCapabilities.Add(UCarriedCapability::StaticClass());
}