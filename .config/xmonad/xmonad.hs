import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Util.SpawnOnce
import XMonad.Util.Loggers
import XMonad.Layout.Spacing
import XMonad.Hooks.Script
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

import qualified Codec.Binary.UTF8.String as UTF8
import qualified Xmobar as Bar

import Xmobar (Runnable(..), Kbd(..), Date(..), XMonadLog(..), Monitors(..))


-- #Colors
underline = "#abb2bf"
bg1 = "#3c3836"
bg2 = "#504945"
red = "#ff0000"
blue = "#1780e8"
font = "#abb2bf"

-- #Main
main :: IO ()
main = xmonad
  . ewmhFullscreen
  . ewmh
  . withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey
  $ mkConfig

mkConfig = def
    { terminal = "alacritty"
    , modMask = mod4Mask
    , layoutHook = spacingRaw False (Border 2 2 2 2) True (Border 5 5 5 5) True $ myLayout
    , focusedBorderColor = "#458588"
    , normalBorderColor = "#b16286"
    , borderWidth = 3
    , startupHook = myStartupHook
    }
      `additionalKeysP`
      [ ("M-f" , spawn "firefox")
      , ("M-S-p", spawn "rofi -show drun")
      , ("M-<F3>", spawn "brightnessctl s +10%")
      , ("M-<F4>", spawn "brightnessctl s 10%-")
      , ("M-S-s", spawn "flameshot full")
      , ("M-S-x", spawn "xsecurelock")
      ]


-- #Log (status bars)
myXmobarPP :: PP
myXmobarPP = def
    { ppHidden = wrap " " " "
    , ppWsSep = " • "
    , ppSep = " >> "
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
    spawnOnce "xrandr --output DP-1 --mode 2560x1440 --left-of HDMI-1"
    spawnOnce "feh --bg-fill $HOME/pictures/wallpapers/pangong-lake-ladakh.jpg"
    spawnOnce "picom --vsync"
    spawnOnce "alacritty"
    spawnOnce "xsetroot -xcf /usr/share/icons/Adwaita/cursors/left_ptr 32"
    --spawnOnce "xmodmap $HOME/.Xmodmap"
    --spawnOnce "exec $HOME/.local/bin/xscreen-lock"
    --spawn "/home/shrey_bana/.config/polybar/launch.sh"
