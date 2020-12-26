RegisterServerEvent('GTA:RetirerArgentPropre') --> cette event sert uniquement a retirer votre argent propre par une valeur en parametre.
AddEventHandler('GTA:RetirerArgentPropre', function(source, value)
	local src = source
	Player:Find(src, function(data)
		if data then
			local getArgentPropre = data.argent_propre
			if getArgentPropre >= value then
				local newCash = data.argent_propre - value
				exports.ghmattimysql:execute("UPDATE gta_joueurs SET argent_propre=@newCash WHERE license = @license", {['license'] = tostring(data.license), ['newCash'] = tostring(newCash)}, function() end)
				TriggerClientEvent('GTA:AfficherArgentPropre', src, newCash)
				TriggerClientEvent('GTA:AjoutSonPayer', src)
			else
				TriggerClientEvent("nMenuNotif:showNotification", source, "Vous n'avez cette somme d'argent sur vous.")
			end
		end
	end)
end)