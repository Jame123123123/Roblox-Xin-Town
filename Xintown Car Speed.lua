local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")

-- 1. เตรียมข้อมูล Config
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
    ["MaxRPM"] = 650,
    ["vehicleVibrateSpeed"] = 660,
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

-- 2. ฟังก์ชันหลักสำหรับอัปเดต
local function updateVehicleConfig()
    -- ใช้ pcall เพื่อป้องกัน Script หยุดทำงานหากหา Instance ไม่เจอ
    local success, err = pcall(function()
        -- แนะนำให้ใช้ชื่อ LocalPlayer แทนการ Hardcode ชื่อ
        local userVehicles = workspace:WaitForChild("system"):WaitForChild("UserVehicles")
        local playerVehicleFolder = userVehicles:FindFirstChild(LocalPlayer.Name) 
            or userVehicles:FindFirstChild("MCNDBV") -- Fallback กรณีหาชื่อไม่เจอ
        
        if playerVehicleFolder then
            local configInfo = playerVehicleFolder:WaitForChild("configInfo")
            
            -- ตรวจสอบว่าเป็น StringValue หรือไม่
            if configInfo:IsA("StringValue") then
                configInfo.Value = HttpService:JSONEncode(vehicleConfig)
                print("✅ [Success]: Config updated for " .. playerVehicleFolder.Name)
            else
                error("configInfo is not a StringValue")
            end
        else
            error("Vehicle folder for player not found")
        end
    end)

    if not success then
        warn("⚠️ [Error]: " .. err)
    end
end

-- เรียกใช้งาน
updateVehicleConfig()
