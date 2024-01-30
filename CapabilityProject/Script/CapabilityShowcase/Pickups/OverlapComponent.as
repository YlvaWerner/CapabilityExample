class UOverlapComponent : USphereComponent
{
    default SphereRadius = 120.0;
    default CollisionEnabled = ECollisionEnabled::QueryOnly;

    TArray<AActor> Overlappers;

    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
        OnComponentBeginOverlap.AddUFunction(this, n"BeginOverlap");
        OnComponentEndOverlap.AddUFunction(this, n"EndOverlap");
    }

    UFUNCTION()
    void BeginOverlap(UPrimitiveComponent OverlappedComponent, AActor OtherActor, UPrimitiveComponent OtherComponent, int BodyIndex, bool bSweep, const FHitResult&in HitResult)
    {
        if (!Overlappers.Contains(OtherActor))
            Overlappers.Add(OtherActor);
    }

    UFUNCTION()
    void EndOverlap(UPrimitiveComponent OverlappedComponent, AActor OtherActor, UPrimitiveComponent OtherComponent, int BodyIndex)
    {
        if (Overlappers.Contains(OtherActor))
            Overlappers.Remove(OtherActor);
    }
}