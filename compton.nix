{ config, pkgs, ...}:

{ 
  services.compton = {
    enable = true;
    extraOptions    = ''
      backend = "glx";
      vsync = "opengl-swc";

      shadow = true;
      no-dock-shadow = true;
      no-dnd-shadow = true;
      clear-shadow = true;

      shadow-radius = 10;
      shadow-offset-x = -5;
      shadow-offset-y = 0;
      shadow-opacity = 0.8;
      shadow-red = 0.11;
      shadow-green = 0.12;
      shadow-blue = 0.13;
      shadow-exclude = [
      "name = 'Notification'",
      "_GTK_FRAME_EXTENTS@:c",
      "class_g = 'i3-frame'",
      "_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'",
      "_NET_WM_STATE@:32a *= '_NET_WM_STATE_STICKY'",
      "!I3_FLOATING_WINDOW@:c"
      ];
      shadow-ignore-shaped = true;

      alpha-step = 0.06;
      blur-background = false;
      blur-background-fixed = true;
      blur-kern = "7x7box";
      blur-background-exclude = [
      "class_g = 'i3-frame'",
      "window_type = 'dock'",
      "window_type = 'desktop'",
      "_GTK_FRAME_EXTENTS@:c"
      ];

      # Duplicating the _NET_WM_STATE entries because compton cannot deal with atom arrays :-/
      opacity-rule = [
      "97:class_g = 'Termite' && !_NET_WM_STATE@:32a",

      "0:_NET_WM_STATE@[0]:32a = '_NET_WM_STATE_HIDDEN'",
      "0:_NET_WM_STATE@[1]:32a = '_NET_WM_STATE_HIDDEN'",
      "0:_NET_WM_STATE@[2]:32a = '_NET_WM_STATE_HIDDEN'",
      "0:_NET_WM_STATE@[3]:32a = '_NET_WM_STATE_HIDDEN'",
      "0:_NET_WM_STATE@[4]:32a = '_NET_WM_STATE_HIDDEN'",

      "90:_NET_WM_STATE@[0]:32a = '_NET_WM_STATE_STICKY'",
      "90:_NET_WM_STATE@[1]:32a = '_NET_WM_STATE_STICKY'",
      "90:_NET_WM_STATE@[2]:32a = '_NET_WM_STATE_STICKY'",
      "90:_NET_WM_STATE@[3]:32a = '_NET_WM_STATE_STICKY'",
      "90:_NET_WM_STATE@[4]:32a = '_NET_WM_STATE_STICKY'"
      ];

      fading = false;
      fade-delta = 7;
      fade-in-step = 0.05;
      fade-out-step = 0.05;
      fade-exclude = [];

      mark-wmwin-focused = true;
      mark-ovredir-focused = true;
      use-ewmh-active-win = true;
      detect-rounded-corners = true;
      detect-client-opacity = true;
      refresh-rate = 0;
      dbe = false;
      paint-on-overlay = true;
      glx-no-stencil = true;
      glx-copy-from-front = false;
      glx-swap-method = "undefined";
      sw-opti = true;
      unredir-if-possible = false;
      focus-exclude = [];
      detect-transient = true;
      detect-client-leader = true;
      invert-color-include = [];

      wintypes: {
      tooltip = { fade = true; shadow = false; opacity = 1.00; focus = true; };
      };
    '';
  }; 
}
