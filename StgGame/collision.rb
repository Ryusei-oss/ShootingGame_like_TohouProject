require './enemy'
#当たり判定メソッド
def collision
  #敵と自分の弾
  @enemys.each_with_index do |enemy, index|
    if enemy.hp > 0 && enemy.apperance
      @player.bullets.each do |bullet|
        distanse = (enemy.center_x - bullet.center_x )**2 + (enemy.center_y - bullet.center_y)**2
        if distanse < 500
          enemy.hp -= 20
          bullet.flag = true
          bullet.sample.play(0.005)
          # puts "HIT and Enemy num #{index} HP #{enemy.hp} collision.rb"  
        end
      end
    end
  end
  #ボスと自分の弾
  if @boss.hp > 0 && @boss.apperance && @boss.status >= 2
    @player.bullets.each do |bullet|
      distanse = (@boss.center_x - bullet.center_x )**2 + (@boss.center_y - bullet.center_y)**2
      if distanse < 500
        @boss.hp -= 50
        bullet.flag = true
        bullet.sample.play(0.005)
        # puts "HIT and Boss!  HP #{@boss.hp} collision.rb"  
      end
    end
  end

  #自分と敵弾
  @enemys.each do |enemy|
    enemy.bullets.each do |bullet|
      distanse = (@player.x - bullet.center_x)**2 + (@player.y - bullet.center_y)**2
      if distanse < 100
        bullet.flag = true
        bullet.sample.play(0.05)
        @player.hidan_count += 1
      end
    end
  end

  @boss.bullets.each do |bullet|
    distanse = (@player.x - bullet.center_x)**2 + (@player.y - bullet.center_y)**2
    if distanse < 100
      bullet.flag = true
      bullet.sample.play(0.005)
      @player.hidan_count += 1
    end
  end

#当たった弾消去
  @player.bullets.delete_if do |bullet| 
    bullet.flag == true
  end
  @enemys.each do |enemy| 
    enemy.bullets.delete_if do |bullet| 
      bullet.flag == true
    end
  end
  @boss.bullets.delete_if do |bullet| 
    bullet.flag == true
  end
end


