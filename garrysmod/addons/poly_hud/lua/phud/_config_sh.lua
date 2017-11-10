
-----------------------------------------------------
--
-- CONFIG SETTINGS
--     its pretty short right now. im going to try to add more xD.
--

phud.config = {}
phud.config.blur = true
phud.config.language = 'english' -- must match the exact case as the file in phud/languages/


--
-- CONFIG VALIDATION
--
assert(file.Exists('phud/languages/' .. phud.config.language .. '.lua', 'LUA'), 'phud failed to load. language: ' .. phud.config.language .. ' does not exist.')