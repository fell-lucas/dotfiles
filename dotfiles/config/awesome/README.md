# About this rice
This rice is using **nordish** theme, you can find it in themes/nordish,
where it is also located the wallpaper.

### Recommended screen size
Recommended -> 1920x1080  
Minimun     -> 1366x768


# FAQ
- How i can get that **bar**?
    - You can get that bar, by checking the **theme.lua** located in themes/nordish

- What do i need before copying these dotfiles?
    - well, you need some dependencies

| Dependencies | Why it is needed |
| --- | --- |
| awesome-buttons, awesome-wm-widgets, lain, some scripts | It is used by the bar, they're in this same directory so don't worry 'bout that |
| picom | compositor |
| dunst | notification daemon |
| kitty | terminal emulator, if you don't like it, change it in the **rc.lua**|
| dolphin | file manager |
| flameshot | screenshooting |
| rofi | app runner |
| font | [hack](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete%20Mono.ttf)|
| chromium | web browser, again, if you don't like it, change it in the **rc.lua** and some parts of **themes/nordish/theme.lua** have chromium in it, so, if you use vim, id recommend you to run the folowing command: :%s/chromium/myfavoritewebbrowser/g |

- I need something to run on startup, what i can do?
    - Add this line to the **autorstart.sh**: ``run myapp``

- How do i change my wallpaper?
    - You can change the wallpaper by changing the image located in **themes/nordish/wallpaper.jpg**, or if you prefer, you can use **nitrogen**

| apps keybindings | usage |
| --- | --- |
| **super + Enter** | runs terminal emulator (kitty) |
| **super + w** | opens webbrowser |
| **super + t** | opens telegram |
| **super + d** | opens discord |
| **super + c** | opens ms teams |
| **super + g** | opens libreoffice |
| **super + e** | opens vifm |
| **super + r** | runs a program with rofi |
| **super + v** | runs a pavucontrol |
| **Print** | runs flameshot gui command to take a screenshot |

| awesome keybindings | usage |
| --- | --- |
| **super + x** | exits awesome |
| **super + shift + r** | restarts awesome |
| **super + q**| kills focused application |
| **super + s** | shows all the available keybindings |

