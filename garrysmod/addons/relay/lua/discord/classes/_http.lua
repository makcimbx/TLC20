function string.IndexOf(needle, haystack)
	for i = 1, #haystack do
		if (haystack[i] == needle) then
			return i
		end
	end
	
	return -1
end

local HTTP = {}

function HTTP:Constructor(_client)
    self._client = _client

	self.ratelimit = {}
end

-- Thanks Datamats
-- Source: https://github.com/Datamats/gm-discordlib/blob/7f7cc8e46d679978d8f5be73205eee54f323a791/lua/discordlib/libs/http.lua
function HTTP:HTTPRequest(url, method, headertbl, postdatatbl, patchdata, callback)
	local port = 80

	if (string.StartWith(url, "http://")) then
		url = string.Right(url, #url - 7)
	elseif (string.StartWith(url, "https://")) then
		url = string.Right(url, #url - 8)
		port = 443;
	end

	local host = ""
	local path = ""
	local postdata = ""
	local bigbooty = ""
	
	local headers = nil
	local chunkedmode = false
	local chunkedmodedata = false
	
	local pathindex = string.IndexOf("/", url)
	if (pathindex > -1) then
		host = string.sub(url, 1, pathindex - 1)
		path = string.sub(url, pathindex)
	else
		host = url
	end
	
	if (#path == 0) then path = "/" end
	
	if (postdatatbl and type(postdatatbl) == "table") then
		for k, v in pairs(postdatatbl) do
			postdata = postdata .. k .. "=" .. v .. "&"
		end
		
		if (#postdata > 0) then
			postdata = string.Left(postdata, #postdata - 1)
		end
	end

	local pClient = BromSock();
	local pPacket = BromPacket();
	
	pClient:SetCallbackConnect( function( _, bConnected, szIP, iPort )
		if (not bConnected) then
			callback(nil, nil)
			return;
		end
		
		if (port == 443) then
			pClient:StartSSLClient()
		end
		
		if method:lower() == "post_json" then
			pPacket:WriteLine("POST " .. path .. " HTTP/1.1");
		else
			pPacket:WriteLine(method .. " " .. path .. " HTTP/1.1");
		end
		pPacket:WriteLine("Host: " .. host);

		for k, v in pairs(headertbl) do
			
			pPacket:WriteLine(k..": "..v)
		end

		if (method:lower() == "post") then
			pPacket:WriteLine("Content-Type: application/json");
			pPacket:WriteLine("Content-Length: " .. #postdata);
		elseif (method:lower() == "post_json") then
			pPacket:WriteLine("Content-Type: application/json");
			pPacket:WriteLine("Content-Length: " .. #postdatatbl);
		elseif (method:lower() == "patch") then
			pPacket:WriteLine("Content-Type: application/json");
			pPacket:WriteLine("Content-Length: " .. #patchdata);
		else
			pPacket:WriteLine("Content-Type: application/x-www-form-urlencoded");
			pPacket:WriteLine("Content-Length: 0");
		end
		
		pPacket:WriteLine("");
		
		if (method:lower() == "post") then
			pPacket:WriteLine(postdata)
		elseif(method:lower() == "post_json") then
			pPacket:WriteLine(postdatatbl)
		elseif (method:lower() == "patch") then
			pPacket:WriteLine(patchdata)
		end

		pClient:SetMaxReceiveSize(1024 * 1024 * 100); -- some webpages like to embed images, so this can get quite big. Lets allow it to allocate up to 100MB
		pClient:Send( pPacket, true );
		pClient:ReceiveUntil( "\r\n\r\n" );
	end );
	
	pClient:SetCallbackReceive( function( _, incommingpacket )
		local szMessage = incommingpacket:ReadStringAll():Trim()
		incommingpacket = nil
		
		if (not headers) then
			local headers_tmp = string.Explode("\r\n", szMessage)
			headers = {}
			
			local statusrow = headers_tmp[1]
			table.remove(headers_tmp, 1)
			
			headers["status"] = statusrow:sub(10)
			for k, v in ipairs(headers_tmp) do
				local tmp = string.Explode(": ", v)
				headers[tmp[1]:lower()] = tmp[2]
			end
			
			if (headers["content-length"]) then
				pClient:Receive(tonumber(headers["content-length"]));
			elseif (headers["transfer-encoding"] and headers["transfer-encoding"] == "chunked") then
				chunkedmode = true
				pClient:ReceiveUntil( "\r\n" );
			else
				-- This is why we can't have nice things.
				pClient:Receive(99999);
			end
		elseif (chunkedmode) then
			if (chunkedmodedata) then
				bigbooty = bigbooty .. szMessage
				chunkedmodedata = false
				pClient:ReceiveUntil( "\r\n" );
			else
				local len = tonumber(szMessage, 16)
				if (len == 0) then
					callback(headers, bigbooty)
					pClient:Close()
					pClient = nil
					pPacket = nil
					return
				end
				
				chunkedmodedata = true
				pClient:Receive(len + 2) -- + 2 for \r\n, stilly chunked mode
			end
		else
			callback(headers, szMessage)
			pClient:Close()
			pClient = nil
			pPacket = nil
		end
	end)
	
	pClient:Connect(host, port);
end

function HTTP:SetRateLimit(id, remaining, reset)
	self.ratelimit[id] = {
		remaining = remaining,
		reset = reset,
	}
end

function HTTP:Request(path, method, data, callback, ratelimitable)
    path = string.StartWith(path, "http") and path or "https://discordapp.com/api/v6" .. path

	if ratelimitable and self.ratelimit[ratelimitable] then
		local ratelimit = self.ratelimit[ratelimitable]

		if os.time() > ratelimit.reset then
			ratelimit.remaining = 5
		end

		if os.time() < ratelimit.reset and ratelimit.remaining < 1 then
			timer.Simple(0.2, function()
				self:Request(path, method, data, callback, ratelimitable)
			end)
			return
		end
	end

    self:HTTPRequest(path, method, {
        ["Authorization"] = "Bot " .. self._client.Token,
        ["Content-Type"] = "application/json",
        ["User-Agent"] = "DiscordBot (trixter.xyz, 1.0)",
    }, method ~= "PATCH" and data or nil, method == "PATCH" and data or nil, function(headers, data)
        if not headers then
            print("-> Request Failed.")
            return
        end

		if headers["x-ratelimit-limit"] then
			self:SetRateLimit(ratelimitable, tonumber(headers["x-ratelimit-remaining"]), tonumber(headers["x-ratelimit-reset"]))
		end

		if util.JSONToTable(data).code then 
			if Relay then Relay:Log("Request Failed. Error: " .. util.JSONToTable(data).message) else print("-> Request Failed. Error: " .. util.JSONToTable(data).message) end
			return
		end

        if callback then callback(data) end
    end)
end

function HTTP:SendMessage(id, data, callback)
    local callback2 = nil
    if callback then 
        callback2 = function(body)
            local message = OOP:New("Message", util.JSONToTable(body), self._client)
            callback(message)
        end
    end
    self:Request("/channels/" .. id .. "/messages", "POST_JSON", data, callback2, "SendMessage")
end

function HTTP:EditMessage(channelid, messageid, data, callback)
    local callback2 = nil
    if callback then
        callback2 = function(body)
            local message = OOP:New("Message", util.JSONToTable(body), self._client)
            callback(message)
        end
    end
    self:Request("/channels/" .. channelid .. "/messages/" .. messageid, "PATCH", data, callback2, "EditMessage")
end

function HTTP:DeleteMessage(channelid, messageid, callback)
    self:Request("/channels/" .. channelid .. "/messages/" .. messageid, "DELETE", nil, callback, "DeleteMessage")
end

function HTTP:GetWebhooks(channelid, callback)
	local callback2 = nil
	if callback then
		callback2 = function(body)
			body = util.JSONToTable(body)
			local webhooks = {}
			for _, data in pairs(body) do
				table.insert(webhooks, OOP:New("Webhook", data, self._client))
			end
			callback(webhooks)
		end
	end
	self:Request("/channels/" .. channelid .. "/webhooks", "GET", nil, callback2)
end

function HTTP:CreateWebhook(channelid, data, callback)
	local callback2 = nil
	if callback then
		callback2 = function(body)
			local webhook = OOP:New("Webhook", util.JSONToTable(body), self._client)
			callback(webhook)
		end
	end
	self:Request("/channels/" .. channelid .. "/webhooks", "POST_JSON", data, callback2)
end

function HTTP:EditWebhook(id, data, callback)
	local callback2 = nil
	if callback then
		callback2 = function(body)
			local webhook = OOP:New("Webhook", util.JSONToTable(body), self._client)
			callback(webhook)
		end
	end
	self:Request("/webhooks/" .. id, "PATCH", data, callback2)
end

function HTTP:SendWebhook(id, token, data, callback)
	local callback2 = nil
	if callback then
		callback2 = function(body)
			print(body)
			--local webhook = OOP:New("Webhook", util.JSONToTable(body), self._client)
			callback(body)
		end
	end
	self:Request("/webhooks/" .. id .. "/" .. token, "POST_JSON", data, callback2)
end

function HTTP:EditUser(data, callback)
	local callback2 = nil
	if callback then
		callback2 = function(body)
			local user = OOP:New("User", util.JSONToTable(body))
			callback(user)
		end
	end
	self:Request("/users/@me", "PATCH", data, callback2, "EditUser")
end

OOP:Register("HTTP", HTTP)