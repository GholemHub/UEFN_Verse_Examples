
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

HIDE_GLASS_In30Sec := class(creative_device):
    @editable var Prop: creative_prop = creative_prop{}
    OnBegin<override>()<suspends>:void=   
        loop:
            X := if (Y := Static_Glass_To_Show[GetSession()]):
                    HideGlass()
                    ShowGlass()
                if:
                    set Static_Glass_To_Show[GetSession()] = 1
            
    HideGlass()<suspends>:void=
        if(Y := Static_Glass_To_Show[GetSession()]):
            if(Y <= 0):
                Sleep(5.0)
                Prop.Hide()
                
    ShowGlass()<suspends>:void=
        Sleep(2.0)
        Prop.Show()