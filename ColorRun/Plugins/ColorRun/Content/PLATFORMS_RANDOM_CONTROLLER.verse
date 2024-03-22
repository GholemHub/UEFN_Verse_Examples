
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /Verse.org/Random }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Fortnite.com/UI }

ColorTab := class(): 
    PlatformProp : creative_prop = creative_prop{}
    
    StartingPos: vector3 = vector3{}
    IsShown: logic = true
    ColorType<public>: int = 0 
    <# 
         0 - RED
         1 - GREEN
         2 - PUPRLE
         3 - BLUE
         4 - BLACK
         5 - WHITE
         6 - YELLOW
    #>

PLATFORMS_RANDOM_CONTROLLER := class(creative_device):
    @editable var TitleAssetRed : creative_prop_asset := DefaultCreativePropAsset #0
    @editable var TitleAssetGreen : creative_prop_asset := DefaultCreativePropAsset #1
    @editable var TitleAssetPurple : creative_prop_asset := DefaultCreativePropAsset #2
    @editable var TitleAssetBlue : creative_prop_asset := DefaultCreativePropAsset #3
    @editable var TitleAssetBlack : creative_prop_asset := DefaultCreativePropAsset #4
    @editable var TitleAssetWhite : creative_prop_asset := DefaultCreativePropAsset #5
    @editable var TitleAssetYellow : creative_prop_asset := DefaultCreativePropAsset #6
    @editable var TitleAssetWrong : creative_prop_asset := DefaultCreativePropAsset #7
    @editable HudDevice : hud_message_device = hud_message_device{}
    StringToMessage<localizes>(String: string) : message = "{String}"
    
    var TileGrid: [][]ColorTab = array{array{}}
    var Color: int = 0;
    var I:int = 0
    OnBegin<override>()<suspends>:void=        
        
        GenerateTitles()
        Sleep(10.0)
        loop:               
            RandomColor()
            SleepIterator()
            RemoveRandomTiles()
            SleepIterator()
            ShowAllTitels()
            if(I = 5):
                HudDevice.SetText(StringToMessage("Retargered"))
                HudDevice.Show()
                DestroyAllTitels()
                GenerateTitles()
            set I += 1
    
    RandomColor()<suspends>: void=
        set Color = GetRandomInt(0,6)
        if(Color = 0):
            HudDevice.SetText(StringToMessage("Red"))
        else if(Color = 1):
            HudDevice.SetText(StringToMessage("Green"))
        else if(Color = 2):
            HudDevice.SetText(StringToMessage("Purple"))
        else if(Color = 3):
            HudDevice.SetText(StringToMessage("Blue"))
        else if(Color = 4):
            HudDevice.SetText(StringToMessage("Black"))
        else if(Color = 5):
            HudDevice.SetText(StringToMessage("White"))
        else if(Color = 6):
            HudDevice.SetText(StringToMessage("Yellow"))
        else:

        HudDevice.Show()
        #set Widget = text_block{ DefaultText := ""}

    SleepIterator()<suspends>: void=
        var Time : float = 5.0 - (0.20 * I)
        if(Time <= 1.0):
            Sleep(1.0)
        else:
            Sleep(Time)
    ShowAllTitels(): void=
        if (NumberOfColumns : int = TileGrid[0].Length):
            for (X := 0..TileGrid.Length - 1, Y := 0..NumberOfColumns):
                if (Tile := TileGrid[X][Y]):
                    Tile.PlatformProp.Show()
    DestroyAllTitels(): void=
        if (NumberOfColumns : int = TileGrid[0].Length):
            for (X := 0..TileGrid.Length - 1, Y := 0..NumberOfColumns):
                if (Tile := TileGrid[X][Y]):
                    Tile.PlatformProp.Dispose()
    GenerateTitles(): void=
        block:
        set I = 0
        set TileGrid =
            for(X:=0..10):
                for(Y:=0..10):
                    CreateTitleForIndex(X,Y)

    CreateTitleForIndex(X : int, Y : int): ColorTab = 
        Spacer := 520.0
        if(XPos:= float[(X ) * Spacer], YPos :=float[(Y ) * Spacer]):
            Start := vector3{X := XPos, Y := YPos, Z := 4224.0}
            Rand := GetRandomInt(0,6)
            #Print("Message red{Rand}")
                if (Rand = 0):    
                    if (SpawnedProp := SpawnProp(TitleAssetRed, Start, IdentityRotation())(0)?):
                        Platform := ColorTab{PlatformProp := SpawnedProp, StartingPos := Start, IsShown := true, ColorType := 0}
                        #Print("Message red", ?Duration:=6.0)
                        return Platform
                    else:
                        #Print("Message0", ?Duration:=6.0)
                        return ColorTab{ColorType := 6}
                else if(Rand = 1):
                    if (SpawnedProp := SpawnProp(TitleAssetGreen, Start, IdentityRotation())(0)?):
                        Platform := ColorTab{PlatformProp := SpawnedProp, StartingPos := Start, IsShown := true, ColorType := 1}
                        return Platform
                    else:
                        #Print("Message 1", ?Duration:=6.0)
                        return ColorTab{ColorType := 6}
                else if(Rand = 2):
                    if (SpawnedProp := SpawnProp(TitleAssetPurple, Start, IdentityRotation())(0)?):
                        Platform := ColorTab{PlatformProp := SpawnedProp, StartingPos := Start, IsShown := true, ColorType := 2}
                        return Platform
                    else:
                       # Print("Message 2", ?Duration:=6.0)
                        return ColorTab{ColorType := 6}
                else if(Rand = 3):
                    if (SpawnedProp := SpawnProp(TitleAssetBlue, Start, IdentityRotation())(0)?):
                        Platform := ColorTab{PlatformProp := SpawnedProp, StartingPos := Start, IsShown := true, ColorType := 3}
                        return Platform
                    else:
                       # Print("Message 3", ?Duration:=6.0)
                        return ColorTab{ColorType := 6}
                else if(Rand = 4):
                    if (SpawnedProp := SpawnProp(TitleAssetBlack, Start, IdentityRotation())(0)?):
                        Platform := ColorTab{PlatformProp := SpawnedProp, StartingPos := Start, IsShown := true, ColorType := 4}
                        return Platform
                    else:
                        #Print("Message 4", ?Duration:=6.0)
                        return ColorTab{ColorType := 6}
                else if(Rand = 5):
                    if (SpawnedProp := SpawnProp(TitleAssetWhite, Start, IdentityRotation())(0)?):
                        Platform := ColorTab{PlatformProp := SpawnedProp, StartingPos := Start, IsShown := true, ColorType := 5}
                        return Platform
                    else:
                       # Print("Message 5", ?Duration:=6.0)
                        return ColorTab{ColorType := 6}
                else if(Rand = 6):
                    if (SpawnedProp := SpawnProp(TitleAssetYellow, Start, IdentityRotation())(0)?):
                        Platform := ColorTab{PlatformProp := SpawnedProp, StartingPos := Start, IsShown := true, ColorType := 6}
                        return Platform
                    else:
                        #Print("Message 6", ?Duration:=6.0)
                        return ColorTab{ColorType := 6}
                else:
                    #Print("Message 7", ?Duration:=6.0)
                    return ColorTab{ColorType := 6}
        else:
            #Print("Message 8", ?Duration:=6.0)
            return ColorTab{ColorType := 6}

    RemoveRandomTiles():void=
        if (NumberOfColumns : int = TileGrid[0].Length):
            <#Rand := GetRandomInt(0,6)
                    var Rand2: int := GetRandomInt(0,6)
                        loop:
                            if(Rand = Rand2):
                                set Rand2 = GetRandomInt(0,6)
                            else:
                                break
                                #>
            for (X := 0..TileGrid.Length - 1, Y := 0..NumberOfColumns):
                if (Tile := TileGrid[X][Y]):
                    
                    
                    if(Tile.ColorType <> Color):
                        Tile.PlatformProp.Hide()
                