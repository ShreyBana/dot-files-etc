import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Util.SpawnOnce
import XMonad.Util.Loggers
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders (noBorders, smartBorders)
import XMonad.Layout.ToggleLayouts
import XMonad.Hooks.Script
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Config.Desktop (desktopLayoutModifiers)
import XMonad.Hooks.EwmhDesktops(ewmhFullscreen,ewmh)
import qualified Codec.Binary.UTF8.String as UTF8

dotFilesPath = "$HOME/dot-files-etc"

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
  $ myConfig

myConfig = def
  { terminal = "alacritty"
  , modMask = mod4Mask
  , layoutHook = myLayout
  , focusedBorderColor = "#689d6a"
  , normalBorderColor = "#b16286"
  , borderWidth = 2
  , startupHook = myStartupHook
  , manageHook = myManageHook
  }
  `additionalKeysP`
    [ ("M-S-f" , spawn "firefox-devedition")
    , ("M-S-p", spawn "rofi -show drun")
    , ("M-<F3>", spawn "brightnessctl s +10%")
    , ("M-<F4>", spawn "brightnessctl s 10%-")
    , ("M-S-s", spawn "flameshot full")
    , ("M-S-z", spawn "xscreensaver-command -lock")
    , ("M-f", sendMessage $ Toggle "Full")
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
myLayout = toggleLayouts tiled fullScreen
  where
    fullScreen = noBorders Full
    tiled   = spacingRaw False (Border 5 5 5 5) True (Border 2 2 2 2) True $ Tall nmaster delta ratio
    nmaster = 001        -- Default number of windows in the master pane
    ratio   = 005 / 008  -- Default proportion of screen occupied by master pane
    delta   = 003 / 100  -- Percent of screen to

-- #Startup
myStartupHook = do
    -- spawnOnce "xrandr --output DP-1 --mode 1920x1080"
    spawnOnce "picom"

myManageHook =
  composeOne [isFullscreen -?> doFullFloat]
