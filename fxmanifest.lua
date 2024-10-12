fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'fabzhii'
description 'F-MDT by fabzhii'
version '1.0.0'

shared_script '@es_extended/imports.lua'
shared_script '@ox_lib/init.lua'

ui_page 'html/index.html'
law_file('law.json')

files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
    'html/coloris/*.css',
    'html/coloris/*.js',
    'html/img/*.png',
    'html/sounds/*.ogg',
    'law.json',
}

server_scripts {
    'config.lua',
    "@mysql-async/lib/MySQL.lua",
    'server/*.lua',
}

client_scripts {
    'config.lua',
    'client/*.lua',
} 

dependencies {
	'ox_lib',
}