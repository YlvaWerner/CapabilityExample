// singleton
class UCapabilityTickWorld : UScriptWorldSubsystem
{
    private TMap<ECapabilityTickGroup, UCapabilityTickList> TickLists;

    private bool bSetupDone = false;
    bool IsSetupDone() const
    {
        return bSetupDone;
    }

    UFUNCTION(BlueprintOverride)
    void OnWorldBeginPlay()
    {
        int TickListSize = 5;//(int)ECapabilityTickGroup::Max;
        for (int i = 0; i < TickListSize; ++i)
        {
            ECapabilityTickGroup Group = ECapabilityTickGroup(i);
            TickLists.Add(Group, UCapabilityTickList());
        }
        bSetupDone = true;
    }

    UFUNCTION(BlueprintOverride)
    void Tick(float DeltaTime)
    {
        int TickListSize = 5;//ECapabilityTickGroup::Max;
        for (int i = 0; i < TickListSize; ++i)
        {
            ECapabilityTickGroup Group = ECapabilityTickGroup(i);
            TickLists[Group].TickAll(DeltaTime);
        }
    }

    void RegisterCapability(UCapability Capability)
    {
        FCapabilityTicker NewTicker;
        NewTicker.Capability = Capability;
        NewTicker.Sortable.Group = Capability.Group;
        NewTicker.Sortable.SubGroup = Capability.SubGroup;
        FCapabilityTickSortable Sorting = NewTicker.GetSorting();
        TickLists[Sorting.Group].Add(NewTicker);
        Capability.Setup();
    }
};