(array/push
  (config :xkb-bindings)
  [:e {:mod4 true} (action/spawn ["firefox"])]
  [:f {:mod4 true} (action/fullscreen)]
  [:f {:mod4 true :shift true} (action/spawn ["flameshot" "gui"])]
  [:a {:mod4 true} (action/spawn ["alacritty"])]
  [:q {:mod4 true :shift true} (action/spawn ["pkill" "river"])]
  [:p {:mod4 true :shift true} (action/spawn ["rofi" "-show" "drun"])]
  [:h {:mod4 true :shift true} (action/spawn ["rofi" "-show" "window"])]
  [:r {:mod4 true} (action/reload-config)]
  [:r {:mod4 true :shift true} (action/spawn ["rofi" "-show" "run"])]
  [:s {:mod4 true :shift true} (action/spawn ["flameshot" "full"])]
  [:XF86MonBrightnessUp {} (action/spawn ["brightnessctl" "s" "+10%"])]
  [:XF86MonBrightnessDown {} (action/spawn ["brightnessctl" "s" "10%-"])]
  [:XF86AudioPlay {} (action/spawn ["spotifycli" "--playpause"])]
  [:XF86AudioNext {} (action/spawn ["spotifycli" "--next"])]
  [:XF86AudioPrev {} (action/spawn ["spotifycli" "--prev"])]
  [:c {:mod4 true :shift true} (action/close)])
