---- LOOK AND FEEL ----

local colors = select(2, pcall(dofile, os.getenv("HOME") .. "/.config/hypr/matugen-colors.lua"))
if type(colors) ~= "table" then
    colors = {
        active_border   = "rgba(bec2ffff)",
        inactive_border = "rgba(46464f66)",
        shadow          = "rgba(00000059)",
    }
end

hl.config({ render = { expand_undersized_textures = false}})
hl.config({
    general = {
        gaps_in = 6,
        gaps_out = {
            top = 5,
            right = 12,
            bottom = 12,
            left = 12,
        },
        border_size = 1,
        col = {
            active_border = colors.active_border,
            inactive_border = colors.inactive_border,
        },
        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
    },
    decoration = {
        rounding = 14,
        blur = {
            enabled = true,
            size = 8,
            passes = 3,
            vibrancy = 0.2,
            noise = 0.0117,
        },
        shadow = {
            enabled = true,
            range = 18,
            render_power = 3,
            color = colors.shadow,
        },
    },
    animations = {
        enabled = true,
    },
})

hl.curve("md3_decel", { type = "bezier", points = { {0.05, 0.7}, {0.1, 1.0} } })
hl.curve("md3_accel", { type = "bezier", points = { {0.3, 0.0}, {0.8, 0.15} } })

hl.animation({ leaf = "windows",    enabled = true, speed = 4, bezier = "md3_decel", style = "popin 88%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "md3_accel", style = "popin 88%" })
hl.animation({ leaf = "border",     enabled = true, speed = 8, bezier = "md3_decel" })
hl.animation({ leaf = "fade",       enabled = true, speed = 3, bezier = "md3_decel" })
hl.animation({ leaf = "layers",     enabled = true, speed = 4, bezier = "md3_decel", style = "popin 90%" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "md3_decel", style = "slidefade 15%" })
