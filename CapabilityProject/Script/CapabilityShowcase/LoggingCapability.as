class ULoggingCapability : UCapability
{
    bool ShouldActivate() const override
    {
        if (InactiveDuration < 1.0)
            return false;
        return true;
    }

    bool ShouldDeactivate() const override
    {
        if (ActiveDuration > 1.0)
            return true;
        return false;
    }

    void OnActivated() override
    {
        Log("Logging Capability ACTIVATED");
    }

    void OnDeactivated() override
    {
        Log("Logging Capability DEACTIVATED");
    }

    void TickActive(float DeltaTime) override
    {
        Log("Logging Capability Active");
    }

    void TickInactive(float DeltaTime) override
    {
        Log("Logging Capability Inactive");
    }
}