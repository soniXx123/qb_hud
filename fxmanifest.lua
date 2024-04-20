fx_version 'adamant'
games { 'gta5' }
author 'twoface'
lua54 'yes'

shared_scripts {
    '@es_extended/imports.lua', -- If using es_extended
    'backend/config.lua'
}

client_scripts {
    'backend/client.lua',
    'backend/functions/*.lua',
    'backend/chat.json',
    'backend/config.lua'
}

server_scripts {
    'backend/server.lua',
    'backend/config.lua'
}

ui_page 'frontend/index.html'
files {
    'frontend/index.html',
    'frontend/*.*',
    'frontend/img/*.*',
    'frontend/css/*.*',
    'frontend/js/*.*',
}
dependency '/assetpacks'
