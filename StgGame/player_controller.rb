def player_controller
  if Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_LEFT
    if @x -30 > 0
      @x -= 5
    end
  end
  if Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_RIGHT
    if @x + @image.width - 50 < 640
      @x += 5
    end
  end
  if Gosu.button_down? Gosu::KB_UP or Gosu::button_down? Gosu::GP_BUTTON_0
    if 0 < @y -50
      @y -= 5
    end
  end
  if Gosu.button_down? Gosu::KB_DOWN or Gosu::button_down? Gosu::GP_BUTTON_1
    if @y + @image.height - 70 < 480
      @y += 5
    end
  end

  if @shot_counter == BULLET_RATE
    if Gosu.button_down? Gosu::KB_Z
      @bullets.push(Bullet.new(@bullet_img, x - @bullet_img.width / 2 , y - @bullet_img.height / 2, 0)) 
      @sample.play(0.03, 1.5, false)
      @shot_counter = 0
    end
  elsif @shot_counter < BULLET_RATE
    @shot_counter +=1
  end
end