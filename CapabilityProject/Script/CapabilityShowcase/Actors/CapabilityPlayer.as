class ACapabilityPlayer : ACharacter
{
    UPROPERTY(DefaultComponent)
    UCapabilityComponent CapabilityComponent;

    bool bIsHoldingBowInput = false;

    UFUNCTION(BlueprintCallable)
    void BowInput(bool bPressed)
    {
        bIsHoldingBowInput = bPressed;
    }
}