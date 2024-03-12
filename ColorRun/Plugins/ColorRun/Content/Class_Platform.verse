
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.


pawn := class():
    var TotalHP<private> : int = 100
    var CurrentHP<private>: int = 100

    TakeDamage<public>(DamagePoints: int):void=
        set CurrentHP -=DamagePoints

    Heal<public>(HealPoints: int) : void =
        set CurrentHP += HealPoints

    IsAlive<public>()<decides>:void=
        if(CurrentHP > 0){true}
        else {false}

platform := class(pawn): 
    PlatformProp : creative_prop = creative_prop{}
    StartingPos: vector3 = vector3{}
    EndingPos : vector3 = vector3{}
    Move<public>()<suspends>: void=
        loop:
            if(not PlatformProp.IsValid[]){break}
            PlatformProp.MoveTo(EndingPos, IdentityRotation(), 5.0)
            if(not PlatformProp.IsValid[]){break}
            PlatformProp.MoveTo(StartingPos, IdentityRotation(), 5.0)

Class_Platform := class(creative_device):

    @editable PlatformAsset : creative_prop_asset = DefaultCreativePropAsset

    var Platforms : []platform = array{}
    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        SomePawn := pawn{}
        SomePawn.TakeDamage(10)

        NewPlatform := platform{}
        NewPlatform.TakeDamage(10)

        InitPlatforms()
        MovePlatforms()

    InitPlatforms():void=
        for(IDX:=1..20):
            Start := vector3{X:=IDX*500.0, Y:=IDX*500.0, Z:= + 300.0}
            End := vector3{X:=IDX*3000.0, Y:=IDX*3000.0, Z:= + 300.0}
            if(SpawnedProp :=SpawnProp(PlatformAsset, Start, IdentityRotation())(0)?):
                Platform := platform{PlatformProp := SpawnedProp, StartingPos := Start, EndingPos := End}
                set Platforms += array{Platform}
    
    MovePlatforms():void=
        for (Platform : Platforms):
            spawn:
                Platform.Move()
