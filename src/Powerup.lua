Powerup = Class{}

local POWERUP_DY = 50

function Powerup:init(type, x, y)
    -- simple positional and dimensional variables
    self.width = 16
    self.height = 16
    self.y = y
    self.x = x

    -- Type of powerup, determines effect and look
    -- 9 = +2 balls
    self.type = type
end

--[[
    Expects an argument with a bounding box, be that a paddle or a brick,
    and returns true if the bounding boxes of this and the argument overlap.
]]
function Powerup:collides(target)
    -- first, check to see if the left edge of either is farther to the right
    -- than the right edge of the other
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    -- then check to see if the bottom edge of either is higher than the top
    -- edge of the other
    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end 

    -- if the above aren't true, they're overlapping
    return true
end

function Powerup:update(dt)
    self.y = self.y + POWERUP_DY * dt

    if self.y > VIRTUAL_HEIGHT then
        return true -- tells Playstate to remove this powerup from table
    end

    return false
end

function Powerup:render()
    love.graphics.draw(
        gTextures['main'],
        gFrames['powerups'][self.type],
        self.x,
        self.y
    )
end
