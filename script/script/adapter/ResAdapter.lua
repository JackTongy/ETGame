local ResAdapter = {}

local logoT ={
    -- ["com.rekoo.pokemonb"]='N_login_logo2.png', 
    -- ["com.rekoo.pikapika"]='N_login_logo1.png',
}

function ResAdapter.setLogoWithBundleId( node )
    local resid = nil
    if require "framework.basic.Device".platform == "ios" then
        local bundleid = GleeUtils.BundleValue and GleeUtils:BundleValue('CFBundleIdentifier')
        resid = bundleid and logoT[bundleid]
    else

    end
    
    return node and node:setResid(resid or 'N_login_logo.png')
end


return ResAdapter