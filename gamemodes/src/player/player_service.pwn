SaveUserService(playerid) {
    new Node:user = JsonObject(
                                          "id", JsonInt(PlayerInfo[playerid][id]),
                                          "username", JsonString(PlayerInfo[playerid][username]),
                                          "password", JsonString(PlayerInfo[playerid][password]),
                                          "email", JsonString(PlayerInfo[playerid][email]),
                                          "money", JsonInt(PlayerInfo[playerid][money]),
                                          "donate", JsonInt(PlayerInfo[playerid][donate])
                                      );
    OnSaveUserDataRequest(playerid, user);
}

LoadUserService(playerid) {
    GetPlayerName(playerid, PlayerInfo[playerid][username], MAX_PLAYER_NAME);
    CheckIfUserExistsRequest(playerid);
}

CreateUserService(playerid) {
    new Node:user = JsonObject(
                                          "username", JsonString(PlayerInfo[playerid][username]),
                                          "password", JsonString(PlayerInfo[playerid][password])
                                      );
    OnCreateUserRequest(playerid, user);
}

LoadDataUserService(playerid, Node:user) {
    JsonGetInt(user, "id", PlayerInfo[playerid][id]); 
    JsonGetString(user, "username", PlayerInfo[playerid][username]); 
    JsonGetString(user, "password", PlayerInfo[playerid][password]);
    JsonGetString(user, "email", PlayerInfo[playerid][email]);
    JsonGetInt(user, "donate", PlayerInfo[playerid][donate]);
    SpawnPlayer(playerid);
}

CheckUserPasswordService(playerid, const inputpassword[]) {
    new Node:user = JsonObject(
                                          "username", JsonString(PlayerInfo[playerid][username]),
                                          "password", JsonString(inputpassword)
                                      );
    OnCheckUserPasswordRequest(playerid, user);
}

StatusUserCheckPasswordService(playerid, Node:status) {
    new bool:passwordCorrect;
    JsonGetBool(status, "passwordCorrect", passwordCorrect);

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

GetStatusUserService(playerid, Node:status) {
    new bool:exists;
    JsonGetBool(status, "exists", exists);
    if (exists) {
        OnSignInUser(playerid);
    } else {
        OnSignUpUser(playerid);
    }
}