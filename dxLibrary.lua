local ssX,ssY = guiGetScreenSize();
local temp = false
local letra = ""
tempText = {}

function dxDrawButton(text,posX,posY,sizeX,sizeY,color,font,textScale,image)
	if not (text and posX and posY and sizeX and sizeY and color and font and textScale) then
		return false
	end

	local self = {text=text or "",
				  posX=posX or 0,
				  posY=posY or 0,
				  sizeX=sizeX or 100,
				  sizeY=sizeY or 50,
				  color=color or tocolor(255,255,255,255),
				  font=font or "default",
				  textScale=textScale or 1,
				  image=image or false,
				  visible=true}

	if not image then
		dxDrawRectangle ( self.posX,self.posY,self.sizeX,self.sizeY,self.color)
		dxDrawEmptyRectangle(self.posX,self.posY,self.sizeX,self.sizeY,tocolor(0,0,0,30),2,false)
		if not isCI(self.posX,self.posY,self.sizeX,self.sizeY) then
			dxDrawRectangle ( self.posX,self.posY,self.sizeX,self.sizeY,tocolor(0,0,0,50))
		end
	else
		dxDrawImage (self.posX,self.posY,self.sizeX,self.sizeY, self.image, 0, 0, 0, self.color )
	end
	local fontWidth = dxGetTextWidth ( self.text, self.textScale, self.font )
	local fontHeight = dxGetFontHeight ( self.textScale, self.font )
	local x = (self.posX+(self.sizeX/2)) - ((fontWidth)/2)
	local y = (self.posY+(self.sizeY/2)) - ((fontHeight)/2)

	dxDrawText ( self.text, x+1, y+1,self.sizeX,self.sizeY, tocolor(0,0,0,100), self.textScale, self.font)
	dxDrawText ( self.text, x, y,self.sizeX,self.sizeY, tocolor(255,255,255,255), self.textScale, self.font)

	local isCursorInside =  function()
								if isCI(self.posX,self.posY,self.sizeX,self.sizeY) then
									return true
								end
								return false
							end
	local isClicked =   function ()
							if isCI(self.posX,self.posY,self.sizeX,self.sizeY) and temp and self.visible then
								temp = false
								return true
							end
							return false									
						end
	local isVisible = function () return self.visible end
	local setVisible = function (v) self.visible = v end

	return {
		isCursorInside = isCursorInside,
		isClicked = isClicked,
		isVisible = isVisible,
		setVisible = setVisible
	}
end

function dxDrawEdit(posX,posY,sizeX,sizeY,text,color,font,textScale,alineado,isMasked,limit,image,icon)
	if not (text and posX and posY and sizeX and sizeY and color and font and textScale) then
		return false
	end
	local self = {text=text or "",
				  posX=posX or 0,
				  posY=posY or 0,
				  sizeX=sizeX or 100,
				  sizeY=sizeY or 50,
				  color=color or tocolor(255,255,255,255),
				  font=font or "default",
				  textScale=textScale or 1,
				  alineado = alineado or "left",
				  isMasked = isMasked or false,	
				  limit = limit or 32,			  
				  image=image or false,
				  icon= icon or false,
				  visible=true}
	local hash = self.posX*self.posY*self.sizeX*self.sizeY
	local isActive = false
	if not tempText[hash] then
		tempText[hash] = self.text
	end
	--Render background
	if not image then
		dxDrawRectangle ( self.posX,self.posY,self.sizeX,self.sizeY,tocolor(230,230,230,255))
		dxDrawEmptyRectangle(self.posX,self.posY,self.sizeX,self.sizeY,tocolor(0,0,0,30),2,false)
	else
		dxDrawImage (self.posX,self.posY,self.sizeX,self.sizeY, self.image, 0, 0, 0, self.color )
	end

	if isCI(self.posX,self.posY,self.sizeX,self.sizeY) and temp and self.visible then
		isActive = true
		addEventHandler("onClientCharacter", getRootElement(),character)
		temp = false
	elseif not isCI(self.posX,self.posY,self.sizeX,self.sizeY) and temp and self.visible and isActive then
		isActive = false
		temp = false
		removeEventHandler("onClientCharacter", getRootElement(),character)
	end

	if letra ~= "" then
		if letra == "backspace" then
			tempText[hash] = string.sub(tempText[hash], 0, #tempText[hash]-1) 
		else
			if self.limit < #tempText[hash] then
				outputChatBox(tempText[hash]..letra)
				tempText[hash] = tempText[hash]..letra
				letra = ""
			end
		end
	end

	local getText = function () return tempText[hash] end

	if isMasked then
		tempText[hash] = string.rep( '*', #(tempText[hash]) )
	end

	local fontHeight = dxGetFontHeight ( self.textScale, self.font )
	local y = (self.posY+(self.sizeY/2)) - ((fontHeight)/2)

	--Render Data Inside
	if icon then
		dxDrawImage (self.posX,self.posY,self.sizeY,self.sizeY, self.icon, 0, 0, 0, self.color )
		dxDrawText ( tempText, self.posX+self.sizeY+4, y+1,self.sizeX,self.sizeY, tocolor(0,0,0,100), self.textScale, self.font)
		dxDrawText ( tempText, self.posX+self.sizeY+3, y,self.sizeX,self.sizeY, self.color, self.textScale, self.font)
	else
		if self.alineado == "center" then
			local fontWidth = dxGetTextWidth ( tempText[hash], self.textScale, self.font )
			local x = (self.posX+(self.sizeX/2)) - ((fontWidth)/2)

			dxDrawText ( tempText[hash], x+1, y+1,self.sizeX,self.sizeY, tocolor(0,0,0,100), self.textScale, self.font)
			dxDrawText ( tempText[hash], x, y,self.sizeX,self.sizeY, self.color, self.textScale, self.font)
		else
			dxDrawText ( tempText[hash], self.posX+4, y+1,self.sizeX,self.sizeY, tocolor(0,0,0,100), self.textScale, self.font)
			dxDrawText ( tempText[hash], self.posX+3, y,self.sizeX,self.sizeY, self.color, self.textScale, self.font)
		end
	end
	local isCursorInside =  function ()
								if isCI(self.posX,self.posY,self.sizeX,self.sizeY) then
									return true
								end
								return false
							end
	local isVisible = function () return self.visible end
	local setVisible = function (v) self.visible = v; if (not v) then isActive = v end; end

	return {
		isCursorInside = isCursorInside,
		isVisible = isVisible,
		setVisible = setVisible,
		getText = getText
	}
end

function isCI(pX,pY,sX,sY)
	if isCursorShowing() then
		local cX,cY,_,_,_ = getCursorPosition()
		if cX and cY then
			if cX >= pX/ssX and cX <= (pX+sX)/ssX and cY >= pY/ssY and cY <= (pY+sY)/ssY then
		        return true
		    end
		end
	end
    return false
end

    
addEventHandler("onClientClick", getRootElement(),
function(button, state)
	if (button == "left" and state == "down") then
		temp = true
		setTimer(function() temp = false end,50,1);
	end
end)

function character(c)
	if c~=" " then --if the character is a space
		letra = c
	end
end

--Usefull
--Type dxDrawCircle( 500, 200, 50, 3, -1, 90, 450 )
function dxDrawCircle( posX, posY, radius, width, angleAmount, startAngle, stopAngle, color, postGUI )
	if ( type( posX ) ~= "number" ) or ( type( posY ) ~= "number" ) then
		return false
	end
 
	radius = type( radius ) == "number" and radius or 50
	width = type( width ) == "number" and width or 5
	angleAmount = type( angleAmount ) == "number" and angleAmount or 1
	startAngle = type( startAngle ) == "number" and startAngle or 0
	stopAngle = type( stopAngle ) == "number" and stopAngle or 360
	color = color or tocolor( 255, 255, 255, 200 )
	postGUI = type( postGUI ) == "boolean" and postGUI or false
 
	if ( stopAngle < startAngle ) then
		local tempAngle = stopAngle
		stopAngle = startAngle
		startAngle = tempAngle
	end

	if ( angleAmount < 0 ) then
		for i = stopAngle, startAngle, angleAmount do
			local startX = -math.cos( math.rad( math.abs(i) ) ) * ( radius - width )
			local startY = -math.sin( math.rad( math.abs(i) ) ) * ( radius - width )
			local endX = -math.cos( math.rad( math.abs(i) ) ) * ( radius + width )
			local endY = -math.sin( math.rad( math.abs(i) ) ) * ( radius + width )
	 
			dxDrawLine( startX + posX, startY + posY, endX + posX, endY + posY, color, width, postGUI )
		end
 	elseif ( angleAmount > 0 ) then
		for i = startAngle, stopAngle, angleAmount do
			local startX = math.cos( math.rad( i ) ) * ( radius - width )
			local startY = math.sin( math.rad( i ) ) * ( radius - width )
			local endX = math.cos( math.rad( i ) ) * ( radius + width )
			local endY = math.sin( math.rad( i ) ) * ( radius + width )
	 
			dxDrawLine( startX + posX, startY + posY, endX + posX, endY + posY, color, width, postGUI )
		end
	else 
		return false
 	end
	return true
end

function dxDrawEmptyRectangle(startX, startY, endX, endY, color, width, postGUI)
	dxDrawLine ( startX, startY, startX+endX, startY, color, width, postGUI )
	dxDrawLine ( startX, startY, startX, startY+endY, color, width, postGUI )
	dxDrawLine ( startX, startY+endY, startX+endX, startY+endY,  color, width, postGUI )
	dxDrawLine ( startX+endX, startY, startX+endX, startY+endY, color, width, postGUI )
end

--[[
Para enmascarar un string
local str = string.rep( '*', #str )

Para quitar el codigo de colores a un string
local str = string.gsub(str, "#%x%x%x%x%x%x", "")  

Para usar sonidos de mta
playSoundFrontEnd ( 44 )
]]

function getPlayer(playerPart)
	if playerPart then
		local pl = getPlayerFromName(playerPart)
		if isElement(pl) then
			return pl
        end
    end
    for i,v in ipairs (getElementsByType ("player")) do
		if (string.find(getPlayerName(v):lower(),playerPart:lower())) then
			return v
		elseif (string.find(string.gsub(getPlayerName(v),"#%x%x%x%x%x%x",""):lower(),playerPart:lower())) then
			return v
		end
	end
	return false
end

