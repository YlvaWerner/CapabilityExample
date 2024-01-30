namespace BowTags
{
    const FName Bow = n"Bow";
    const FName Charge = n"Charge";
    const FName Release = n"Release";
}

class ABow : APickupActor
{
    UPROPERTY(DefaultComponent, Attach = "MeshComponent")
    UStaticMeshComponent BowMesh1;
    UPROPERTY(DefaultComponent, Attach = "MeshComponent")
    UStaticMeshComponent BowMesh2;

    UPROPERTY(EditDefaultsOnly)
    TSubclassOf<AArrow> ArrowClass;

    float ChargedUpAlpha = 0.0;

    default CapabilityComponent.DefaultCapabilities.Add(UBowAnimationCapability::StaticClass());
    default CapabilityComponent.DefaultCapabilities.Add(UBowChargeCapability::StaticClass());
    default CapabilityComponent.DefaultCapabilities.Add(UBowReleaseCapability::StaticClass());
    default CapabilityComponent.DefaultCapabilities.Add(UBowShootCapability::StaticClass());
}