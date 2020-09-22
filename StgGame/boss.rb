require "./boss_danmaku"
class Boss < Enemy
  def initialize(player, font)
    @number = 0
    @x = 240 
    @y = -200
    @z = 2
    @hp = 5000
    @rad = 0
    @status = 0
    @text_status = 0
    @timer = 0
    @image = Gosu::Image.new("images/enemy/boss.png")
    @apper_time = 2300
    @bullet_img = Gosu::Image.new("images/bullet/bullet5.png")
    @bullets = Array.new
    @shot_counter = 0
    @apperance = false
    @player = player
    @font = font
    @sample = Gosu::Sample.new("song/sound_effect_3rd.mp3")
  end

  def update
    #bossの召喚
    if !@apperance && @hp > 0
      if @apper_time < $timer
        @apperance = true
      end
    end
    #bossの登場
    if @apperance
      if @status ==0
        if @y <=50
          @y += 3
        end
        if @y >50
          @status = 1
          @y = 51
        end
      end
    end 
    #会話イベント
    if @status == 1
      if ($timer - @timer) > 60 || @timer == 0
        if Gosu.button_down? Gosu::KB_Z
          @text_status += 1
          @timer = $timer
        end
      end
    end
    #戦闘
    if @status >= 2 && @status < 5
      boss_danmaku(@status)
    end
    #戦闘status 3
    if @hp <= 3500 && @hp > 1500
      @status =3
    #戦闘status 4
    elsif @hp <= 1500 && @hp > 0
      @status = 4
    elsif @hp <= 0 && @apperance
      @apperance = false
      @status = 5
    end
    bullet_update
  end

  def draw  
    if @apperance
        @image.draw(@x, @y ,2)
        Gosu.draw_rect(20, 30, (600 * @hp)/ 5000, 15, 0xff_ff0000, z = 2, :default)
    end

    case @text_status
    when 1
      @font.draw_text("よくここまできたわね",180,240,2, 2, 2, 0xff_ffff00, :default)
    when 2
      @font.draw_text("でも、ここで終わりよ",180,240,2, 2, 2, 0xff_ffff00, :default)
    when 3
      @font.draw_text("勝つのは私！！！",200,240,2, 2, 2, 0xff_ffff00, :default)
    when 4
      @status = 2
      @text_status +=1
    else
    end

    if @bullets == nil 
      puts "nil enemy.rb"
    end
    @bullets.each{ |bullet| bullet.draw}
  end

  attr_accessor :x, :y, :hp, :bullets, :apperance, :status

end
