ATG_UTILS = ATG_UTILS or {}
function ATG_UTILS.inArray(array, item)
	for key, value in ipairs(array) do
		if value == item then
			return true
		end
	end
	return false
end

function ATG_UTILS.removeDoubles(array)
	local newArray = {}
	for key, value in ipairs(array) do
		if not ATG_UTILS.inArray(newArray, value) then
			table.insert(newArray, value)
		end
	end
	return newArray
end

function ATG_UTILS.sort(array)
	local result = table.Copy(array)
	table.sort(result, function(a, b)
		return string.lower(a) < string.lower(b)
	end)
	return result
end