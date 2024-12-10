#include "game/game_logic.h"
#include "renderer/vulkan_renderer.h"

#include <SDL.h>
#include <vulkan/vulkan.h>

int main(int argc, char* argv[]) {
    // Initialize SDL
    if (SDL_Init(SDL_INIT_VIDEO) < 0) {
        // Handle initialization error
        return -1;
    }

    VulkanRenderer renderer;
    GameLogic game;

    // Game loop
    bool running = true;
    while (running) {
        SDL_Event event;
        while (SDL_PollEvent(&event)) {
            if (event.type == SDL_QUIT) {
                running = false;
            }
        }

        game.update();
        renderer.render();
    }

    // Cleanup
    SDL_Quit();
    return 0;
}