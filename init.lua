glassaddition = {}

dofile(minetest.get_modpath("glassaddition").."/_config.txt")

local variations = glassaddition.color_variations
if variations ~= 9 and
  variations ~= 16 and
  variations ~= 25 and
  variations ~= 64 and
  variations ~= 81 and
  variations ~= 144 and
  variations ~= 264 and
  variations ~= 289 then
    variations = 64
end

glassaddition.colors = {
  red = {r=255,g=0,b=0},
  pink = {r=255,g=0,b=127},
  magenta = {r=255,g=0,b=255},
  purple = {r=192,g=0,b=255},
  violet = {r=128,g=0,b=255},
  violet_blue = {r=85,g=0,b=255},
  blue = {r=0,g=0,b=255},
  blue_cyan = {r=0,g=128,b=255},
  cyan = {r=0,g=255,b=255},
  cyan_aqua = {r=0,g=255,b=192},
  aqua = {r=0,g=255,b=128},
  green = {r=0,g=255,b=0},
  lime = {r=128,g=255,b=0},
  lime_yellow = {r=192,g=225,b=0},
  yellow = {r=255,g=255,b=0},
  golden_yellow = {r=255,g=190,b=0},
  yellow_orange = {r=255,g=162,b=0},
  orange = {r=255,g=128,b=0},
  orange_red = {r=255,g=64,b=0}
}

glassaddition.colors_cmy = {
  red = {c=0,m=100,y=100},
  pink = {c=0,m=100,y=50},
  magenta = {c=0,m=100,y=0},
  purple = {c=20,m=100,y=0},
  violet = {c=50,m=100,y=0},
  violet_blue = {c=67,m=100,y=0},
  blue = {c=100,m=100,y=0},
  blue_cyan = {c=100,m=50,y=0},
  cyan = {c=100,m=0,y=0},
  cyan_aqua = {c=100,m=0,y=25},
  aqua = {c=100,m=0,y=50},
  green = {c=100,m=0,y=100},
  lime = {c=50,m=0,y=100},
  lime_yellow = {c=25,m=0,y=100},
  yellow = {c=0,m=0,y=100},
  golden_yellow = {c=0,m=25,y=100},
  yellow_orange = {c=0,m=36,y=100},
  orange = {c=0,m=50,y=100},
  orange_red = {c=0,m=75,y=100}
}

glassaddition.grayscale = {
  white = {r=255,g=255,b=255},
  light_grey_1 = {r=232,g=232,b=232},
  light_grey_2 = {r=209,g=209,b=209},
  light_grey_3 = {r=185,g=185,b=185},
  light_grey_4 = {r=162,g=162,b=162},
  grey_1 = {r=139,g=139,b=139},
  grey_2 = {r=115,g=115,b=115},
  dark_grey_1 = {r=93,g=93,b=93},
  dark_grey_2 = {r=70,g=70,b=70},
  dark_grey_3 = {r=46,g=46,b=46},
  dark_grey_4 = {r=23,g=23,b=23},
  black = {r=0,g=0,b=0}
}

glassaddition.variations = {
  { 5, groups = {_289=1, _256=1, _144=1, _64=1, _81=1} },
  { 12, groups = {_289=1, _256=1, _144=1, _16=1, _25=1} },
  { 17, groups = {_289=1,_256=1, _144=1, _64=1, _81=1, _9=1} },
  { 24, groups = {_289=1, _256=1} },
  { 29, groups = {_289=1, _256=1, _144=1, _64=1, _81=1, _25=1} },
  { 35, groups = {_289=1, _256=1, _16=1} },
  { 41, groups = {_289=1, _256=1, _144=1, _64=1, _81=1} },
  { 47, groups = {_289=1, _256=1, _144=1} },
  { 50, groups = {_289=1, _81=1, _25=1, _9=1} },
  { 53, groups = {_289=1, _256=1, _144=1, _64=1} },
  { 59, groups = {_289=1, _256=1, _144=1, _16=1, _81=1} },
  { 65, groups = {_289=1, _256=1, _64=1} },
  { 71, groups = {_289=1, _256=1, _144=1, _81=1, _25=1} },
  { 76, groups = {_289=1, _256=1, _64=1} },
  { 82, groups = {_289=1, _256=1, _144=1, _16=1, _81=1, _9=1} },
  { 88, groups = {_289=1, _256=1, _144=1, _64=1, _25=1} },
  { 94, groups = {_289=1, _256=1, _144=1, _81=1} }
}

function glassaddition.get_variations()
  local t = {}
  for i, v in ipairs(glassaddition.variations) do
    if v.groups["_"..variations] then
      table.insert(t,v[1])
    end
  end
  return t
end

local function upper_first(text)
  local firstletter = string.sub(text, 1,1)
  local therest = string.sub(text, 2)
  return firstletter:upper()..therest
end

local function split_string(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  
  local t = {}
  if string.find(inputstr, sep) then
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
      table.insert(t, str)
    end
  else
    table.insert(t, inputstr)
  end
  
  return t
end

local function Description(text)
  local words = split_string(text,"_")
  local t = {}
  for _, word in ipairs(words) do
    table.insert(t,upper_first(word))
  end
  return table.concat(t," ")
end

local function finish_texture(texture, type)
  if type == "glass" then
    if glassaddition.enable_detail and not glassaddition.opaque then
      return { texture.."^[opacity:190", texture.."^[mask:"..type.."_detail_mask.png" }
    elseif not glassaddition.enable_detail and glassaddition.opaque then
      return { texture.."^[opacity:255", texture.."^[mask:"..type.."_opaque_mask.png" }
    elseif glassaddition.enable_detail and glassaddition.opaque then
      return { texture.."^[opacity:255", texture.."^[mask:"..type.."_opaque_detail_mask.png" }
    elseif not glassaddition.enable_detail and not glassaddition.opaque then
      return { texture.."^[opacity:190", texture.."^[mask:"..type.."_mask.png" }
    end
  elseif type == "pane" then
    if glassaddition.enable_detail and not glassaddition.opaque then
      return  { texture.."^[mask:"..type.."_detail_mask.png", "", texture.."^[opacity:190" }
    elseif not glassaddition.enable_detail and glassaddition.opaque then
      return { texture.."^[mask:"..type.."_opaque_mask.png", "", texture.."^[opacity:255" }
    elseif glassaddition.enable_detail and glassaddition.opaque then
      return { texture.."^[mask:"..type.."_opaque_detail_mask.png", "", texture.."^[opacity:255" }
    elseif not glassaddition.enable_detail and not glassaddition.opaque then
      return { texture.."^[mask:"..type.."_mask.png", "", texture.."^[opacity:190" }
    end
  end
end

local function register_craft(baseitem, inputitem, output, color, index)
  local colors = {
    white = {"dye:white",baseitem},
    red = {"dye:red",baseitem},
    pink = {"dye:pink",baseitem},
    magenta = {"dye:magenta",baseitem},
    purple = {"dye:red","dye:violet",baseitem},
    violet = {"dye:violet",baseitem},
    violet_blue = {"dye:violet","dye:blue",baseitem},
    blue = {"dye:blue",baseitem},
    blue_cyan = {"dye:blue","dye:cyan",baseitem},
    cyan = {"dye:cyan",baseitem},
    cyan_aqua = {"dye:blue","dye:blue","dye:green",baseitem},
    aqua = {"dye:blue","dye:green",baseitem},
    green = {"dye:green",baseitem},
    lime = {"dye:green","dye:yellow",baseitem},
    lime_yellow = {"dye:green","dye:yellow","dye:yellow",baseitem},
    yellow = {"dye:yellow",baseitem},
    golden_yellow = {"dye:yellow","dye:yellow","dye:orange",baseitem},
    yellow_orange = {"dye:yellow","dye:orange",baseitem},
    orange = {"dye:orange",baseitem},
    orange_red = {"dye:orange","dye:red",baseitem}
  }
  
  local input
  if index == 1 then
    input = colors[color]
  else
    input = inputitem
  end
  
  minetest.register_craft({
    type = "shapeless",
    output = output,
    input = input
  })
end

local index = 1
for color, rgb in pairs(glassaddition.colors) do
  for wi, white in ipairs(glassaddition.get_variations()) do
    for bi, black in ipairs(glassaddition.get_variations()) do
      local colorstring = minetest.rgba(rgb.r,rgb.g,rgb.b)
      local texture = "blank.png^[colorize:"..colorstring..":255^white_"..white..".png^black_"..black..".png"
      
      minetest.register_node("glassaddition:"..color.."_"..index, {
        description = Description(color.."_"..index.."_glass"),
        drawtype = "glasslike_framed",
        paramtype = "light",
        --tiles = {texture.."^[opacity:190", texture.."^[opacity:120"},
        tiles = finish_texture(texture, "glass"),
        use_texture_alpha = true,
        light_propagates = true,
        groups = {cracky=3,oddly_breakable_by_hand=3},
        sounds = default.node_sound_glass_defaults(),
      })
      
      minetest.register_alias("g_"..color.."_"..index, "glassaddition:"..color.."_"..index)
	  
      --current / maximum = percentage
      local cmy = glassaddition.colors_cmy[color]
      local max = 0.125
      colorizer.register_craft({
        input = "default:glass",
        output = "glassaddition:"..color.."_"..index,
        ink_usage = {
          white = 1 * max,
          black = (black / variations) * max,
          magenta = (cmy.m / 100) * max,
          yellow = (cmy.y / 100) * max,
          cyan = (cmy.c / 100) * max
        }
      })
      
      xpanes.register_pane(color.."_"..index.."_glass_pane", {
        description = Description(color.."_"..index.."_glass_pane"),
        --textures = {texture.."^[mask:pane_mask.png", "" ,texture.."^[opacity:190"},
        textures = finish_texture(texture, "pane"),
        inventory_image = texture.."^[mask:pane_inv_mask.png",
        use_texture_alpha = true,
        sounds = default.node_sound_glass_defaults(),
        groups = {snappy=2, cracky=3, oddly_breakable_by_hand=3},
        recipe = {{"glassaddition:"..color.."_"..index}}
      })
      
      minetest.register_alias("gp_"..color.."_"..index, "xpanes:"..color.."_"..index.."_glass_pane")
	  
      --current / maximum = percentage
      local cmy = glassaddition.colors_cmy[color]
      local max = 0.125
      colorizer.register_craft({
        input = "xpanes:pane_flat",
        output = "glassaddition:"..color.."_"..index.."_glass_pane",
        ink_usage = {
          white = 1 * max,
          black = (black / variations) * max,
          magenta = (cmy.m / 100) * max,
          yellow = (cmy.y / 100) * max,
          cyan = (cmy.c / 100) * max
        }
      })
      
      index = index + 1
    end
  end
  index = 1
end

for color, rgb in pairs(glassaddition.grayscale) do
  local colorstring = minetest.rgba(rgb.r,rgb.g,rgb.b)
  local texture = "blank.png^[colorize:"..colorstring..":255"
  
  minetest.register_node("glassaddition:"..color, {
    description = Description(color.."_glass"),
    drawtype = "glasslike_framed",
    paramtype = "light",
    --tiles = {texture.."^[opacity:190", texture.."^[opacity:120"},
    tiles = finish_texture(texture, "glass"),
    use_texture_alpha = true,
    light_propagates = true,
    groups = {cracky=3,oddly_breakable_by_hand=3},
    sounds = default.node_sound_glass_defaults()
  })
  
  minetest.register_alias("g_"..color, "glassaddition:"..color)
  
  --current / maximum = percentage
  local max = 0.125
  colorizer.register_craft({
	input = "default:glass",
	output = "glassaddition:"..color,
	ink_usage = {
	  white = 1 * max,
	  black = (rgb.r / 12) * max,
	  magenta = 0,
	  yellow = 0,
	  cyan = 0,
	}
  })
  
  xpanes.register_pane(color.."_glass_pane", {
    description = Description(color.."_glass_pane"),
    --textures = {texture.."^[mask:pane_mask.png", "", texture.."^[opacity:190"},
    textures = finish_texture(texture, "pane"),
    inventory_image = texture.."^[mask:pane_inv_mask.png",
    use_texture_alpha = true,
    sounds = default.node_sound_glass_defaults(),
    groups = {snappy=2, cracky=3, oddly_breakable_by_hand=3},
    recipe = {{"glassaddition:"..color}}
  })
  
  minetest.register_alias("gp_"..color, "xpanes:"..color.."_glass_pane")
  
  --current / maximum = percentage
  local max = 0.125
  colorizer.register_craft({
	input = "xpanes:pane_flat",
	output = "glassaddition:"..color.."_glass_pane",
	ink_usage = {
	  white = 1 * max,
	  black = (rgb.r / 12) * max,
	  magenta = 0,
	  yellow = 0,
	  cyan = 0,
	}
  })
end