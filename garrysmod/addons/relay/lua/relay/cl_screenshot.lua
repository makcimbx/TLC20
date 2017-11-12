local function createFont(name, size, weight)
    surface.CreateFont(name, {
        font = "Roboto",
        size = size,
        weight = weight,
        antialias = true,
        extended = true,
    })
end
createFont("Screenshot_Signature", 32, 400)

local picFormat = "jpeg"
local function createCache(quality)
    draw.DrawText("Player " .. LocalPlayer():Name() .. " - " .. LocalPlayer():SteamID(), "Screenshot_Signature", 20, 20, color_white, TEXT_ALIGN_LEFT)
    cache = render.Capture({
        format = picFormat,
        quality = quality,
		h = ScrH(),
        w = ScrW(),
        x = 0,
        y = 0
    })
    cache = util.Base64Encode(cache)
end

local cache = nil
local latestQuality = 70
local function createCacheMain(quality)
    hook.Add("HUDPaint", "Screenshot_Signature", function()
        createCache(quality)
        hook.Remove("HUDPaint", "Screenshot_Signature")
    end)
end

local function createCacheBackup(quality)
    cache = render.Capture({
        format = picFormat,
        quality = quality,
        h = ScrH(),
        w = ScrW(),
        x = 0,
        y = 0
    })
    cache = util.Base64Encode(cache)
end

local function sizeTests(origData)
    local origDataSize = #origData
    local compressed = util.Compress(origData)
    local compressedSize = #compressed

    print("FILE COMPRESSION TESTS")
    print("Original: " .. origDataSize)
    print("Compressed: " .. compressedSize)
    print("Original - compressed = " .. (origDataSize - compressedSize))
    print("Compression is " .. 100 - math.Round(compressedSize / origDataSize * 100) .. "% more effective.")
end

concommand.Add("quality_test", function()
    for I = 0, 100, 10 do
        print("TESTING QUALITY: " .. I)
        createCacheBackup(I)
        sizeTests(cache)
        cache = nil
    end
end)

local function uploadPic(url, key)
    if not cache then createCacheBackup(latestQuality or 70) timer.Simple(0.01, function() uploadPic(url, key) end) return end
    --cache = util.Compress(cache)
    local start = SysTime()
    local request = {
        method = "post",
        url = url,
        parameters = {["key"] = key, ["picdata"] = cache},
        headers = {},
        failed = function() end,
        success = function(code, body, headers)
            --print("It took " .. (SysTime() - start) .. " seconds to take screenshot.")
            body = util.JSONToTable(body)
            if body.status == "success" and body.data.code == "success" then
                net.Start("Screenshot_Upload")
                net.SendToServer()
            end
        end
    }
    HTTP(request)
    cache = nil
end

net.Receive("Screenshot_Cache", function(len)
    local quality = net.ReadInt(16)
    latestQuality = quality
    createCacheMain(quality)
end)

net.Receive("Screenshot_Upload", function(len)
    uploadPic(net.ReadString(), net.ReadString())
end)