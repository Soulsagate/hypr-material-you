-- Monitor layout bound by description, not port — safe across reconnects
-- LG left, ASUS center (250Hz OC), AU Optronics right (300Hz portrait)

hl.monitor({
    output = "desc:LG Electronics LG ULTRAGEAR",
    mode = "1920x1080@143.98",
    position = "0x0",
    scale = 1.0,
    vrr = 0
})
hl.monitor({
    output = "desc:ASUSTek COMPUTER INC VG249QM1A T3LMQS117094",
    mode = "1920x1080@249.93",
    position = "1920x0",
    scale = 1.0,
    vrr = 0
})
hl.monitor({
    output = "desc:AU Optronics 0xDE8E",
    mode = "1920x1080@300.19",
    position = "3840x0",
    scale = 1,
    vrr = 0,
    transform = 3
})

-- Workspace layout: center (ASUS) gets 1-5, sides get one persistent home each.
-- Rules need port names but ports aren't known at config load, so defer via monitorAdded.
local ws_descs = {
    center = "ASUSTek COMPUTER INC VG249QM1A T3LMQS117094",
    left   = "LG Electronics LG ULTRAGEAR",
    right  = "AU Optronics 0xDE8E",
}

local function apply_workspace_rules()
    local port = {}
    for _, m in ipairs(hl.get_monitors()) do
        for role, desc in pairs(ws_descs) do
            if m.description == desc then port[role] = m.name end
        end
    end
    if port.center then
        for i = 1, 5 do
            hl.workspace_rule({ workspace = tostring(i), monitor = port.center, persistent = true, default = (i == 1) })
        end
    end
    if port.left then
        hl.workspace_rule({ workspace = "6", monitor = port.left, persistent = true, default = true })
    end
    if port.right then
        hl.workspace_rule({ workspace = "7", monitor = port.right, persistent = true, default = true })
    end
end

hl.on("monitorAdded", apply_workspace_rules)
