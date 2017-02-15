local device = require "framework.basic.Device"
local Utils = require 'framework.helper.Utils'

local Localize = {}
local strings = {}

local cfgpath = device.writablePath.."main/Localize"

function Localize.loadStrings(filename)
	assert(filename ~= nil, "language filename can not be nil!")
	strings = CCDictionary:createWithContentsOfFile(filename);
	strings:retain()
end

function Localize.getLanguage(key, default)
    if not default then default = key end
    if not strings then return default end

    local l = strings:valueForKey(key)
    if not l then return default end
    return l:getCString()
end

function Localize.filename(filenameOrigin)
    local fi = io.pathinfo(filenameOrigin)
    return fi.dirname .. fi.basename .. "_" .. device.language .. fi.extname

    -- return filenameOrigin
end

function Localize.setUserLanguage( lang )    
    local cfg = Utils.readTableFromFile(cfgpath,true) or {}
    cfg['lang'] = lang or cfg['lang']
    Utils.writeTableToFile(cfg,cfgpath,true)
end

function Localize.getUserLanguage( default )
    local cfg  = Utils.readTableFromFile(cfgpath,true) or {}
    return cfg['lang'] or default
end

return require 'framework.basic.MetaHelper'.createShell(Localize)
