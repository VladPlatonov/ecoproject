#include <YSI_Coding\y_hooks>

new RequestsClient:authClient;
new authEndpoint[128] = "http://localhost:8080/api/v1/users";

hook OnGameModeInit() {
    authClient = RequestsClient(authEndpoint);
}