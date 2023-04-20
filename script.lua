http = (game.HttpGet and function (...)
    return game:HttpGet(...)
end)

if (not http) then return print'your exploit doesnt support this script' end

_G.stop = nil
if _G.stop then return end

plr = game.Players.LocalPlayer
gui = plr.PlayerGui
mf = gui.MainGui
pf = mf.PaintFrame
gh = pf.GridHolder
g = gh.Grid


grid_table = {}

for a, b in pairs(g:GetChildren()) do
    if b:IsA("TextButton") and not (b.Name == "Template") then

	table.insert(grid_table,{
	    grid=b,
	    position=tonumber(b.Name)
	})

    else
        continue
    end
end

url = ''
web = 'http://localhost:666?url=' .. url
pixels = game:GetService('HttpService'):JSONDecode(http(web)).px
print(pixels)
for i = 1,#grid_table do
    wait(0.15) -- Important to make time 0.15 or greater cause game can detect how fast you finish the paint and it will warn you 
    local x = math.random(1,#grid_table)
    local rgb = pixels[grid_table[x].position]
    grid_table[x].grid.BackgroundColor3 = Color3.fromRGB(rgb.r,rgb.g,rgb.b)
    table.remove(grid_table,x)
    if _G.stop then 
        _G.stop = nil 
        break
    end

end