-- i18n.lp
-- Lightweight translation helper for Pi-hole Web

local locales = {}
local current_lang = "en"

function load_locale(lang)
  local path = "scripts/lua/locales/" .. lang .. ".json"
  local f = io.open(path, "r")
  if not f then return nil end
  local content = f:read("*a")
  f:close()
  -- Simple JSON parse (or use available JSON lib if present)
  -- For production, prefer a proper JSON decoder
  local ok, data = pcall(function() return cjson.decode(content) end)
  if ok then
    locales[lang] = data
  end
  return locales[lang]
end

function set_language(lang)
  if not locales[lang] then
    load_locale(lang)
  end
  if locales[lang] then
    current_lang = lang
    -- Persist via cookie
    mg.set_cookie("pihole_lang", lang, 365 * 24 * 60 * 60)
  end
end

function t(key)
  local dict = locales[current_lang] or locales["en"] or {}
  return dict[key] or key
end

-- Load English by default
load_locale("en")

-- Read cookie if present
local cookie = mg.get_cookie("pihole_lang")
if cookie and cookie ~= "" then
  set_language(cookie)
end
