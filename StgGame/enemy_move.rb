def enemy_move(move_pattern, danmaku_pattern)
  if @hp > 0 
    case move_pattern
    when 1 #動かない 弾幕パターンテスト用
     
      # puts "#{@x}, #{@y}"
    when 2 #横振動する
      @x += 4 * Math.sin(Gosu::milliseconds / 100)
    when 3 #上から降ってくる
      if @y < 100
        @y += 2
      end
    when 4
      if @y < 80
        @y += 2 
      end
    when 5
      if @y < 80
        @y += 2 
      else
        if @hp == 1000
          @font.draw_text("I am Boss! Let's Battle me",320,240,2)
        end
      end
      
    end
    enemy_shot(danmaku_pattern)  
  end
end