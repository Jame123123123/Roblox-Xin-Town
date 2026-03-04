local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")

-- 1. Vehicle Configuration Data
local vehicleConfig = {
    ["wheels"] = {
        ["RR"] = {["damping"] = 3, ["steerAngle"] = 0, ["Power"] = true, ["brake"] = true, ["collideRadius"] = 0.5, ["height"] = 0.62, ["friction"] = 800, ["freeLength"] = 0.62, ["stiffness"] = 50},
        ["RL"] = {["damping"] = 3, ["steerAngle"] = 0, ["Power"] = true, ["brake"] = true, ["collideRadius"] = 0.5, ["height"] = 0.62, ["friction"] = 800, ["freeLength"] = 0.62, ["stiffness"] = 50},
        ["FR"] = {["damping"] = 3, ["steerAngle"] = 25, ["Power"] = true, ["brake"] = true, ["collideRadius"] = 0.5, ["height"] = 0.62, ["friction"] = 800, ["freeLength"] = 0.62, ["stiffness"] = 50},
        ["FL"] = {["damping"] = 3, ["steerAngle"] = 25, ["Power"] = true, ["brake"] = true, ["collideRadius"] = 0.5, ["height"] = 0.62, ["friction"] = 800, ["freeLength"] = 0.62, ["stiffness"] = 50}
    },
    ["gravity"] = 100,
    ["SlipSoundThreshold"] = 150,
    ["transmission"] = {3.5, 2.8, 2.2, 1.8, 1.4, 1.1},
    ["minSteer"] = 0.1,
    ["MaxRPM"] = 600,
    ["vehicleVibrateSpeed"] = 600,
    ["Power"] = 60,
    ["autoBrakeThreshold"] = 10,
    ["brakeLerp"] = 0.05,
    ["steerDecay"] = 140,
    ["maxSteer"] = 0.2,
    ["engineSoundMul"] = 57,
    ["engineSoundId"] = "5089922566",
    ["IdleRPM"] = 40,
    ["throttleLerp"] = 0.1,
    ["vehicleVibrateIntensity"] = 0.00003333333333333,
    ["clutchLerp"] = 0.1,
    ["PeakPower"] = 120
}

-- 2. Reference the Object safely
-- Added checks to ensure we don't hang forever if the path is wrong
local system = workspace:WaitForChild("system", 5)
if system then
    local userVehicles = system:WaitForChild("UserVehicles", 5)
    local specificVehicle = userVehicles and userVehicles:WaitForChild(NameRoblox, 5)
    local targetPath = specificVehicle and specificVehicle:WaitForChild("configInfo", 5)

    if targetPath and targetPath:IsA("StringValue") then
        -- 3. Encode and Update
        targetPath.Value = HttpService:JSONEncode(vehicleConfig)
        print("✅ Updated Config for " .. NameRoblox .. " successfully!")
    else
        warn("❌ Could not find 'configInfo' or it is not a StringValue.")
    end
else
    warn("❌ System folder not found in Workspace.")
end