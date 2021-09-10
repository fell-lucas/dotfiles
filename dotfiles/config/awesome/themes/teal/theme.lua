local gears = require("gears")
local lain  = require("lain")
local volume_widget = require('awesome-wm-widgets.volume-widget.volume')
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi

local math, string, os = math, string, os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

-- Nord theme colorscheme
local colors                                    = {}
local fontspr                                   = 1.0

colors.bg                                       = "#012531"
colors.bglighter                                = "#043546"
colors.fg                                       = "#d3b6a8"
colors.cyan                                     = "#87DFEB"
colors.red                                      = "#d91041"
colors.bghover                                  = "#043546"
colors.brown                                    = "#844f68"
--
---- Aurora Nord Scheme
colors.alpha_zero                               = "#00000000"
colors.orange                                   = "#F3cbb8"
colors.yellow                                   = "#fefecf"
colors.pink                                     = "#fedfef"

---- Frost
colors.frost                                    = {}
colors.frost.darkest                            = "#222529"
colors.frost.lightest                           = colors.fg
colors.frost.aqua                               = "#41464c"
colors.frost.light_green                        = "#8FBCBB"

---- Snow Storm
colors.light                                    = {}
colors.light.lighter                            = "#ECEFF4"
colors.light.darker                             = "#D8DEE9"
colors.light.medium                             = "#E5E9F0"
--
---- Polar night
colors.polar                                    = {}
colors.polar.lightest                           = "#35383f"
colors.polar.darker                             = "#3f434c"
colors.polar.lighter                            = "#434C5E"

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/teal"

-- Sets up the wallpaper 
theme.wallpaper                                 = theme.dir .. "/wallpaper3.jpg"

-- Font
theme.font                                      = "JetBrainsMono Nerd Font 11"
theme.taglist_font                              = "JetBrainsMono Nerd Font 15"

-- Gaps between windows
-- Otherwise you can change them by using:
--      altkey + ctrl + j           = Increment gaps
--      altkey + ctrl + h           = Decrement gaps
theme.useless_gap                               = 3

--  Foreground variables  --
theme.fg_normal                                 = colors.fg -- White
theme.fg_focus                                  = colors.cyan
theme.fg_urgent                                 = colors.red
--  Background variables  --
theme.bg_normal                                 = colors.bg
theme.bg_focus                                  = "#043546"
theme.bg_urgent                                 = colors.red

-- Systray background color
theme.bg_systray                	            = colors.bglighter

-- Systray icon spacing 
theme.systray_icon_spacing		        = 10

-- Taglist configuration --
theme.taglist_bg_occupied                       = colors.bglighter
theme.taglist_fg_occupied                       = colors.cyan
theme.taglist_bg_empty                          = colors.bglighter 
theme.taglist_fg_empty                          = colors.fg
theme.taglist_bg_urgent                         = colors.bglighter
theme.taglist_fg_urgent                         = colors.brown
theme.taglist_fg_volatile                       = colors.frost.lightest
theme.taglist_bg_volatile                       = colors.bglighter
-- Colors
theme.taglist_fg_focus                          = colors.red
theme.taglist_bg_focus                          = colors.bglighter
-- Taglist shape, refer to awesome wm documentation if you have 
-- any doubt about this!
theme.taglist_shape                             = gears.shape.rounded_rect

-- Icon spacing between workspace icons 
theme.taglist_spacing				= 2

-- Sets the border to zero
theme.border_width                              = 0

-- If the border is not zero, it'll show 
-- These colors 
theme.border_normal                             = colors.orange 
theme.border_focus                              = colors.cyan
theme.border_marked                             = colors.cyan

-- Titlebar variables, dont care about theme,
-- In this configuration file we wont use it!
theme.titlebar_bg_focus                         = "#3F3F3F"
theme.titlebar_bg_normal                        = "#3F3F3F"
theme.titlebar_bg_focus                         = theme.bg_focus
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = theme.fg_focus

-- Menu variables
theme.menu_height                               = dpi(25)
theme.menu_width                                = dpi(260)

theme.widget_mem                                = theme.dir .. "/icons/mem.png"
theme.widget_cpu                                = theme.dir .. "/icons/cpu.png"

local markup = lain.util.markup
local separators = lain.util.separators
-- Textclock
local clockicon = wibox.widget.imagebox(theme.widget_clock)
local clock = awful.widget.watch("date +' %R %a, %b %d'", 60)

-- Calendar
theme.cal = lain.widget.cal({
    attach_to = { clock },
    notification_preset = {
        font = string.format("Comic Mono %s", 10*fontspr),
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})

function theme.at_screen_connect(s)
    
    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- All tags open with layout 1
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(
        my_table.join(
            awful.button({ }, 1, function () awful.layout.inc( 1) end),
            awful.button({ }, 3, function () awful.layout.inc(-1) end),
            awful.button({ }, 4, function () awful.layout.inc( 1) end),
            awful.button({ }, 5, function () awful.layout.inc(-1) end)
        )
    )
    
    -- Custom rounded background widget
    -- You can modify however you want
    -- Syntax:
    --  round_bg_widget(widget, background_colour)
    function round_bg_widget(widget, bg, fg)
      local widget = wibox.widget {
            
            -- Set up 
            {
                widget,
                -- Margin 
                left   = 10,
                spacing = 20,
                top    = 3,
                bottom = 3,
                right  = 10,
                widget = wibox.container.margin,
            },
            bg         = bg,
            fg         = fg,

            -- Sets the shape 
            shape      = gears.shape.rounded_rect,
            shape_clip = true,
            widget     = wibox.container.background,
        }
		
		return widget
    end
    -- The function ends
    function is_empty(s)
        return s == nil or s == ''
    end

    function add_app(app, text, fg, bg, text2)     
            -- Set up 
        local textWidget = wibox.widget.textbox()
        local widget = wibox.widget {
            {
                {
                    text = text,
                    font = string.format("JetBrainsMono Nerd Font %s", 15*fontspr),
                    widget = textWidget
                },
                -- Margin 
                left   = 10,
                spacing = 20,
                top    = 3,
                bottom = 3,
                right  = 10,
                widget = wibox.container.margin,
            },
            
            bg         = bg,
            fg         = fg,

            -- Sets the shape 
            shape      = gears.shape.rounded_rect,
            shape_clip = true,
            widget     = wibox.container.background,
        }
        -- When pressed the widget, it will
        -- change its color and spawn the app
        widget:connect_signal("button::press",
            function()
                widget.fg = colors.frost.lightest
                if textWidget.text == text2 then
                    textWidget:set_markup(text)
                elseif not is_empty(text2) then 
                    textWidget:set_markup(text2) 
                end
                awful.spawn.with_shell(app)
            end
        )

        -- This function will be called when the button  is 
        -- released
        widget:connect_signal("button::release",
            function()
                widget.fg = fg
            end
        )

        -- When its on hover, it will change its color
        widget:connect_signal("mouse::enter",
            function()
                widget.fg = colors.cyan
            end
        )
        
        widget:connect_signal("mouse::leave",
            function()
                widget.fg = fg
            end
        )
        return widget
    end
    ---------- Simple widget separator ----------
    local sep   = wibox.widget.textbox("  ")
    
    ---------- If you want to change the size of the spacing,
    --         change the font size, instead of 5. Just play with it!
    sep.font    = string.format("Comic Mono %s", 10*fontspr)
    
    local menu = wibox.widget {
            {
                {
                    image  = theme.dir .. "/awesome.png",
                    resize = true,
                    widget = wibox.widget.imagebox
                },
                --Margin 
                left   = 5,
                spacing = 20, 
                right  = 5,
                widget = wibox.container.margin,
            },
            
            bg         = colors.bglighter .. "AF",
            fg         = theme.bg_normal,

            -- Sets the shape 
            shape      = gears.shape.rounded_rect,
            shape_clip = true,
            widget     = wibox.container.background,
        }
    
    -- When pressed the widget, it will
    -- change its color and spawn the menu
    menu:connect_signal("button::press",
        function()
          awful.util.mymainmenu:toggle()
        end
    )

    local appsep= wibox.widget.textbox("  ")
    appsep.font = string.format("Comic Mono %s", 5*fontspr)
    
    -- Systray -- 
    local systray = round_bg_widget(
      wibox.widget.systray(),
      colors.bglighter,
      colors.cyan
    )

    mic = add_app(
        "amixer set Capture toggle",
        "",
        colors.fg,
        colors.bglighter,
        ""
    )
    --
    -- Volume widget
    --
    vol = {
            -- Set up 
            {
                {
                     
                    layout=wibox.layout.fixed.horizontal,
                    {
                        {
                          text="",
                          font=string.format("JetBrainsMono Nerd Font %s",
                                             15*fontspr),
                          widget=wibox.widget.textbox
                        },
                        widget = wibox.container.margin,
                    },
                    {
                        volume_widget{
                            main_color=colors.cyan,
                            widget_type = 'horizontal_bar',
                            bg_color=colors.bg
                        },
                        widget = wibox.container.margin,
                    },
                    widget = wibox.container.background
                },
                -- Margin 
                left   = 10,
                spacing = 20,
                top    = 0,
                bottom = 0,
                right  = 10,
                widget = wibox.container.margin,
            },
            bg         = colors.bglighter,
            fg         = colors.fg,

            -- Sets the shape 
            shape      = gears.shape.rounded_rect,
            shape_clip = true,
            widget     = wibox.container.background,
    }
    

    if s.workarea.width <= 1366 then      
        fontspr = 0.94
        systray = wibox.widget.textbox("")
    end

    -- Creates the wibox 
    s.mywibox = awful.wibar(
      { 
        position = "top",
        screen = s,
        width = s.workarea.width - 20,
        height = dpi(25),
        bg = colors.bg,
        fg = theme.fg_normal,
        border_width = 5,
        border_color = colors.bg,
      }
    )
    
    -- Separates the wibox from the top a little bit,
    -- it you want it in the top, comment this line,
    -- or if you want to change its position, change
    -- its value
    s.mywibox.y = 5
    -- s.mywibox.x = s.mywibox.x - 5
    -- s.mywibox.x = (s.workarea.width)
    
---------------------------------------
--                                    --
--            Widget setup            --
--                                    --
----------------------------------------

    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        expand='none',
        { -- Left widgets
            {
                {
                    awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons),
                    left   = 2,
                    top    = 2,
                    bottom = 2,
                    right  = 2,
                    widget = wibox.container.margin
                },
                shape = gears.shape.rounded_bar,
                bg = colors.bglighter,   
                shape_clip = true,
                shape_border_width = 1,
                shape_border_color = theme.bg_normal,
                widget = wibox.container.background
            },
            appsep,
            {
                {
                    awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons), 
                    widget = wibox.container.margin
                },
                shape = gears.shape.rounded_bar,
                bg = colors.bglighter,   
                shape_clip = true,
                shape_border_width = 1,
                shape_border_color = theme.bg_normal,
                widget = wibox.container.background
            },
            layout = wibox.layout.fixed.horizontal,
        },
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            sep,
            mic,
            sep,
            vol,
            sep,
            -- System time
            
            round_bg_widget(wibox.container.margin(clock,
               dpi(4),
               dpi(8)),
               colors.bglighter,
               colors.frost.lightest
            ),
            appsep,
            round_bg_widget(
               {
                layout = wibox.layout.fixed.horizontal,
                {
                  text = "",
                  font = string.format("JetBrainsMono Nerd Font %s", 12*fontspr),
                  widget = wibox.widget.textbox
                },
                
                awful.widget.keyboardlayout()
                
               },
               colors.bglighter,
               colors.frost.lightest
               
            ),
            appsep,
            round_bg_widget(
               {
                layout = wibox.layout.fixed.horizontal,
                {
                  font = string.format("JetBrainsMono Nerd Font %s", 12*fontspr),
                  widget = wibox.widget.textbox
                },
                
                awful.widget.layoutbox()
                
               },
               colors.bglighter,
               colors.frost.lightest
            ),
            appsep,
            -- Systray 
            systray,
            appsep,
        },
        {
          layout = wibox.layout.fixed.horizontal,
        --   add_app(
        --       "kitty -e nmtui",
        --       "",
        --       colors.yellow,
        --       colors.bglighter
        --   ),
        --   appsep,
        --   add_app(
        --       "kitty -e htop",
        --       "",
        --       colors.cyan,
        --       colors.bglighter
        --   ),
          appsep,
          add_app(
              "shutdown now",
              "",
              colors.red,
              colors.bglighter
          ),
          appsep,
          add_app(
              "reboot",
              "",
              colors.red,
              colors.bglighter
          ),
          appsep,
          add_app(
              "systemctl suspend",
              "",
              colors.red,
              colors.bglighter
          ), 
        }
    }
    awful.screen.padding(screen[s], {top = 10, left = 10,
                                    right = 10, bottom = 10})
end

-- Returns the theme 
return theme
