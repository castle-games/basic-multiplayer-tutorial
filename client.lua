require 'common'

local client = clientServer.client

client.enabled = true
client.start('127.0.0.1:22122')

local share = client.share
local home = client.home

function client.connect()
    print('client: connected to server')
end

function client.disconnect()
    print('client: disconnected from server')
end

function client.receive(message, ...)
    if message == 'otherClientPressedKey' then
        local otherClientId, key = ...
        if otherClientId ~= client.id then
            print('client: other client ' .. otherClientId .. " pressed key '" .. key .. "'")
        end
    end
end

function client.draw()
    if client.connected then
        for clientId, player in pairs(share.players) do
            love.graphics.rectangle('fill', player.x - 20, player.y - 20, 40, 40)
        end
    else
        love.graphics.print('connecting...', 20, 20)
    end
end

function client.keypressed(key)
    if client.connected then
        client.send('pressedKey', key)
    end
end