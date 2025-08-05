local function cacheAll()
	local rows = sql.Query("SELECT * FROM ctg_characters")
	local count = 0

	if rows then
		for i=1,#rows do
			local row = rows[i]
			local hairsColor = string.Split(row["clothes_hairs_color"], ";")
			local headbandColor = string.Split(row["clothes_headband_color"], ";")
			local skinColor = string.Split(row["clothes_skin_color"], ";")
			local char = {
				id = row["id"],
				name = row["name"],
				money = row["money"],
				village = row["village"],
				job = row["job"],
				sex = row["sex"],
				clothes = {
					hairs = row["clothes_hairs"],
					hairs_color = Color(hairsColor[1], hairsColor[2], hairsColor[3]),
					headband_color = Color(headbandColor[1], headbandColor[2], headbandColor[3]),
					skin_color = Color(skinColor[1], skinColor[2], skinColor[3]),
					face = row["clothes_face"],
					body = row["clothes_body"]
				}
			}
			GTOCharSys.Cache[row["steamid"]] = GTOCharSys.Cache[row["steamid"]] or {}
			table.insert(GTOCharSys.Cache[row["steamid"]], char)
			count = count + 1
		end
	end

	print("[GTo] "..count.." personnages mis en cache")
end


function GTOCharSys:InitStorage()
    local xResult = sql.Query([[
        CREATE TABLE IF NOT EXISTS ctg_characters(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            steamid BIGINT(20) NOT NULL,
            name VARCHAR(255),
            sex VARCHAR(255),
            clothes_hairs VARCHAR(255),
            clothes_hairs_color VARCHAR(255),
            clothes_headband_color VARCHAR(255),
            clothes_skin_color VARCHAR(255),
            clothes_face VARCHAR(255),
            clothes_body VARCHAR(255),
            village VARCHAR(255),
            money BIGINT(20),
            job VARCHAR(255)
        )
    ]])
    
    GTOCharSys.Cache = {}

    cacheAll()
end 


function GTOCharSys:GetCharacters(steamid)
	local characters = {}

	if GTOCharSys.Cache[steamid] then
		characters = GTOCharSys.Cache[steamid]
	else
        local rows = sql.Query("SELECT * FROM ctg_characters WHERE steamid='"..steamid.."'")

        if rows then
            for i=1,#rows do
                local row = rows[i]
                local hairsColor = string.Split(row["clothes_hairs_color"], ";")
                local headbandColor = string.Split(row["clothes_headband_color"], ";")
                local skinColor = string.Split(row["clothes_skin_color"], ";")
                local char = {
                    id = row["id"],
                    name = row["name"],
                    money = row["money"],
                    village = row["village"],
                    job = row["job"],
                    sex = row["sex"],
                    clothes = {
                        hairs = row["clothes_hairs"],
                        hairs_color = Color(hairsColor[1], hairsColor[2], hairsColor[3]),
                        headband_color = Color(headbandColor[1], headbandColor[2], headbandColor[3]),
                        skin_color = Color(skinColor[1], skinColor[2], skinColor[3]),
                        face = row["clothes_face"],
                        body = row["clothes_body"]
                    }
                }
                table.insert(characters, char)
            end
        end

        GTOCharSys.Cache[steamid] = characters
    end

	return characters
end


function GTOCharSys:GetCharacterByID(steamid, id)
	local characters = self:GetCharacters(steamid)
	for i=1,#characters do
		if characters[i].id == id then
			return characters[i]
		end
	end
	return false
end


function GTOCharSys:DeleteCharacter(steamid, id)
	local char = self:GetCharacterByID(steamid, id)
	if not char then return end

	sql.Query(string.format([[DELETE FROM ctg_characters WHERE id=%s]], id))
	table.RemoveByValue(GTOCharSys.Cache[steamid], char)

	hook.Run("CTG_CHARACTERS_DELETE", steamid, char)
	return char
end


function GTOCharSys:GetCharacterOwner(id)
	local steamid = sql.QueryValue(string.format([[SELECT steamid FROM ctg_characters WHERE id=%s]], sql.SQLStr(id)))
	return steamid
end


function GTOCharSys:GetCharactersCount(steamid)
	local characters = self:GetCharacters(steamid)
	return #characters
end


function GTOCharSys:SaveCharacter(steamid)
    
	local characters = self:GetCharacters(steamid)
	if not characters then return end
	for i=1,3 do
		local char = characters[i]
		if not char or not char.id then continue end

		local charExists = false
		local row = sql.Query("SELECT 1 FROM ctg_characters WHERE id="..sql.SQLStr(char.id))
		if row then
			charExists = true
		end

		local query = ""
		if charExists then
			query = "UPDATE ctg_characters SET "
			local variables = {}
			for key, value in pairs(char) do
				if key == "id" then continue end
				if istable(value) then
					for key2, value2 in pairs(value) do
						local metaTable = debug.getmetatable(value2)
						if metaTable and metaTable.ToHSL then -- c'est une couleur
							variables[key.."_"..key2] = string.format("%d;%d;%d", value2.r, value2.g, value2.b)
						else
							variables[key.."_"..key2] = value2
						end
					end
				else
					local metaTable = debug.getmetatable(value)
					if metaTable and metaTable.ToHSL then -- c'est une couleur
						variables[key] = string.format("%d;%d;%d", value.r, value.g, value.b)
					else
						variables[key] = value
					end
				end
			end

			local i = 1
			local len = table.Count(variables)
			for key, value in pairs(variables) do
				local separator = ""
				if i < len then
					separator = ", "
				end
				-- query = query..key.."='"..value..separator
				query = query..key.."="..sql.SQLStr(value)..separator
				i = i + 1
			end

			query = query.." WHERE id='"..char.id.."'"
		else
			local variables = {}
			for key, value in pairs(char) do
				if key == "id" then continue end
				if istable(value) then
					for key2, value2 in pairs(value) do
						local metaTable = debug.getmetatable(value2)
						if metaTable and metaTable.ToHSL then -- c'est une couleur
							variables[key.."_"..key2] = string.format("%d;%d;%d", value2.r, value2.g, value2.b)
						else
							variables[key.."_"..key2] = value2
						end
					end
				else
					local metaTable = debug.getmetatable(value)
					if metaTable and metaTable.ToHSL then -- c'est une couleur
						variables[key] = string.format("%d;%d;%d", value.r, value.g, value.b)
					else
						variables[key] = value
					end
				end
			end

			local columns = ""
			local values = ""

			local i = 1
			local len = table.Count(variables)
			for key, value in pairs(variables) do
				local separator = ""
				if i < len then
					separator = ", "
				end
				-- query = query..key.."='"..value..separator
				columns = columns..sql.SQLStr(key, true)..separator
				values = values..sql.SQLStr(value)..separator
				i = i + 1
			end
			query = "INSERT INTO ctg_characters("..columns..") VALUES("..values..")"
		end
		
		sql.Query(query)
	end
	-- if CTGPermaSwepSystem then
		CTGPermaSwepSystem:SaveData(steamid)
	-- end
	-- debug.Trace()
end



function GTOCharSys:GetNextAvailableID()

	local row = sql.Query("SELECT * FROM sqlite_sequence WHERE name='ctg_characters' LIMIT 1")
	if row and row[1] and row[1]["seq"] then
		return row[1]["seq"] + 1
	else
		return 1
	end
end



function GTOCharSys:CreateCharacter(steamid, userInput)
    local jobTable = nil 
    userInput.village = string.Trim(userInput.village)
    userInput.name = string.Trim(userInput.name)

    if userInput.village == "Konoha" then
        jobTable = RPExtraTeams[TEAM_KONO_ELEVE]
    elseif userInput.village == "Kiri" then
        jobTable = RPExtraTeams[TEAM_KIRI_ELEVE]
    end

    local idd = tostring(self:GetNextAvailableID())

	local char = {
		id = idd,
		steamid = steamid,
		name = userInput.name,
		money = 100,
		village = userInput.village,
		job = jobTable.command,
		sex = userInput.sex,
		clothes = {
			hairs = userInput.clothes.hairs,
			hairs_color = userInput.clothes.hairs_color,
			headband_color = userInput.clothes.headband_color,
			skin_color = userInput.clothes.skin_color,
			face = userInput.clothes.face,
			body = userInput.clothes.body
		}
	}



	local characters = self:GetCharacters(steamid)
	table.insert(characters, char)
	GTOCharSys.Cache[steamid] = characters
	self:SaveCharacter(steamid)

	local ply = player.GetBySteamID64(steamid)
	if not IsValid(ply) or not ply:IsConnected() then return end
	ply:GTO_SelectCharacter(char.id)
end
  
function GTOCharSys:GetCache()
	return self.Cache
end

function GTOCharSys:GetCharactersBySteamID(sSteamID)
    if not sSteamID then return {} end
    
    local escapedSteamID = sql.SQLStr(sSteamID)
    local sQuery = string.format(
        "SELECT * FROM ctg_characters WHERE steamid = %s",
        escapedSteamID
    )
    
    local xResult = sql.Query(sQuery)
    
    if xResult == false then
        print("GTOCharSys: Error fetching characters -", sql.LastError())
        return {}
    end
    
    return xResult or {}
end 

function GTOCharSys:DeleteAllCharacters()
    local sQuery = "DELETE FROM ctg_characters"
    local xResult = sql.Query(sQuery)
    
    if xResult == false then
        print("GTOCharSys: Error deleting characters -", sql.LastError())
    end
    return xResult
end



function GTOCharSys:UpdateClothes(steamID, id, clothes)
    local query = string.format(
        "UPDATE ctg_characters SET clothes_hairs = %s, clothes_hairs_color = %s, clothes_headband_color = %s, clothes_skin_color = %s, clothes_face = %s, clothes_body = %s WHERE steamid = %s AND id = %d",
        sql.SQLStr(clothes.hairs),
        sql.SQLStr(clothes.hairs_color.r..";"..clothes.hairs_color.g..";"..clothes.hairs_color.b),
        sql.SQLStr(clothes.headband_color.r..";"..clothes.headband_color.g..";"..clothes.headband_color.b),
        sql.SQLStr(clothes.skin_color.r..";"..clothes.skin_color.g..";"..clothes.skin_color.b),
        sql.SQLStr(clothes.face),
        sql.SQLStr(clothes.body),
        sql.SQLStr(steamID),
        tonumber(id)
    )

    local result = sql.Query(query)

    if result == false then
        print("GTOCharSys: Erreur lors de la mise à jour des vêtements -", sql.LastError())
        return false
    end

    return true
end
            


function GTOCharSys:GetAllCharacters()
    local query = "SELECT * FROM ctg_characters"
    local result = sql.Query(query)

    local characters = {}

    if result then
        for i=1, #result do
            local row = result[i]
            local hairsColor = string.Split(row["clothes_hairs_color"], ";")
            local headbandColor = string.Split(row["clothes_headband_color"], ";")
            local skinColor = string.Split(row["clothes_skin_color"], ";")
            local char = {
                id = row["id"],
                name = row["name"],
                money = row["money"],
                village = row["village"],
                job = row["job"],
                sex = row["sex"],
                clothes = {
                    hairs = row["clothes_hairs"],
                    hairs_color = Color(hairsColor[1], hairsColor[2], hairsColor[3]),
                    headband_color = Color(headbandColor[1], headbandColor[2], headbandColor[3]),
                    face = row["clothes_face"],
                    body = row["clothes_body"]
                }
            }
            characters[row["steamid"]] = characters[row["steamid"]] or {}
            table.insert(characters[row["steamid"]], char)
        end
    end
    
    if result == false then
        print("GTOCharSys: Erreur lors de la récupération de tous les personnages -", sql.LastError())
        return {}
    end
    
    return characters or {}

end



GTOCharSys:InitStorage()