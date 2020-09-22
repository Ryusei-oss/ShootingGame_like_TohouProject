require 'rubygems'
require './bullet'
require './enemy_bullet'
require './enemy_move'
require './enemy_manager'

class Enemy
 
  def initialize(array, player)
    @number = array[0].to_i
    @x = array[1].to_i 
    @y = array[2].to_i 
    @z = array[3].to_i
    @hp = array[4].to_i
    @move_pattern = array[5].to_i
    @danmaku_pattern  = array[6].to_i
    @image = Gosu::Image.new(array[7].to_s)
    @apper_time = array[8].to_i
    @rad = 0
    @bullet_img = Gosu::Image.new("images/bullet/bullet2.png")
    @bullets = Array.new
    @shot_counter = 0
    @apperance = false
    @player = player
    @sample = Gosu::Sample.new("song/sound_effect_3rd.mp3")
  end

  def center_x
    return @x + @image.width / 2
  end
  
  def center_y
    return @y + @image.height / 2
  end

  def update
    if !@apperance && @hp > 0
      if enemy_manager_1st #敵の召喚タイミングをコントロール
        if @apper_time < $timer #敵の召喚に関するフラグ
          @apperance = true
        end
      end
    end
    if @apperance
      enemy_move(@move_pattern, @danmaku_pattern)
    end
    if enemy_manager_2nd
      @hp = 0 
      @apperance =false
    end
    if @apperance && @hp <= 0 
      @apperance = false
    end
      bullet_update
  end

  def draw  
    if @apperance
        @image.draw(@x , @y ,2)
    end
    if @bullets == nil 
      puts "nil enemy.rb"
    end
    @bullets.each{ |bullet| bullet.draw}
  end

  attr_accessor :x, :y, :hp, :bullets, :apperance
end
