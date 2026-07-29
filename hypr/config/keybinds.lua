local mainMod = "SUPER"
local launchPrefix = "uwsm app -- " -- if you are not using UWSM, make this empty (e.g. "")

---------------------------
---- WINDOW MANAGEMENT ----
---------------------------

hl.bind(mainMod .. " + Escape",      hl.dsp.exec_cmd("hyprctl kill"))
hl.bind(mainMod .. " + Q",           hl.dsp.window.close())
hl.bind(mainMod .. " + ALT + Space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D",           hl.dsp.window.fullscreen({ mode = 1 }))
hl.bind(mainMod .. " + F",           hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + J",           hl.dsp.layout("togglesplit"))

-- Change focus
hl.bind(mainMod .. " + Left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + Right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + Up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + Down",  hl.dsp.focus({ direction = "down" }))
hl.bind("ALT + Tab",           hl.dsp.window.cycle_next())

-- Move active window around current workspace
hl.bind(mainMod .. " + SHIFT + Right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + Left",  hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + Up",    hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + Down",  hl.dsp.window.move({ direction = "d" }))
hl.bind(mainMod .. " + CONTROL + SHIFT + Right", hl.dsp.window.move({ workspace = "r+1" }))
hl.bind(mainMod .. " + CONTROL + SHIFT + Left",  hl.dsp.window.move({ workspace = "r-1" }))

-- Move & Resize with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())

------------------
---- LAUNCHER ----
------------------

hl.bind(mainMod .. " + Return",     hl.dsp.exec_cmd(launchPrefix .. TERMINAL))
hl.bind(mainMod .. " + E",          hl.dsp.exec_cmd(launchPrefix .. FILE_MANAGER))
hl.bind(mainMod .. " + T",          hl.dsp.exec_cmd(launchPrefix .. EDITOR))
hl.bind(mainMod .. " + C",          hl.dsp.exec_cmd(launchPrefix .. CALCULATOR))
hl.bind(mainMod .. " + W",          hl.dsp.exec_cmd(launchPrefix .. BROWSER))
hl.bind("CONTROL + SHIFT + Escape", hl.dsp.exec_cmd(launchPrefix .. TERMINAL .. " -e btop"))

---------------------------
---- HARDWARE CONTROLS ----
---------------------------

local osd = "swayosd-client "

-- Audio (F1-F4)
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd(osd .. "--output-volume mute-toggle"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(osd .. "--output-volume lower"),       { locked = true, repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(osd .. "--output-volume raise"),       { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd(osd .. "--input-volume mute-toggle"),  { locked = true })

-- Brightness (F5-F6)
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(osd .. "--brightness lower"), { repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd(osd .. "--brightness raise"), { repeating = true })

-- Media
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-------------------
---- UTILITIES ----
-------------------

local shotDir = os.getenv("HOME") .. "/Pictures/Screenshots"

-- Область → буфер обмена
hl.bind("Print", hl.dsp.exec_cmd("hyprshot -m region --freeze --clipboard-only"))

-- Область → редактор (рисование, Enter = сохранить, Ctrl+C = копировать, Esc = отмена)
hl.bind("SHIFT + Print", hl.dsp.exec_cmd(
    "hyprshot -m region --freeze --raw | satty -f - --early-exit --copy-command wl-copy --output-filename "
    .. shotDir .. "/$(date +%Y%m%d-%H%M%S).png"
))

-- Активное окно → файл
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("hyprshot -m window --freeze -o " .. shotDir))

-- Весь экран → файл
hl.bind("CONTROL + Print", hl.dsp.exec_cmd("hyprshot -m output -o " .. shotDir))

-- Пипетка цвета
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("hyprpicker -a"))

--------------------
---- WORKSPACES ----
--------------------

for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = true }))
    hl.bind(mainMod .. " + ALT + " .. key,   hl.dsp.window.move({ workspace = i, follow = false }))
end

hl.bind(mainMod .. " + CONTROL + Right",       hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mainMod .. " + CONTROL + Left",        hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mainMod .. " + CONTROL + Down",        hl.dsp.focus({ workspace = "empty" }))
hl.bind(mainMod .. " + CONTROL + ALT + Right", hl.dsp.window.move({ workspace = "r+1" }))
hl.bind(mainMod .. " + CONTROL + ALT + Left",  hl.dsp.window.move({ workspace = "r-1" }))

-- Scroll through existing workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special" }))
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special())
