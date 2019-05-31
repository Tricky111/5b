display.setDefault( "background", 100/255, 200/255, 100/255 )


local physics = require( "physics" )


physics.start()


physics.setGravity( 0, 25 ) -- ( x, y )



local Ball = display.newImageRect( "Ball.png", 250, 250 )



Ball.x = display.contentCenterX



Ball.y = 100



Ball.id = "Ball"



physics.addBody( Ball, "dynamic", { 



    density = 3.0, 



    friction = 0.5, 



    bounce = 210489325238959 -- Its Insane But It Works 



    } )



local PongPong = display.newImageRect( "TheGuy.png", 500, 100 )



PongPong.x = display.contentCenterX



PongPong.y = 1500



PongPong.id = "the character"



physics.addBody( PongPong, "static", { 



    density = 3.0, 



    friction = 0.5, 



    bounce = 5



    } )

PongPong.isFixedRotation = true





math.randomseed = (os.time())

local timeLimit = 30

local currentTime = 0

local timerUpTimer

local screenText = display.newText( "Ball Bounce Game", 1000, 100, native.systemFont, 105)

local currentTimeText = display.newText(currentTime, 160, 200, native.systemFontBold, 200)

currentTimeText:setTextColor(255,0,0)


local function timerUp()
    currentTime = currentTime + 1
    currentTimeText.text = currentTime
    if currentTime >= timeLimit then 
        timer.cancel(timerUpTimer)
        screenText.text = "Winner!"
        Runtime:removeEventListener( "enterFrame", checkBallPosition )
        Ball:removeSelf()
        Ball = nil
          PongPong:removeSelf()
        PongPong = nil

    end
end
timerUpTimer = timer.performWithDelay(1000, timerUp, 0)








local audio1 = audio.loadSound( "QWERTY.mp3" )

audio.play(audio1)





local theGround = display.newImageRect( "Wall.png", 100, 1570 )



theGround.x = - 250



theGround.y = 750



theGround.id = "the ground"



physics.addBody( theGround, "static", { 



    friction = 0.5, 



    bounce = 2



    } )




local theGround = display.newImageRect( "Wall.png", 100, 1570 )



theGround.x =  2300



theGround.y = 750



theGround.id = "the ground"



physics.addBody( theGround, "static", { 



    friction = 0.5, 



    bounce = 2



    } )


local theGround = display.newImageRect( "Wall.png", 5000000, 100 )



theGround.x =  900



theGround.y = 1



theGround.id = "the ground"



physics.addBody( theGround, "static", { 



    friction = 0.5, 



    bounce = 2



    } )



function checkBallPosition( event )





    if Ball.y > display.contentHeight + 500 then
screenText.text = "Game Over"

        timer.cancel(timerUpTimer)

        Runtime:removeEventListener( "enterFrame", checkBallPosition )

  

        Ball:removeSelf()

		Ball = nil

		PongPong:removeSelf()

		PongPong = nil

    end
end


local function PongPongtouch ( event )
    local PongPongtouched = event.target



        if (event.phase == "began") then
            display.getCurrentStage():setFocus( PongPongtouched )


            PongPongtouched.startMoveX = PongPongtouched.x



        elseif (event.phase == "moved") then
                 PongPongtouched.x = (event.x - event.xStart) + PongPongtouched.startMoveX
 

        elseif event.phase == "ended" or event.phase == "cancelled"  then
                display.getCurrentStage():setFocus( nil )
                PongPongtouched.x = PongPong.x
             
        end 
                return true
end
	
Runtime:addEventListener( "enterFrame", checkBallPosition )

PongPong:addEventListener("touch", PongPongtouch )