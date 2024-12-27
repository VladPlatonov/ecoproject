#include <YSI_Coding\y_hooks>
#include "api/api_player_endpoint.pwn"

new Map:LoadRequestToPlayerID;


CheckIfUserExistsRequest(playerid) {
    new requestWithParam[128] = "checkIfUserExists?username=";
    strcat(requestWithParam, PlayerInfo[playerid][username]);
    
    new Request:requestId = RequestJSON(
                authClient,
                requestWithParam,
                HTTP_METHOD_GET,
                "OnCheckIfUserExistsResponse",
                .headers = RequestHeaders()
            );
    MAP_insert_val_val(LoadRequestToPlayerID, _:requestId, playerid);
}

OnCreateUserRequest(playerid, Node:user) {
    new Request:requestId = RequestJSON(
                authClient,
                "signUpUser",
                HTTP_METHOD_POST,
                "OnCreateUserResponse",
                user
            );
    MAP_insert_val_val(LoadRequestToPlayerID, _:requestId, playerid);
}

OnCheckUserPasswordRequest(playerid, Node:user) {
    new Request:requestId = RequestJSON(
                authClient,
                "checkUserPassword",
                HTTP_METHOD_POST,
                "OnCheckUserPasswordResponse",
                user
            );
    MAP_insert_val_val(LoadRequestToPlayerID, _:requestId, playerid);
}
OnLoadUserDataRequest(playerid) {
    new requestWithParam[128] = "getUserByUsername?username=";
    strcat(requestWithParam, PlayerInfo[playerid][username]);
    new Request:requestId = RequestJSON(
                authClient,
                requestWithParam,
                HTTP_METHOD_GET,
                "OnLoadUserDataResponse",
                .headers = RequestHeaders()
            );
    MAP_insert_val_val(LoadRequestToPlayerID, _:requestId, playerid);
}
OnSaveUserDataRequest(playerid, Node: user) {
    new requestWithParam[128] = "";
    new requestUserId;

    JsonGetInt(user, "id", requestUserId);
    format(requestWithParam, sizeof(requestWithParam), "%d/save", requestUserId);

    new Request:requestId = RequestJSON(
                authClient,
                requestWithParam,
                HTTP_METHOD_PUT,
                "OnSaveUserDataResponse",
                user
            );
    MAP_insert_val_val(LoadRequestToPlayerID, _:requestId, playerid);
}
