#include <YSI_Coding\y_hooks>
#include "player_model.pwn"

hook OnPlayerConnect(playerid) {
    LoadUserService(playerid);
    return 1;
}

OnSignUpUser(playerid) {
    new totalstring[1024] = "";
    format(totalstring, sizeof(totalstring), "Welcome to the server.\n Account %s is not registered.\n\
    To register, enter the password:", PlayerInfo[playerid][username]);
    Dialog_Show(playerid, SignUpDialog, DIALOG_STYLE_INPUT, "Registration", totalstring, "Next", "Cancel");
    return 1;
}

Dialog:SignUpDialog(playerid, response, listitem, inputtext[]) {
    if (response) {
        if (!strlen(inputtext) || strlen(inputtext) < 6 || strlen(inputtext) > 24) {
            new totalstring[1024] = "";
            format(totalstring, sizeof(totalstring), "Welcome to the server. Account %s is not registered.\n\
                To register, enter the password:\n\
                Error: Password length must be between 6 and 24 characters.", PlayerInfo[playerid][username]);
            Dialog_Show(playerid, SignUpDialog, DIALOG_STYLE_INPUT, "Registration", totalstring, "Next", "Cancel");

        }

        else {
            //after create on backend, return hashed password
            format(PlayerInfo[playerid][password], 128, inputtext);
            CreateUserService(playerid);
            SpawnPlayer(playerid);
        }
    }

    else {
        Kick(playerid);
    }
    return 1;
}


Dialog:SignInDialog(playerid, response, listitem, inputtext[]) {
    if (response) {
        CheckUserPasswordService(playerid, inputtext);
    }

    else {
        Kick(playerid);
    }
    return 1;
}

OnSignInUser(playerid) {
    new totalstring[1024] = "";
    format(totalstring, sizeof(totalstring), "Welcome to the server.\n Account %s is registered.\n\
    To Sign In, enter the password:", PlayerInfo[playerid][username]);
    Dialog_Show(playerid, SignInDialog, DIALOG_STYLE_INPUT, "Sign In", totalstring, "Next", "Cancel");
}


