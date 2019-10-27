require 'common'

local client = clientServer.client

client.enabled = true
client.start('127.0.0.1:22122')

local share = client.share
local home = client.home

function client.connect()
    print('client: connected to server')

    local player = share.players[client.id]
    home.x, home.y = player.x, player.y
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
            local x, y = player.x, player.y
            if clientId == client.id then
                x, y = home.x, home.y
            end
            love.graphics.rectangle('fill', x - 20, y - 20, 40, 40)
        end
    else
        love.graphics.print('connecting...', 20, 20)
    end
end

local PLAYER_SPEED = 200

function client.update(dt)
    if client.connected then
        if love.keyboard.isDown('left') then
            home.x = home.x - PLAYER_SPEED * dt
        end
        if love.keyboard.isDown('right') then
            home.x = home.x + PLAYER_SPEED * dt
        end
        if love.keyboard.isDown('up') then
            home.y = home.y - PLAYER_SPEED * dt
        end
        if love.keyboard.isDown('down') then
            home.y = home.y + PLAYER_SPEED * dt
        end
    end
end

function client.keypressed(key)
    if client.connected then
        client.send('pressedKey', key)
    end
end