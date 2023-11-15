#include <YSI_Coding\y_hooks>
#include "api/api_player_endpoint.pwn"

new Map:LoadRequestToPlayerID;


CheckIfUserExistsRequest(playerid) {
    new name[MAX_PLAYER_NAME];
    new requestWithParam[128] = "checkIfUserExists?username=";

    GetPlayerName(playerid, name, MAX_PLAYER_NAME);
    strcat(requestWithParam, name);
    format(PlayerInfo[playerid][username], 128, name);

    new Request:requestId = RequestJSON(
                authClient,
                requestWithParam,
                HTTP_METHOD_GET,
                "OnCheckIfUserExistsResponse",
                .headers = RequestHeaders()
            );
    MAP_insert_val_val(LoadRequestToPlayerID, _:requestId, playerid);
}

OnCreateUserRequest(playerid) {
    new Request:requestId = RequestJSON(
                authClient,
                "signUpUser",
                HTTP_METHOD_POST,
                "OnCreateUserResponse",
                JsonObject(
                    "username", JsonString(PlayerInfo[playerid][username]),
                    "password", JsonString(PlayerInfo[playerid][password])
                )
            );
    MAP_insert_val_val(LoadRequestToPlayerID, _:requestId, playerid);
}

OnCheckUserPasswordRequest(playerid) {
    new Request:requestId = RequestJSON(
                authClient,
                "checkUserPassword",
                HTTP_METHOD_POST,
                "OnCheckUserPasswordResponse",
                JsonObject(
                    "username", JsonString(PlayerInfo[playerid][username]),
                    "password", JsonString(PlayerInfo[playerid][password])
                )
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
