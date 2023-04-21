function pullOwner(username)
    return game.Players:FindFirstChild(username)
end

return {
    kill = function(target)
        if not pullOwner() then return end
        pcall(function()
            game.Players.LocalPlayer.Character.Humanoid.Health = 0
        end)
    end,
    speak = function(target, params)
        if not pullOwner() then return end
        pcall(function()
            game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageReques:FireServer(table.concat(params,' '), 'All')
        end)
    end,
    bring = function(target)
        if not pullOwner() then return end
        pcall(function()
            local hrp = (pullOwner().Character:FindFirstChild('HumanoidRootPart') and pullOwner().Character:FindFirstChild('HumanoidRootPart')) or (pullOwner().Character:FindFirstChild('Torso') and pullOwner().Character:FindFirstChild('Torso'))
            if hrp then
                local hrp2 = (game.Players.LocalPlayer.Character.Character:FindFirstChild('HumanoidRootPart') and game.Players.LocalPlayer.Character.Character:FindFirstChild('HumanoidRootPart')) or (game.Players.LocalPlayer.Character.Character:FindFirstChild('Torso') and game.Players.LocalPlayer.Character.Character:FindFirstChild('Torso'))
                return   
            end
        end)
    end
}
