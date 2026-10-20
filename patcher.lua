-- load cutscene_player.gds
GDPatch.patch_script_as_text("game/cutscene_player/cutscene_player.gdc", function(ctx, src)
	-- find play_cutscene() and errors if does not exist
	local signature = "static func play_cutscene(cutscene: VideoStream) -> Request:"
	local _, signature_end = src:find(signature, 1, true)
	if not signature_end then
		error("Could not find play_cutscene in " .. ctx.path)
	end

	-- make sure function does not already return null, tho this shouldnt happen generally
	local first_line = src:sub(signature_end + 1):match("^\r?\n([^\r\n]*)")
	if first_line and first_line:match("^%s*return null%s*$") then
		return src
	end

	-- insert return null after function signature
	return src:sub(1, signature_end) .. "\n\treturn null" .. src:sub(signature_end + 1)
end)

-- downside to this method is that valence cant be interacted with at all
-- upside to this method is that i finally learned some lua lets go