
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /Verse.org/Random }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
SpawnArrayTitlesScript := class(creative_device):

    #@editable var Prop: creative_prop = creative_prop{}
    @editable var TitleAsset : creative_prop_asset := DefaultCreativePropAsset
    var TileGrid: [][]?creative_prop = array{array{}}
    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=        
        loop:
            GenerateTitles()
            RemoveRandomTiles()
            Sleep(3.0)
            ClearAllTitels()

        
    ClearAllTitels(): void=
        if (NumberOfColumns : int = TileGrid[0].Length):
            for (X := 0..TileGrid.Length - 1, Y := 0..NumberOfColumns):
                if (Tile := TileGrid[X][Y]?):
                    Tile.Dispose()
    GenerateTitles(): void=
        block:
        
        set TileGrid = 
            for(X:=0..5):
                for(Y:=0..5):
                    CreateTitleForIndex(X,Y)

    CreateTitleForIndex(X : int, Y : int): ?creative_prop = 
        Spacer := 500.0
        if(XPos:= float[X * Spacer], YPos :=float[Y * Spacer]):
            return SpawnProp(TitleAsset, vector3{X := XPos, Y := YPos, Z := 3000.0}, IdentityRotation())(0)
        else:
            return false
    RemoveRandomTiles():void=
        if (NumberOfColumns : int = TileGrid[0].Length):
            for (X := 0..TileGrid.Length - 1, Y := 0..NumberOfColumns):
                if (Tile := TileGrid[X][Y]?):
                    Rand := GetRandomInt(0,1)
                    if (Rand = 0):
                        Tile.Dispose()