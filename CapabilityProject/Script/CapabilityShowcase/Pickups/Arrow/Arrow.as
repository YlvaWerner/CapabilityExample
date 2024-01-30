class AArrow : ACapabilityActor
{
    UPROPERTY(DefaultComponent, RootComponent)
    UStaticMeshComponent MeshComponent;

    UPROPERTY(DefaultComponent, Attach = "MeshComponent")
    UStaticMeshComponent ArrowMesh;

    UPROPERTY(DefaultComponent, Attach = "MeshComponent")
    UOverlapComponent OverlapComponent;

    default CapabilityComponent.DefaultCapabilities.Add(UArrowFlyingCapability::StaticClass());
    bool bIsFlying = false;
}