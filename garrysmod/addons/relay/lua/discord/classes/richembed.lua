local ColorConverter = OOP:New("ColorConverter")
local RichEmbed = {}

function RichEmbed:Constructor()
    self.data = {}
end

function RichEmbed:SetTitle(title)
    title = string.sub(title, 0, 256)
    self.data.title = title
    return self
end

function RichEmbed:SetDescription(desc)
    desc = string.sub(desc, 0, 2048)
    self.data.description = desc
    return self
end

function RichEmbed:SetURL(url)
    self.data.url = url
    return self
end

function RichEmbed:SetColor(clr)
    self.data.color = ColorConverter:ToDecimal(clr)
    return self
end

function RichEmbed:SetAuthor(name, icon, url)
    self.data.author = {
        name = name,
        icon_url = icon,
        url = url,
    }
    return self
end

function RichEmbed:SetTimestamp(timestamp)
    timestamp = os.date("!%Y-%m-%dT%TZ", timestamp)
    self.data.timestamp = timestamp
    return self
end

function RichEmbed:AddField(name, value, inline)
    self.data.fields = self.data.fields or {}
    if #self.data.fields > 25 then return end
    name = string.sub(name, 0, 256)
    value = string.sub(value, 0, 1024)
    table.insert(self.data.fields, {
        name = name,
        value = value,
        inline = inline,
    })
    return self
end

function RichEmbed:SetThumbnail(url)
    self.data.thumbnail = {url = url}
    return self
end

function RichEmbed:SetImage(url)
    self.data.image = {url = url}
    return self
end

function RichEmbed:SetFooter(footer, icon)
    footer = string.sub(footer, 0, 2048)
    self.data.footer = {
        text = footer,
        icon_url = icon
    }
    return self
end

OOP:Register("RichEmbed", RichEmbed)