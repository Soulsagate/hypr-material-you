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
