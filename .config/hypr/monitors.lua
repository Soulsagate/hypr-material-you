-- Monitor layout: DP-1 (LG) left, DP-3 (ASUS) center, DP-2 (Blade panel) right vertical

hl.monitor({
    output = "DP-1",
    mode = "1920x1080@143.98",
    position = "0x0",
    scale = 1.0,
    vrr = 0
})
hl.monitor({
    output = "DP-3",
    mode = "1920x1080@239.76",
    position = "1920x0",
    scale = 1.0,
    vrr = 0
})
hl.monitor({
    output = "DP-2",
    mode = "1920x1080@300.19",
    position = "3840x0",
    scale = 1,
    vrr = 0,
    transform = 3
})

-- WORKSPACE RULES
-- https://wiki.hypr.land/Configuring/Workspace-Rules/
-- Workspaces 1-4 live on the main monitor (DP-3, center) instead of being
-- spread one-per-monitor. Workspace 1 is what DP-3 shows at startup.
local MAIN_MONITOR = "DP-3"

hl.workspace_rule({ workspace = "1", monitor = MAIN_MONITOR, default = true, persistent = true })
hl.workspace_rule({ workspace = "2", monitor = MAIN_MONITOR, persistent = true })
hl.workspace_rule({ workspace = "3", monitor = MAIN_MONITOR, persistent = true })
hl.workspace_rule({ workspace = "4", monitor = MAIN_MONITOR, persistent = true })
