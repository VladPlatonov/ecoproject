cmd:givedonate(playerid, params[]) {
    if (sscanf(params, "dd", params[0], params[1])) {
        return SendClientMessage(playerid, COLOR_INFO, "/givedonate [id player] [count]");
    }

    new recipientId = params[0], count = params[1];
    PlayerInfo[recipientId][donate] += count;
    SaveUserService(recipientId);
    return 1;
}
