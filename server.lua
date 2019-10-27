require 'common'

local server = clientServer.server

server.enabled = true
server.start('22122')

local share = server.share
local homes = server.homes

function server.load()
    share.players = {}
end

function server.connect(clientId)
    print('server: client ' .. clientId .. ' connected')

    share.players[clientId] = {
        x = math.random(40, 800 - 40),
        y = math.random(40, 450 - 40),
    }
end

function server.disconnect(clientId)
    print('server: client ' .. clientId .. ' disconnected')
end

function server.receive(clientId, message, ...)
    if message == 'pressedKey' then
        local key = ...
        server.send('all', 'otherClientPressedKey', clientId, key)
    end
end