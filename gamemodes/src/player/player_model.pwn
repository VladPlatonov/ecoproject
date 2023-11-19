enum PlayerStruct {
    id,
    username[MAX_PLAYER_NAME],
    money,
    donate,
    password[128],
    email[128]
}

new PlayerInfo[MAX_PLAYERS][PlayerStruct];