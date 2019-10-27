require 'common'

local server = clientServer.server

server.enabled = true
server.start('22122')

function server.connect(clientId)
    print('server: client ' .. clientId .. ' connected')
end

function server.disconnect(clientId)
    print('server: client ' .. clientId .. ' disconnected')
end