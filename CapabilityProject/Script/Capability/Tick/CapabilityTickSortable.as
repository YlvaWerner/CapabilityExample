struct FCapabilityTickSortable
{
    ECapabilityTickGroup Group = ECapabilityTickGroup::Gameplay;
    ECapabilityTickSubGroup SubGroup = ECapabilityTickSubGroup::Normal;
    
    bool IsLessThan(const FCapabilityTickSortable Right) const
    {
        if (Group < Right.Group)
            return true;
        if (Group > Right.Group)
            return false;
        if (SubGroup < Right.SubGroup)
            return true;
        return false;
    }

    bool IsEqual(const FCapabilityTickSortable Right) const
    {
        if (Group != Right.Group)
            return false;
        if (SubGroup != Right.SubGroup)
            return false;
        return true;
    }

    bool IsLargerThan(const FCapabilityTickSortable Right) const
    {
        if (IsLessThan(Right))
            return false;
        return !IsEqual(Right);
    }
};