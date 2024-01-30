class UCapabilityTickList
{
    private TArray<FCapabilityTicker> Tickers;
    private TArray<FCapabilityTicker> TickersToAdd;

    void Add(FCapabilityTicker Ticker)
    {
       	TickersToAdd.Add(Ticker);
    }

    void TickAll(float DeltaTime)
    {
        if (TickersToAdd.Num() > 0)
        {
            for (FCapabilityTicker Ticker : TickersToAdd)
                Tickers.Add(Ticker);
            if (Tickers.Num() > 1)
                SortWithQuickRecursive(Tickers, 0, Tickers.Num() -1);
            TickersToAdd.Reset(256);
        }

        for (FCapabilityTicker Ticker : Tickers)
        {
            Ticker.Tick(DeltaTime);
        }
    }

    private void SortWithQuickRecursive(TArray<FCapabilityTicker>& SortList, int Left, int Right)
    {
        int LeftPartition = Left;
        int RightPartition = Right;
        FCapabilityTicker Temp;
        int Index = Math::IntegerDivisionTrunc(Left + Right, 2);
        const FCapabilityTicker Pivot = SortList[Index];
        /* partition */
        while (LeftPartition <= RightPartition) 
        {
            while (SortList[LeftPartition].Sortable.IsLessThan(Pivot.Sortable))
                LeftPartition++;
            while (SortList[RightPartition].Sortable.IsLargerThan(Pivot.Sortable))
                RightPartition--;
            
            if (LeftPartition <= RightPartition) {
                Temp = SortList[LeftPartition];
                SortList[LeftPartition] = SortList[RightPartition];
                SortList[RightPartition] = Temp;
                LeftPartition++;
                RightPartition--;
            }
        }
        /* recursion */
        if (Left < RightPartition)
            SortWithQuickRecursive(SortList,  Left, RightPartition);
        if (LeftPartition < Right)
            SortWithQuickRecursive(SortList, LeftPartition, Right);
    }
};
