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
import XMonad.Layout.NoBorders (noBorders, smartBorders)
import XMonad.Layout.ToggleLayouts
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.DynamicIcons

import qualified Codec.Binary.UTF8.String as UTF8
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
  . withEasySB myBar defToggleStrutsKey
  $ mkConfig

mkConfig = def
    { terminal = "alacritty"
    , modMask = mod4Mask
    , layoutHook = myLayout
    , focusedBorderColor = "#458588"
    , normalBorderColor = "#b16286"
    , borderWidth = 3
    , startupHook = myStartupHook
    , manageHook = myManageHook
    }
      `additionalKeysP`
      [ ("M-S-f" , spawn "firefox")
      , ("M-S-p", spawn "rofi -show drun")
      , ("M-S-h", spawn "rofi -show window")
      , ("M-S-r", spawn "rofi -show run")
      , ("M-<F3>", spawn "brightnessctl s +10%")
      , ("M-<F4>", spawn "brightnessctl s 10%-")
      , ("M-S-s", spawn "flameshot full")
      , ("M-S-x", spawn "xsecurelock")
      , ("M-f", sendMessage $ Toggle "Full")
      ]

myBar = statusBarProp "xmobar" (iconsPP myIcons myXmobarPP)

-- #Log (status bars)
myXmobarPP = def
    { ppHidden = wrap " " " "
    , ppWsSep = " • "
    , ppSep = " >> "
    , ppTitle = shorten 50
    , ppOrder = \(ws:_:t:_) -> [ws,t]
    }

-- #Layout
myLayout = toggleLayouts tiled (noBorders Full)
  where
    tiled   = spacingRaw False (Border 2 2 2 2) True (Border 5 5 5 5) True layout
    layout  = Tall nmaster delta ratio
    nmaster = 001        -- Default number of windows in the master pane
    ratio   = 005 / 008  -- Default proportion of screen occupied by master pane
    delta   = 003 / 100  -- Percent of screen to

-- #Startup
myStartupHook = do
    spawnOnce "xrandr --output HDMI-1 --mode 2560x1440 --left-of DP-1"
    spawnOnce "picom --vsync"
    spawnOnce "xmobar"
    spawnOnce "feg --bg-fill $HOME/pictures/wallpapers/autmn-mountain.jpg"

myManageHook =
  composeAll [manageDocks, isFullscreen --> doFullFloat]

myIcons = composeAll
  [ className =? "Alacritty" --> appIcon "\xf489"
  , className =? "Firefox" --> appIcon "\xe745"
  , className =? "slack" <||> className =? "Slack" --> appIcon "\xf04b1"
  , className =? "spotify" <||> className =? "Spotify" --> appIcon "\xf04c7"
  , className =? "emacs" <||> className =? "Emacs" --> appIcon "\xe632"
  ]
