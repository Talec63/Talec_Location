--[[local Variable = {
    {name = 'Pain', price = 6},
    {name = 'Eau', price = 5}
}--]]

print('^2Le script est start')

-- fonction du script

function ShowHelpNotification(msg, thisFrame)
	AddTextEntry('HelpNotification', msg)--ADEMO
	DisplayHelpTextThisFrame('HelpNotification', false)
end

function spawnCar(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(50)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, -982.59, -2709.3, 13.84, 349.28, GetEntityHeading(PlayerPedId()), true, false)

    
    SetEntityAsNoLongerNeeded(vehicle)
    SetModelAsNoLongerNeeded(vehicleName)
    
end

config = {
	shops = {
		{pos = vector3(-1016.48, -2696.34, 13.98)}
    }
}


Citizen.CreateThread(function()
    while true do
        local pPed = GetPlayerPed(-1)
        local pCoords = GetEntityCoords(pPed)
		local shops = false
		local dst = GetDistanceBetweenCoords(pCoords, true)
        for k,v in pairs(config.shops) do
			if #(pCoords - v.pos) < 1.5 then
				
                shops = true
                ShowHelpNotification("Appuyez sur ~INPUT_PICKUP~ pour commencer à acheter vos articles")
				if IsControlJustReleased(0, 38) then
					OpenMenuTuto()
				end
            end
        end

        if shops then
            Wait(1)
        else
            Wait(2000)
        	end
		end
end)

function OpenMenuTuto()
    local tuto = RMenu.Add('tuto', 'main', RageUI.CreateMenu("Service de location", "~p~Louer un véhicule"), true)
    RageUI.Visible(tuto, not RageUI.Visible(tuto))

    tuto:SetRectangleBanner(0, 0, 0, 255)

    while tuto do
        Citizen.Wait(5)
        RageUI.IsVisible(tuto, function()
            --for k,v in pairs(Variable) do
                local source = source
                --Color = {BackgroundColor = RageUI.ItemsColour.Green}
                RageUI.Item.Button('Faggio', nil, {RightLabel = '~g~100$'}, true , {
                    onSelected = function()
                        TriggerEvent("nMenuNotif:showNotification", "Votre faggio a bien ~g~ spawn")
                        TriggerEvent('GTA:RetirerArgentPropre', source, 15)
                        TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
                        spawnCar('faggio')
                    end
                })
                RageUI.Item.Button('Blista', nil, { RightLabel = '~g~300$'}, true, {
                    onSelected = function()
                        print('eau')
                    end
                })
            --end
        end)
        if not RageUI.Visible(tuto) then
            tuto = RMenu:DeleteType("tuto", true)
        end
    end
end
Config = {}

Config.pPos     = {
    { "s_m_y_devinsec_01", vector4(-1015.93, -2696.15, 12.98, 146.98)},

}
Citizen.CreateThread(function()
    for _,k in pairs(Config.pPos) do

        local hash = GetHashKey(k[1])
        while not HasModelLoaded(hash) do
        RequestModel(hash)
        Wait(20)
        end
        pPed = CreatePed("PED_TYPE_CIVFEMALE", k[1], k[2], true, true)
        SetBlockingOfNonTemporaryEvents(pPed, true)
        FreezeEntityPosition(pPed, true)
        SetEntityInvincible(pPed, true)
    end
end)
