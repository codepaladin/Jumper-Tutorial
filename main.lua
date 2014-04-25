-- main.lua

display.setStatusBar( display.HiddenStatusBar )

local Grid = require ("jumper.jumper.grid")
local Pathfinder = require ("jumper.jumper.pathfinder")


local map = {}       -- table representing each grid position 
local walkable = 0   -- used by Jumper to mark obstacles
local startx = 0     -- start x grid coordinate
local starty = 0     -- start y grid coordinate
local endx = 0       -- end x grid coordinate
local endy = 0       -- end y grid coordinate 

local bg = display.newRect( display.screenOriginX,
                            display.screenOriginY, 
                            display.actualContentWidth, 
                            display.actualContentHeight)
 
bg.x = display.contentCenterX
bg.y = display.contentCenterY
bg:setFillColor( 000/255, 168/255, 254/255 )


-- draw a tile map to the screen
-- populate the map table
function drawGrid()
   for row = 1, 10 do
      local gridRow = {}
      for col = 1, 10 do
         -- draw a tile
         local tile = display.newRect((col * 50) - 25, (row * 50) - 25, 48, 48)
         
         -- make some tiles un-walkable
         if ((row == 4 or row == 6) and (col >2 and col < 9))  then
            tile.alpha = 1
            gridRow[col] = 1    
         else
            tile.alpha = .5
            gridRow[col] = 0
         end
         
         -- set the tile's pixel coordinates
         tile.xyPixelCoordinate = {x=tile.x, y=tile.y}
         -- set the tile's grid coordinates
         tile.xyGridCoordinate = {x=col, y=row}
        

         -- draw the start position
         if(row  == 3 and col == 4) then drawStart(tile.xyPixelCoordinate, tile.xyGridCoordinate) end

         -- draw the end position
         if(row  == 5 and col == 6) then drawEnd(tile.xyPixelCoordinate, tile.xyGridCoordinate) end
      end
      -- add gridRow table to the map table
      map[row] = gridRow
   end
end


-- draw start position by using the pixel coordinates
-- set the startx and starty grid coordinates
function drawStart(xyPixelCoordinate, xyGridCoordinate)
   local myText = display.newText( "A", xyPixelCoordinate.x, xyPixelCoordinate.y, native.systemFont, 34 )
   myText:setFillColor( 255, 255, 255 )
   startx = xyGridCoordinate.x
   starty = xyGridCoordinate.y
end

-- draw end position by using the pixel coordinates
-- set the endx and endy grid coordinates
function drawEnd(xyPixelCoordinate, xyGridCoordinate)
   local myText = display.newText( "B", xyPixelCoordinate.x, xyPixelCoordinate.y, native.systemFont, 34 )
   myText:setFillColor(255, 255, 255 )
   endx = xyGridCoordinate.x
   endy = xyGridCoordinate.y
end

-- find the path from point A to point B
function getPath()
   -- create a Jumper Grid object by passing in our map table
   local grid = Grid(map)

   -- Creates a pathfinder object using Jump Point Search
   local pather = Pathfinder(grid, 'JPS', walkable)
   pather:setMode("ORTHOGONAL") 
   
   -- Calculates the path, and its length
   local path = pather:getPath(startx,starty, endx,endy)

   if path then
    for node, count in path:nodes() do
      print(('Step: %d - x: %d - y: %d'):format(count, node:getX(), node:getY()))
    end
 end
end


drawGrid()
getPath()


