require 'common'

local client = clientServer.client

client.enabled = true
client.start('127.0.0.1:22122')