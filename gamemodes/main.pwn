#include <open.mp>
#include <a_http>

#undef MAX_PLAYERS
#define MAX_PLAYERS (1000)
#define YSI_NO_HEAP_MALLOC
#define BCRYPT_COST 12
#define COLOR_INFO  (0xFFDD00FF)

#include <crashdetect>
#include <streamer>

#include <a_mysql>

// YSI
#include <YSI_Coding\y_va>
#include <YSI_Data\y_foreach>
#include <YSI_Data\y_iterate>
#include <YSI_Data\y_bit>
#include <YSI_Coding\y_timers>

// YSI

#include <Pawn.CMD>
#include <memory>
#include <sscanf2>
#include <indirection>
#include <strlib>
#include <easyDialog>
#include <modelsizes>
#include <physics>
#include <env>
#include <Pawn.Regex>
#include <map>
#include <requests>

/* ==============================[modules]============================== */
#include "src\core\core.pwn"
#include "src\core\global_variables.pwn"
#include "src\player\player_config.pwn"


main() {

}
cmd:hello(playerid) {
    print("hekko");
    return 1;
}

