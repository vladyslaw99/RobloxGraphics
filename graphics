return function(presetName)
    local Lighting = game:GetService("Lighting")
    local TweenService = game:GetService("TweenService")
    
    local presets = {
        ["Ultra Quality"] = {
            ShadowSoftness = 0.1,
            Brightness = 3.0,
            FogDensity = 0.03,
            ColorCorrection = {0.2, 0.25, 0.15},
            BloomIntensity = 0.5,
            SunRaysIntensity = 0.05
        },
        ["Balanced"] = {
            ShadowSoftness = 0.25,
            Brightness = 2.2,
            FogDensity = 0.08,
            ColorCorrection = {0.1, 0.15, 0.05},
            BloomIntensity = 0.35,
            SunRaysIntensity = 0.03
        },
        ["Performance"] = {
            ShadowSoftness = 0.4,
            Brightness = 1.8,
            FogDensity = 0.12,
            ColorCorrection = {0.05, 0.1, 0},
            BloomIntensity = 0.2,
            SunRaysIntensity = 0.01
        }
    }
    
    local config = presets[presetName]
    
    -- Create effects if they don't exist
    if not Lighting:FindFirstChild("ColorCorrection") then
        Instance.new("ColorCorrectionEffect", Lighting)
    end
    
    if not Lighting:FindFirstChild("Bloom") then
        Instance.new("BloomEffect", Lighting)
    end
    
    if not Lighting:FindFirstChild("SunRays") then
        Instance.new("SunRaysEffect", Lighting)
    end
    
    -- Apply settings with tweening for smooth transition
    TweenService:Create(Lighting, TweenInfo.new(1.5), {
        ShadowSoftness = config.ShadowSoftness,
        Brightness = config.Brightness,
        FogDensity = config.FogDensity
    }):Play()
    
    TweenService:Create(Lighting.ColorCorrectionEffect, TweenInfo.new(1.5), {
        Contrast = config.ColorCorrection[1],
        Saturation = config.ColorCorrection[2],
        TintColor = Color3.new(config.ColorCorrection[3], config.ColorCorrection[3], config.ColorCorrection[3])
    }):Play()
    
    TweenService:Create(Lighting.Bloom, TweenInfo.new(1.5), {
        Intensity = config.BloomIntensity
    }):Play()
    
    TweenService:Create(Lighting.SunRays, TweenInfo.new(1.5), {
        Intensity = config.SunRaysIntensity
    }):Play()
end
