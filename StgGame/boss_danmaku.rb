require './enemy_bullet'

#弾幕のパターンに関するメソッド
def boss_danmaku(status)
  case status
  when 2 #sin起動
    if shot_rate(10)
      for num in 1..50
        t = num * $timer % 180
        @bullets.push(Bullet.new(@bullet_img, x + @image.width / 2 - @bullet_img.width / 2 , y + @image.height / 2 - @bullet_img.height / 2, @danmaku_pattern = 2, theta = t))
      end
      @sample.play(0.1)
    end
  when 3 #ぐるぐる起動
    if shot_rate(0.5)
      angle = Gosu.angle(center_x, center_y, @player.x, @player.y)
      @bullets.push(Bullet.new(@bullet_img, x + @image.width / 2 - @bullet_img.width / 2 , y + @image.height / 2 - @bullet_img.height / 2, @danmaku_pattern = 5, theta = angle))
    end
    @sample.play(0.1)
  when 4 #3 way
      @x = 200 * Math::cos(@rad) + 320
      @y = 25 * Math::sin(@rad) + 50
      @rad +=0.02
    if shot_rate(8)
      for num in 1..10
        @bullets.push(Bullet.new(@bullet_img, 0, (num - 1) * 480 / 10 + Gosu.random(0, 40), @danmaku_pattern = 6, theta = 0))
        @bullets.push(Bullet.new(@bullet_img, (num - 1) * 640 / 10 + Gosu.random(0,40) , 0, @danmaku_pattern = 7, theta = 0))
      end
      @sample.play(0.1)
    end
  
  end
end

