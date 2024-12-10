#ifndef VULKAN_RENDERER_H
#define VULKAN_RENDERER_H

#include <SDL2/SDL.h>
#include <SDL2/SDL_vulkan.h>
#include <optional>
#include <string>
#include <vector>
#include <vulkan/vulkan.h>

class VulkanRenderer {
public:
    VulkanRenderer();
    ~VulkanRenderer();

    void init(SDL_Window* window);
    void cleanup();
    void render();

private:
    // Vulkan handles
    VkInstance instance{VK_NULL_HANDLE};
    VkPhysicalDevice physicalDevice{VK_NULL_HANDLE};
    VkDevice device{VK_NULL_HANDLE};
    VkQueue graphicsQueue{VK_NULL_HANDLE};
    VkSurfaceKHR surface{VK_NULL_HANDLE};

    // Debug messenger
    VkDebugUtilsMessengerEXT debugMessenger{VK_NULL_HANDLE};

    // Window handle
    SDL_Window* window{nullptr};

    // Queue family indices
    struct QueueFamilyIndices {
        std::optional<uint32_t> graphicsFamily;
        std::optional<uint32_t> presentFamily;

        bool isComplete() const {
            return graphicsFamily.has_value() && presentFamily.has_value();
        }
    };

    // Initialization functions
    void createInstance();
    void setupDebugMessenger();
    void createSurface();
    void pickPhysicalDevice();
    void createLogicalDevice();

    // Helper functions
    bool checkValidationLayerSupport() const;
    std::vector<const char*> getRequiredExtensions() const;
    bool isDeviceSuitable(VkPhysicalDevice device) const;
    QueueFamilyIndices findQueueFamilies(VkPhysicalDevice device) const;

    // Debug functions
    static VKAPI_ATTR VkBool32 VKAPI_CALL
    debugCallback(VkDebugUtilsMessageSeverityFlagBitsEXT messageSeverity,
                  VkDebugUtilsMessageTypeFlagsEXT messageType,
                  const VkDebugUtilsMessengerCallbackDataEXT* pCallbackData,
                  void* pUserData);

    // Validation layers
    const std::vector<const char*> validationLayers = {"VK_LAYER_KHRONOS_validation"};

#ifdef NDEBUG
    const bool enableValidationLayers = false;
#else
    const bool enableValidationLayers = true;
#endif
};

#endif  // VULKAN_RENDERER_H