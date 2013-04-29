require('slam')

git,git_count = "missing git.lua",0
pcall( function() return require("git") end );

music = love.audio.newSource('music.mp3', 'stream')
music:setLooping(true)
music:setVolume(2)
love.audio.play(music)

images = {}

colors = {}
colors.white = {196,207,161}
colors.light_gray = {139,149,109}
colors.dark_gray = {77,83,60}
colors.black = {31,31,31}
colors.reset = {255,255,255}
love.graphics.setBackgroundColor(colors.black)
gd = require('gamedata')

fonts = {}
fonts.large = love.graphics.newFont("Elementary_Gothic_Bookhand.ttf",24)
fonts.small = love.graphics.newFont("Elementary_Gothic_Bookhand.ttf",10)
fonts.tiny = love.graphics.newFont("Elementary_Gothic_Bookhand.ttf",8)

intro_img = love.graphics.newImage("intro.png")
intro_img:setFilter("nearest","nearest")
places_img = {}
places = {}
for i,v in pairs(gd.places) do
  places_img[i] = love.graphics.newImage(i..".png")
  places_img[i]:setFilter("nearest","nearest")
  table.insert(places,i)
end

function love.load()
  state = "intro"
  ship = {}
  ship.day = 30
  ship.anger = 0
  ship.fear = 0
  ship.crew = 20
  ship.cannonballs = 20
  ship.treasure = 10
  ship.grog = 20
  newday()
end

function newday()
  ship.day = ship.day - 1
  local old_place = ship.place
  repeat
  ship.place = places[math.random(#places)]
  until ship.place ~= old_place
end

shortdex = {day = "D",anger = "A",fear = "F",crew = "C",cannonballs = "CB",treasure = "T",grog = "G"}



function love.draw()
  if state == "intro" then
    love.graphics.setColor(colors.reset)
    love.graphics.draw(intro_img,0,0,0,2,2)
    love.graphics.setFont(fonts.large)
    love.graphics.setColor(colors.white)
    love.graphics.printf("Mini Pirates!",0,472,640,"center")
    love.graphics.setFont(fonts.tiny)
    love.graphics.setColor(colors.light_gray)
    love.graphics.printf("By josefnpat 2013 for LD26 - "..
      "GIT: ".. git_count .. " ["..git.."]",0,516,640,"center")
    love.graphics.setFont(fonts.small)
    love.graphics.setColor(colors.white)
    love.graphics.printf("Survive as a pirate captain for 30 days!\nPress any key to start.",0,560,640,"center")
  else
    love.graphics.setColor(colors.reset)
    love.graphics.draw(places_img[ship.place],0,0,0,2,2)
    local s = gd.places[ship.place]
    love.graphics.setFont(fonts.large)
    love.graphics.setColor(colors.light_gray)
    love.graphics.printf(s.name,0,472,640,"center")
    love.graphics.setFont(fonts.small)
    love.graphics.setColor(colors.dark_gray)
    love.graphics.printf(s.desc,0,516,640,"center")
    love.graphics.setColor(colors.white)
    for i,v in pairs(s.opt) do
      local info = {}
      for j,w in pairs(v.mod) do
        table.insert(info,shortdex[j] .. ": " .. ( w > 0 and "+" or "") .. w)
      end
      love.graphics.print(i..". "..v.desc.." ["..table.concat(info,", ").."]",32,516+20*i)
    end
    love.graphics.setColor(colors.light_gray)
    love.graphics.rectangle("fill",0,622,640,18)
    love.graphics.setColor(colors.black)
    love.graphics.setFont(fonts.tiny)
    love.graphics.printf(string.upper(
      "Days "..ship.day..
      " : Anger "..ship.anger..
      " : Fear "..ship.fear..
      " : Crew "..ship.crew..
      " : Balls "..ship.cannonballs..
      " : Treasure "..ship.treasure..
      " : Grog "..ship.grog
    ),0,622,640,"center")
    
    if gameover then
      love.graphics.setColor(colors.black)
      love.graphics.rectangle("fill",64,128,512,128)
      
      love.graphics.setColor(colors.white)
      love.graphics.setFont(fonts.small)
      love.graphics.printf(gameover,64,128+16,512,"center")
      
      love.graphics.setFont(fonts.tiny)
      love.graphics.setColor(colors.light_gray)
      love.graphics.printf("Press any key to continue.",64,128+96,512,"center")
    end
  end
  love.graphics.setColor(colors.white)
end

function message_overlay(newmsg)
  gameover = newmsg
end

function love.keypressed(key)
  if state == "intro" then
      state = "piratetime!"
  elseif gameover then
    love.load()
    gameover = nil
    state = "intro"
  else
    local s = gd.places[ship.place]
    local k = tonumber(key)
    if k and k >= 1 and k <= #s.opt then
      for i,v in pairs(s.opt[k].mod) do
        ship[i] = ship[i] + v
      end
      
      if ship.anger < 0 then ship.anger = 0 end
      if ship.fear < 0 then ship.fear = 0 end
      
      if ship.treasure == 0 then
        message_overlay("You have no treasure and the crew mutinies.")
      elseif ship.anger >= 10 then
        message_overlay("You've pushed the crew too far and they mutiny.")
      elseif ship.fear >= 10 then
        message_overlay("You are too fearsome, and the crew abandons ship.")
      elseif ship.crew <= 0 then
        message_overlay("You have no crew to guide the ship and you sink.")
      elseif ship.cannonballs < 0 then
        message_overlay("You run out of cannon balls mid-battle and are destroyed.")
      elseif ship.grog <= 0 then
        message_overlay("You run out of grog and the crew mutinies.")
      elseif ship.day <= 0 then
        message_overlay("Congratulations! Your legacy shall live on in history!\nTreasure:  "..ship.treasure)
      else
        newday()
      end
    end
  end
end
