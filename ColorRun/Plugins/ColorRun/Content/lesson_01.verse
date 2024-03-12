using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
lesson_01 := class(creative_device):
    
    @editable var Prop: creative_prop = creative_prop{}
    OnBegin<override>()<suspends>:void=        
        loop:
            HideGlass(); 
            ShowGlass();    
        
    HideGlass()<suspends>:void=
        Sleep(5.0)
        Prop.Hide()
    ShowGlass()<suspends>:void=
        Sleep(2.0)
        Prop.Show()
