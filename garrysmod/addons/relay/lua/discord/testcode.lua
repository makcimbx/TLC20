PrintKeys = PrintKeys or function(tbl)
    for _, __ in pairs(tbl) do
        print(tostring(_) .. " -> " .. type(__))
    end
end
if _G.Bot then _G.Bot:Disconnect() end
DISCORD_DEBUG = true
local BotToken = "MjY1MTU1MTQ0NzQ2Nzk1MDA4.C3UN9w.Ab1Qs_xqXZkpThdAFoFRw1F446k"
_G.Bot = OOP:New("Bot")

Bot:on("ready", function()
    Bot:SetGame("hello from glua")
end)

Bot:on("message", function(message)
    if message.author.id == Bot.id then return end
    if not string.StartWith(message.content, Bot:Mention()) then return end
    local content = string.sub(message.content, string.len(Bot:Mention()) + 2, string.len(message.content))
    local args = string.Explode(" ", content)
    if args[1] == "ping" then
        local start = SysTime()
        message:GetChannel():SendMessage("Pong!", function(msg)
            msg:Edit("Pong! Took " .. math.Round(SysTime() - start, 2) * 100 .. "ms!")
        end)
    elseif args[1] == "embedtest" then
        local embed = OOP:New("RichEmbed")
        :SetTitle("Test")
        :SetDescription("wew lad")
        :SetURL("https://google.com")
        :SetColor(Color(255, 255, 0))
        :SetAuthor("Trixter the hacker", "http://s.trixter.xyz/dI0.png", "http://s.trixter.xyz/dI0.png")
        --:SetTimestamp()
        :SetThumbnail("http://s.trixter.xyz/dI0.png")
        :SetImage("http://s.trixter.xyz/dI0.png")
        :SetFooter("gas gas gas", "http://s.trixter.xyz/dI0.png")
        message:GetChannel():SendEmbed(embed)
    elseif args[1] == "webhooktest" then
        message:GetChannel():GetWebhooks(function(webhooks)
            if #webhooks < 1 then
                message:GetChannel():CreateWebhook("test", util.Base64Encode(file.Read("webhook.png", "DATA")), function(webhook)
                    if not webhook then print("-> Failed") return end
                    print("-> Created webhook")
                    webhook:SendMessage("wew", "alex", "http://s.trixter.xyz/dI0.png", function(message)
                        print("-> Send message")                    
                    end)
                end)
            else
                local webhook = webhooks[1]
                webhook:Edit("test2", util.Base64Encode(file.Read("webhook2.png", "DATA")), function(webhook)
                    print("-> Edited webhook")
                    webhook:SendMessage("wew", "alex", "http://s.trixter.xyz/dI0.png", function(message)
                        print("-> Send message")                    
                    end)
                end)
            end
        end)
    end
end)

--Bot:Login(BotToken)