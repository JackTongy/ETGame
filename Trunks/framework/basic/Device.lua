local metaHelper = require 'framework.basic.MetaHelper'

local device = {}

device.platform    = "unknown"
device.model       = "unknown"

local sharedApplication = CCApplication:sharedApplication()
local target = sharedApplication:getTargetPlatform()
if target == kTargetWindows then
    device.platform = "windows"
elseif target == kTargetMacOS then
    device.platform = "mac"
elseif target == kTargetAndroid then
    device.platform = "android"
elseif target == kTargetIphone or target == kTargetIpad then
    device.platform = "ios"
    if target == kTargetIphone then
        device.model = "iphone"
    else
        device.model = "ipad"
    end
elseif SystemHelper:getPlatFormID() == 13 then
    device.platform = "Windows Phone"
    device.model = "WP8"
end

local language_ = sharedApplication:getCurrentLanguage()
if language_ == kLanguageChinese then
    language_ = "cn"
elseif language_ == kLanguageChinese_tw then
    language_ = "zh_Hant"
elseif language_ == kLanguageFrench then
    language_ = "fr"
elseif language_ == kLanguageItalian then
    language_ = "it"
elseif language_ == kLanguageGerman then
    language_ = "gr"
elseif language_ == kLanguageSpanish then
    language_ = "sp"
elseif language_ == kLanguageRussian then
    language_ = "ru"
elseif language_ == kLanguagePortuguese then
    language_ = "pt"
elseif language_ == kLanguageSpanish then
    language_ = "es"
else
    language_ = "en"
end

device.language = language_
device.writablePath = CCFileUtils:sharedFileUtils():getWritablePath()
device.bundlePath = FileHelper:getBundlePath()

return metaHelper.createShell( device )
