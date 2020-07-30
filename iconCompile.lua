-- Provide string concatenation via addition operator
getmetatable("").__add = function(a, b)
    return a .. b
end

local inputImage = "img\\appIcon.png"
local backgroundColor = "#ffffff"

local android7Command = "convert \"%s\" -background %s -resize %s -alpha remove \"%s\""
local android8Command = "convert \"%s\" -resize %s \"%s\""

local sizeTable = {
    --[[["36x36"] = "mipmap-ldpi",
    ["48x48"] = "mipmap-mdpi",
    ["72x72"] = "mipmap-hdpi",
    ["96x96"] = "mipmap-xhdpi",
    ["144x144"] = "mipmap-xxhdpi",
    ["192x192"] = "mipmap-xxxhdpi",]]
    -- Android 8 Sizes
    ["108x108"] = "mipmap-mdpi",
    ["162x162"] = "mipmap-hdpi",
    ["216x216"] = "mipmap-xhdpi",
    ["324x324"] = "mipmap-xxhdpi",
    ["432x432"] = "mipmap-xxxhdpi"
}

for size, path in pairs(sizeTable) do
    local fileName = "ic_launcher.png"
    local outputPath = "AndroidResources\\res\\" + path
    os.execute("mkdir " + outputPath)
    local output7 = outputPath + "\\" + fileName
    local output8 = outputPath + "\\" + fileName:gsub(".png", "_foreground.png")

    local android7Above = android7Command:format(inputImage, backgroundColor, size, output7)
    local android8Over = android8Command:format(inputImage, size, output8)
    print(android7Above)
    print(android8Over)
    os.execute(android7Above)
    os.execute(android8Over)
end

-- Create mini icon
os.execute(android7Command:format(inputImage, backgroundColor, "57x57", "icon.png"))
