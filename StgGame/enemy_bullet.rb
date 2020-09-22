#敵が弾を撃つ間隔を指定するメソッド
def shot_rate(rate)
  if @shot_counter >= BULLET_RATE * rate
    @shot_counter = 0
    return true
  elsif @shot_counter < BULLET_RATE * rate
    @shot_counter +=1
    return false
  end
end
#弾幕パターンに関するメソッド
def enemy_shot(danmaku_pattern)
  case danmaku_pattern
  when 1  #直線軌道
   
    # if shot_rate(10)
    #   @bullets.push(Bullet.new(@bullet_img, x + @image.width / 2 - @bullet_img.width / 2 , y + @image.height / 2 - @bullet_img.height / 2, @danmaku_pattern))
    # end
  when 2 #sin起動
    if shot_rate(10)
      for num in 1..9  
        @bullets.push(Bullet.new(@bullet_img, x + @image.width / 2 - @bullet_img.width / 2 , y + @image.height / 2 - @bullet_img.height / 2, @danmaku_pattern, theta = num * 40))
        @sample.play(0.01)
      end
    end
  when 3 #ぐるぐる起動
    if shot_rate(0.1)
      @bullets.push(Bullet.new(@bullet_img, x + @image.width / 2 - @bullet_img.width / 2 , y + @image.height / 2 - @bullet_img.height / 2, @danmaku_pattern, theta = $timer))
      @sample.play(0.01)
    end
  when 4 #3 way
    if shot_rate(0.1)
      angle = Gosu.angle(center_x, center_y, @player.x, @player.y)
      @bullets.push(Bullet.new(@bullet_img, x + @image.width / 2 - @bullet_img.width / 2 , y + @image.height / 2 - @bullet_img.height / 2, @danmaku_pattern, theta = angle))
      @bullets.push(Bullet.new(@bullet_img, x + @image.width / 2 - @bullet_img.width / 2 , y + @image.height / 2 - @bullet_img.height / 2, @danmaku_pattern, theta = angle + 30))
      @bullets.push(Bullet.new(@bullet_img, x + @image.width / 2 - @bullet_img.width / 2 , y + @image.height / 2 - @bullet_img.height / 2, @danmaku_pattern, theta = angle - 30))
      @sample.play(0.01)
    end
  end
end
#弾の更新
def bullet_update
  if @bullets != nil
    @bullets.each do |bullet| 
      bullet.update
    end 
    @bullets.delete_if do |bullet| 
      bullet.y > 480
      bullet.y < 0
    end
  end
end

