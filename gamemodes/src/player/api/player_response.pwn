forward OnCheckIfUserExistsResponse(Request:requestId, E_HTTP_STATUS:status, Node:node);
forward OnCreateUserResponse(Request:requestId, E_HTTP_STATUS:status, Node:node);
forward OnCheckUserPasswordResponse(Request:requestId, E_HTTP_STATUS:status, Node:node);
forward OnLoadUserDataResponse(Request:requestId, E_HTTP_STATUS:status, Node:node);

public OnCreateUserResponse(Request:requestId, E_HTTP_STATUS:status, Node:node) {
    new playerid = MAP_get_val_val(LoadRequestToPlayerID, _:requestId);
    MAP_remove_val(LoadRequestToPlayerID, _:requestId);

    if (status != HTTP_STATUS_OK) {
        printf("error playerid: %d", playerid);
    }
}


public OnCheckIfUserExistsResponse(Request:requestId, E_HTTP_STATUS:status, Node:node) {
    new playerid = MAP_get_val_val(LoadRequestToPlayerID, _:requestId);
    MAP_remove_val(LoadRequestToPlayerID, _:requestId);

    if (status == HTTP_STATUS_OK) {
        new bool:exists;
        JsonGetBool(node, "exists", exists);

        if (exists) {
            OnSignInUser(playerid);
        } else {
            OnSignUpUser(playerid);
        }
    }
}

public OnCheckUserPasswordResponse(Request:requestId, E_HTTP_STATUS:status, Node:node) {
    new playerid = MAP_get_val_val(LoadRequestToPlayerID, _:requestId);
    MAP_remove_val(LoadRequestToPlayerID, _:requestId);

    if (status == HTTP_STATUS_OK) {
        new bool:passwordCorrect;
        JsonGetBool(node, "passwordCorrect", passwordCorrect);

        if (passwordCorrect) {
            SendClientMessage(playerid, COLOR_INFO, "Success");
            OnLoadUserDataRequest(playerid);
        } else {
            new totalstring[1024] = "";
            format(totalstring, sizeof(totalstring), "Welcome to the server.\n Account %s password incorrect.\n\
            To Sign In, enter the password:", PlayerInfo[playerid][username]);
            Dialog_Show(playerid, SignInDialog, DIALOG_STYLE_INPUT, "Sign In", totalstring, "Next", "Cancel");
        }
    }
}


public OnLoadUserDataResponse(Request:requestId, E_HTTP_STATUS:status, Node:node) {
    new playerid = MAP_get_val_val(LoadRequestToPlayerID, _:requestId);
    MAP_remove_val(LoadRequestToPlayerID, _:requestId);


    if (status == HTTP_STATUS_OK) {
        JsonGetInt(node, "id", PlayerInfo[playerid][id]);
        JsonGetString(node, "username", PlayerInfo[playerid][username]);
        JsonGetString(node, "password", PlayerInfo[playerid][password]);
        JsonGetString(node, "email", PlayerInfo[playerid][email]);
        SpawnPlayer(playerid);
    }
}