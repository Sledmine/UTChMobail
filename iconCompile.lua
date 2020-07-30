-- Provide string concatenation via addition operator
getmetatable("").__add = function(a, b)
    return a .. b
end

-- convert "$base" -resize 36x36!    "Icon-ldpi.png"

local inputImage = "img\\appIconForeground.png"
local magickCommand = "convert \"%s\" -resize %s! -filter triangle -unsharp 1x4 \"%s\""

-- Android output table
local androidTable = {
    ["36x36"] = "Icon-ldpi.png",
    ["48x48"] = "Icon-mdpi.png",
    ["72x72"] = "Icon-hdpi.png",
    ["96x96"] = "Icon-xhdpi.png",
    ["144x144"] = "Icon-xxhdpi.png",
    ["192x192"] = "Icon-xxxhdpi.png",
}

local solar2dTable = {
    ["48x48"] = "mipmap-mdpi",
    ["72x72"] = "mipmap-hdpi",
    ["96x96"] = "mipmap-xhdpi",
    ["144x144"] = "mipmap-xxhdpi",
    ["192x192"] = "mipmap-xxxhdpi",
}

for size, path in pairs(solar2dTable) do
    local inputImageBackground = inputImage:gsub("Foreground", "Background")

    local fileName = "ic_launcher.png"
    local outputPath = "AndroidResources\\res\\" + path + "\\" + fileName

    local foregroundCommand = magickCommand:format(inputImage, size, outputPath:gsub(fileName, "ic_launcher_foreground.png"))
    local backgroundCommand = magickCommand:format(inputImageBackground, size, outputPath:gsub(fileName, "ic_launcher_background.png"))
    os.execute(foregroundCommand)
    os.execute(backgroundCommand)
end

-- Create mini icon
os.execute(magickCommand:format(inputImage, "57x57", "icon.png"))