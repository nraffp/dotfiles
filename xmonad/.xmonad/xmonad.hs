-----------------------------------------------------------------
---------------------------XMONAD CONFIG--------------------------


-------------------------------------------
---------- Imports ------------------------

import XMonad
import Data.Monoid
import System.Exit
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.InsertPosition

import XMonad.Actions.Warp
import XMonad.Actions.NoBorders
import XMonad.Prompt
import XMonad.Prompt.Shell

import XMonad.Layout.Grid
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import XMonad.Layout.Grid
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Fullscreen
import XMonad.Layout.Spacing
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.ResizableTile

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import Graphics.X11.ExtraTypes.XF86
import XMonad.Hooks.DynamicLog
-------------------------------------------------------------------------------------------------------
---------- Default Programs ---------------------------------------------------------------------------

myTerminal = "kitty"
myBrowser  = "google-chrome-stable"


-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
myBorderWidth   = 0

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "white"
myFocusedBorderColor = "white"

----------------------------------------------------------------------------------------------
---------- Key bindings ----------------------------------------------------------------------

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

 [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)       -- Launch Terminal
 , ((modm .|. shiftMask, xK_b     ), spawn myBrowser)          	         -- Launch Broswer
 , ((modm .|. shiftMask, xK_p     ), spawn "$HOME/.config/rofi/scripts/edit-configs-rofi.sh")      -- Launch Dmenu Quick Actions
 , ((modm,               xK_p     ), spawn "rofi -show drun")		         -- Launch Dmenu
 , ((modm,               xK_v     ), spawn "alacritty -t ncpamixer -e ncpamixer")		               -- Launch Volume Controls
 , ((modm .|. shiftMask, xK_c     ), kill)				                       -- Close Focus Window
 , ((modm,               xK_space ), sendMessage NextLayout)             -- Rotate through the available layout 
 , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf) -- Reset the layoutsi

 , ((modm,               xK_x     ), sequence_ [ 
                                     sendMessage ToggleStruts,           -- Fullscreen          
																		 sendMessage $ Toggle NBFULL
				     ])
 , ((modm,               xK_g     ), sequence_ [
                                     toggleWindowSpacingEnabled,         -- Toggle Gaps
																		 toggleScreenSpacingEnabled
				     ])
 , ((modm,               xK_n     ), refresh)                   	 -- Resize / Refresh window
 , ((modm,               xK_Tab   ), windows W.focusDown)                                                   -- Move focus to the next window

 , ((modm,               xK_m     ), windows W.focusMaster)            -- Move focus to the master window
 , ((modm,               xK_Return), windows W.swapMaster)             -- Swap focus w/ master
 , ((modm .|. shiftMask, xK_j     ), windows W.swapDown)               -- Swap focus w/ next
 , ((modm .|. shiftMask, xK_k     ), windows W.swapUp)               -- Swap focus w/ previous

 , ((modm,               xK_j     ), sendMessage MirrorShrink)           -- Shrink Vertically
 , ((modm,               xK_k     ), sendMessage MirrorExpand  )     		 -- Expand Vertically
 , ((modm,               xK_h     ), sendMessage Shrink)                 -- Shrink Master
 , ((modm,               xK_l     ), sendMessage Expand)                 -- Expand Master

 , ((modm,               xK_t     ), withFocused $ windows . W.sink)     -- Push window back into tiling
 , ((modm              , xK_comma ), sendMessage (IncMasterN 1))         -- Increase # of masters
 , ((modm              , xK_period), sendMessage (IncMasterN (-1)))      -- Decrease # of masters
-- , ((modm              , xK_b     ), sendMessage ToggleStruts)         -- Toggle struts
 , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))          -- Quit xmonad
 , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")   -- Restart xmonad
 , ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -")) --Keybinds help
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
------------------------------------------------------------------------

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:
------------------------------------------------------------------------
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

myLayoutHook = mkToggle (single NBFULL) (myDefaultLayout)
             where
               myDefaultLayout =     mastStack
				 ||| centMast
				 ||| monocle
				 ||| grid

mastStack = renamed [Replace "Master and Stack"]
	$ mySpacing 8
  -- $ smartBorders
	$ ResizableTall 1 (3/100) (1/2) []
centMast = renamed [Replace "Centered Master"] 
	$ mySpacing 8 
	$ ThreeColMid 1 (3/100) (1/2)
monocle = renamed [Replace "Monocle"] 
	$ mySpacing 8 
	$ Full
grid = renamed [Replace "Grid"] 
	$ mySpacing 8 
	$ Grid
------------------------------------------------------------------------
-- Window rules:
------------------------------------------------------------------------

myManageHook = 

    composeAll
     [ className =? "MPlayer"         --> doFloat
     , currentWs =? "5"               --> doCenterFloat
     , className =? "Gimp"            --> doFloat
     , title =? "ncpamixer"           --> doCenterFloat
     , title =? "Picture-in-Picture"  --> doFloat
     , resource  =? "desktop_window"  --> doIgnore
     , resource  =? "kdesktop"        --> doIgnore ]

------------------------------------------------------------------------
-- Event handling
------------------------------------------------------------------------

myEventHook = fullscreenEventHook

------------------------------------------------------------------------
-- Status bars and logging
------------------------------------------------------------------------

myLogHook = return ()
 
------------------------------------------------------------------------
-- Startup hook
------------------------------------------------------------------------

myStartupHook = do
        spawnOnce "~/.fehbg &"
        spawnOnce "picom &"

------------------------------------------------------------------------
--Main
------------------------------------------------------------------------

main  = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

myBar = "xmobar" --flags=\"with_alsa\""

myPP  =  xmobarPP { ppCurrent = xmobarColor "#98be65" "" . wrap "|" "|" -- Current workspace in xmobar
                , ppVisible = xmobarColor "#98be65" ""                -- Visible but not current workspace
                , ppHidden = xmobarColor "#82AAFF" ""                 -- Hidden workspaces in xmobar
                , ppHiddenNoWindows = xmobarColor "#c792ea" ""        -- Hidden workspaces (no windows)
                , ppTitle = xmobarColor "#0095ff" "" . shorten 150    -- Title of active window in xmobar
		, ppExtras  = [windowCount]                           -- # of windows current workspace
		, ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
                        }

toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_s)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

-- Main configuration, override the defaults to your liking.
myConfig = def {
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

        keys               = myKeys,
        mouseBindings      = myMouseBindings,

        layoutHook         = myLayoutHook,
 	      manageHook         = insertPosition End Newer <+> myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }

-- | Finally, a copy of the default bindings in simple textual tabular format.
help :: String
help = unlines ["The default modifier key is 'alt'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch xterminal",
    "mod-p            Launch dmenu",
    "mod-Shift-p      Launch gmrun",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the numbeof windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "mod-[1..9]   Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]
