import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Util.SpawnOnce
import XMonad.Util.Loggers
import XMonad.Layout.Spacing
import XMonad.Hooks.Script
import XMonad.Hooks.ManageDocks

import XMonad.Hooks.DynamicLog
import qualified XMonad.DBus as XD
import qualified DBus.Client as D
import qualified Codec.Binary.UTF8.String as UTF8


-- #Colors
underline = "#abb2bf"
bg1 = "#3c3836"
bg2 = "#504945"
red = "#ff0000"
blue = "#1780e8"
font = "#abb2bf"

-- #Main
main :: IO ()
main = do 
    dbus <- XD.connect
    XD.requestAccess dbus
    xmonad $ docks $ def
      { terminal = "alacritty"
      , modMask = mod4Mask
      , layoutHook = spacingRaw False (Border 0 0 0 0) True (Border 2 2 2 2) True $ myLayout
      , focusedBorderColor = "#458588"
      , normalBorderColor = "#b16286"
      , borderWidth = 2
      , startupHook = myStartupHook
      , logHook = dynamicLogWithPP (myLogHook dbus)
      }
        `additionalKeysP`
        [ ("M-S-f" , spawn "firefox")
        , ("M-S-p", spawn "rofi -show drun")
        , ("M-<F3>", spawn "brightnessctl s +10%")
        , ("M-<F4>", spawn "brightnessctl s 10%-")
        , ("M-S-s", spawn "flameshot full")
        ]


-- #Log (status bars)
myLogHook :: D.Client -> PP
myLogHook dbus = def
    { ppOutput = XD.send dbus
    , ppCurrent = wrap ("%{u" ++ underline ++ "}%{+u} ") " %{-u}"
    , ppUrgent = wrap ("%{u" ++ red ++ "}%{+u} ") " %{-u}"
    , ppHidden = wrap " " " "
    , ppWsSep = ""
    , ppSep = " >>%{F" ++ font ++ "}  "
    , ppTitle = shorten 25
    , ppOrder = \(ws:_:t:_) -> [ws,t]
    }

-- #Layout
myLayout = avoidStruts (tiled ||| Mirror tiled ||| Full)
  where
    tiled   = Tall nmaster delta ratio
    nmaster = 001        -- Default number of windows in the master pane
    ratio   = 005 / 008  -- Default proportion of screen occupied by master pane
    delta   = 003 / 100  -- Percent of screen to

-- #Startup
myStartupHook = do
    spawnOnce "feh --bg-fill $HOME/pictures/wallpapers/green-leaves.jpg"
    spawnOnce "picom"
    spawnOnce "alacritty"
    spawnOnce "xsetroot -xcf /usr/share/icons/Adwaita/cursors/left_ptr 32"
    spawnOnce "xmodmap $HOME/.Xmodmap"
    spawnOnce "exec $HOME/.local/bin/xscreen-lock"
    spawn "$HOME/.config/polybar/./launch.sh"
