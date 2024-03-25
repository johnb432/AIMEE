class CfgVehicles {
    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class ACE_TeamManagement {
                class GVAR(stepDownLeader) {
                    condition = QUOTE(GVAR(settingDropLeaderAction) && {leader _player == _player} && {count units _player > 1});
                    displayName = CSTRING(StepDown);
                    exceptions[] = {"isNotSwimming"};
                    icon = ICON_STEP_DOWN_LEADER;
                    statement = QUOTE(private _group = group _player; private _assignedTeam = assignedTeam _player; _assignedTeam = [ARR_2(_assignedTeam,'MAIN')] select (_assignedTeam == ''); [_player] joinSilent grpNull; [_player] joinSilent _group; _player assignTeam _assignedTeam;);
                };
            };
        };
    };
};
