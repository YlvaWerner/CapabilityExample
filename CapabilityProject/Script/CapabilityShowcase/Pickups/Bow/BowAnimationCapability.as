class UBowAnimationCapability : UCapability
{
    default Tags.Add(BowTags::Bow);
    ABow BowOwner = nullptr;

    FRotator OriginalMesh1RelativeRot;
    FRotator OriginalMesh2RelativeRot;

    float Angle = 60.0;

    void Setup() override
    {
        BowOwner = Cast<ABow>(Owner);
        OriginalMesh1RelativeRot = BowOwner.BowMesh1.RelativeRotation;
        OriginalMesh2RelativeRot = BowOwner.BowMesh2.RelativeRotation;
    }

    bool ShouldActivate() const override
    {
        return true;
    }

    bool ShouldDeactivate() const override
    {
        return false;
    }

    void TickActive(float DeltaTime) override
    {
        // PrintToScreen("" + BowOwner.ChargedUpAlpha);

        FRotator ChargeRotation1 = OriginalMesh1RelativeRot;
        ChargeRotation1.Pitch += Math::Lerp(0.0, Angle, BowOwner.ChargedUpAlpha);
        BowOwner.BowMesh1.SetRelativeRotation(ChargeRotation1);
        FRotator ChargeRotation2 = OriginalMesh2RelativeRot;
        ChargeRotation2.Pitch += Math::Lerp(0.0, Angle, BowOwner.ChargedUpAlpha);
        BowOwner.BowMesh2.SetRelativeRotation(ChargeRotation2);
    }
}