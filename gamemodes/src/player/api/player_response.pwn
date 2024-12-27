forward OnCheckIfUserExistsResponse(Request:requestId, E_HTTP_STATUS:status, Node:node);
forward OnCreateUserResponse(Request:requestId, E_HTTP_STATUS:status, Node:node);
forward OnCheckUserPasswordResponse(Request:requestId, E_HTTP_STATUS:status, Node:node);
forward OnLoadUserDataResponse(Request:requestId, E_HTTP_STATUS:status, Node:node);
forward OnSaveUserDataResponse(Request:requestId, E_HTTP_STATUS:status, Node:node);

public OnCreateUserResponse(Request:requestId, E_HTTP_STATUS:status, Node:node) {
    new playerid = MAP_get_val_val(LoadRequestToPlayerID, _:requestId);
    MAP_remove_val(LoadRequestToPlayerID, _:requestId);

    if (status != HTTP_STATUS_OK) {
        printf("error playerid: %d", playerid);
    }
    LoadDataUserService(playerid, node);
}


public OnCheckIfUserExistsResponse(Request:requestId, E_HTTP_STATUS:status, Node:node) {
    new playerid = MAP_get_val_val(LoadRequestToPlayerID, _:requestId);
    MAP_remove_val(LoadRequestToPlayerID, _:requestId);

    if (status == HTTP_STATUS_OK) {
        GetStatusUserService(playerid, node);
    }
}

public OnCheckUserPasswordResponse(Request:requestId, E_HTTP_STATUS:status, Node:node) {
    new playerid = MAP_get_val_val(LoadRequestToPlayerID, _:requestId);
    MAP_remove_val(LoadRequestToPlayerID, _:requestId);

    if (status == HTTP_STATUS_OK) {
        StatusUserCheckPasswordService(playerid, node);
    }
}


public OnLoadUserDataResponse(Request:requestId, E_HTTP_STATUS:status, Node:node) {
    new playerid = MAP_get_val_val(LoadRequestToPlayerID, _:requestId);
    MAP_remove_val(LoadRequestToPlayerID, _:requestId);


    if (status == HTTP_STATUS_OK) {
        LoadDataUserService(playerid, node);
    }
}

public OnSaveUserDataResponse(Request:requestId, E_HTTP_STATUS:status, Node:node) {
    new playerid = MAP_get_val_val(LoadRequestToPlayerID, _:requestId);
    MAP_remove_val(LoadRequestToPlayerID, _:requestId);


    if (status == HTTP_STATUS_OK) {
        printf("Save Data playerid:%d", playerid);
    }
}