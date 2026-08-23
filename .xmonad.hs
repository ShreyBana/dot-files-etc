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
    , focusedBorderColor = "#646D7E"
    , normalBorderColor = "#b16286"
    , borderWidth = 2
    , startupHook = myStartupHook
    , manageHook = myManageHook
    }
      `additionalKeysP`
      [ ("M-S-f" , spawn "flameshot gui")
      , ("M-S-p", spawn "rofi -show drun")
      , ("M-S-h", spawn "rofi -show window")
      , ("M-S-r", spawn "rofi -show run")
      , ("M-<F3>", spawn "brightnessctl s +10%")
      , ("M-<F4>", spawn "brightnessctl s 10%-")
      , ("M-S-s", spawn "flameshot full")
      , ("M-S-x", spawn "xsecurelock")
      , ("M-S-<Backspace>", spawn "spotifycli --playpause")
      , ("<XF86AudioPlay>", spawn "spotifycli --playpause")
      , ("M-S-<R>", spawn "spotifycli --next")
      , ("<XF86AudioNext>", spawn "spotifycli --next")
      , ("M-S-<L>", spawn "spotifycli --previous")
      , ("<XF86AudioPrev>", spawn "spotifycli --prev")
      , ("M-f", sendMessage $ Toggle "Full")
      ]

myBar =
      let iconConfig = def { iconConfigIcons = myIcons, iconConfigFmt = iconsFmtAppend (wrapUnwords "{" "}") }
      in statusBarProp "xmobar" (dynamicIconsPP iconConfig myXmobarPP)

-- #Log (status bars)
myXmobarPP = def
    { ppHidden = wrap " " " "
    , ppWsSep = "  "
    , ppSep = " @ "
    , ppTitle = shorten 70
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
    spawnOnce "picom --vsync"
    spawnOnce "xmobar"

myManageHook =
  composeAll [manageDocks, isFullscreen --> doFullFloat]

myIcons = composeAll
  [ className =? "Alacritty" --> appIcon "\xf489"
  , className =? "Firefox" <||> className =? "firefox" --> appIcon "\xe745"
  , className =? "Librewolf" <||> className =? "librewolf" --> appIcon "\xf059f"
  , className =? "slack" <||> className =? "Slack" --> appIcon "\xf04b1"
  , className =? "spotify" <||> className =? "Spotify" --> appIcon "\xf04c7"
  , className =? "emacs" <||> className =? "Emacs" --> appIcon "\xe632"
  , (foldl' (<||>) (className =? "") pdfReaderCName) --> appIcon "\xf16c9"
  ]
  where
    pdfReaderCName = (className =?) <$> ["zathura", "Zathura", "Okular", "okular", "sioyek"]
