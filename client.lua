require 'common'

local client = clientServer.client

client.enabled = true
client.start('127.0.0.1:22122')

function client.connect()
    print('client: connected to server')
end

function client.disconnect()
    print('client: disconnected from server')
end