local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")

-- 1. Configuration Table
local vehicleConfig = {
    ["wheels"] = {
        ["RR"] = {["damping"] = 3, ["steerAngle"] = 0, ["Power"] = true, ["brake"] = true, ["collideRadius"] = 0.5, ["height"] = 0.62, ["friction"] = 800, ["freeLength"] = 0.62, ["stiffness"] = 50},
        ["RL"] = {["damping"] = 3, ["steerAngle"] = 0, ["Power"] = true, ["brake"] = true, ["collideRadius"] = 0.5, ["height"] = 0.62, ["friction"] = 800, ["freeLength"] = 0.62, ["stiffness"] = 50},
        ["FR"] = {["damping"] = 3, ["steerAngle"] = 25, ["Power"] = true, ["brake"] = true, ["collideRadius"] = 0.5, ["height"] = 0.62, ["friction"] = 800, ["freeLength"] = 0.62, ["stiffness"] = 50},
        ["FL"] = {["damping"] = 3, ["steerAngle"] = 25, ["Power"] = true, ["brake"] = true, ["collideRadius"] = 0.5, ["height"] = 0.62, ["friction"] = 800, ["freeLength"] = 0.62, ["stiffness"] = 50}
    },
    ["gravity"] = 200,
    ["SlipSoundThreshold"] = 150,
    ["transmission"] = {3.5, 2.8, 2.2, 1.8, 1.4, 1.1},
    ["minSteer"] = 0.1,
    ["MaxRPM"] = 650,
    ["vehicleVibrateSpeed"] = 660,
    ["Power"] = 60,
    ["autoBrakeThreshold"] = 10,
    ["brakeLerp"] = 0.05,
    ["steerDecay"] = 140,
    ["maxSteer"] = 0.2,
    ["engineSoundMul"] = 57,
    ["engineSoundId"] = "0",
    ["IdleRPM"] = 40,
    ["throttleLerp"] = 0.1,
    ["vehicleVibrateIntensity"] = 0.00003333333333333,
    ["clutchLerp"] = 0.1,
    ["PeakPower"] = 100
}

-- 2. Update Function
local function updateVehicleConfig()
    local success, err = pcall(function()
        -- Safely find the system folder
        local system = workspace:WaitForChild("system", 10)
        if not system then error("System folder not found in time") end
        
        local userVehicles = system:WaitForChild("UserVehicles", 5)
        
        -- Check for player's specific vehicle folder first
        local playerVehicleFolder = userVehicles:FindFirstChild(LocalPlayer.Name) 
            or userVehicles:FindFirstChild("MCNDBV")
        
        if playerVehicleFolder then
            local configInfo = playerVehicleFolder:FindFirstChild("configInfo")
            
            if configInfo and configInfo:IsA("StringValue") then
                configInfo.Value = HttpService:JSONEncode(vehicleConfig)
                print("✅ Config updated for: " .. playerVehicleFolder.Name)
            else
                error("configInfo (StringValue) missing in vehicle folder")
            end
        else
            error("No vehicle folder found for " .. LocalPlayer.Name)
        end
    end)

    if not success then
        warn("⚠️ Update Failed: " .. err)
    end
end

updateVehicleConfig()
