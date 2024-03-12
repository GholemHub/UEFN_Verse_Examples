
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

var Static_Glass_To_Show:weak_map(session, int) = map{}

GLOBAL_INST := class(creative_device):
    OnBegin<override>()<suspends>:void=
           if(X := Static_Glass_To_Show[GetSession()]):

           else:
                if(set Static_Glass_To_Show[GetSession()] = 0):

            