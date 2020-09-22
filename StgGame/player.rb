require 'rubygems'
require './bullet'
require './player_controller'

BULLET_RATE = 6
class Player
  def initialize
    @image = Gosu::Image.new("images/player.png")
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @score = 0
    @shot_counter = BULLET_RATE
    @bullet_img = Gosu::Image.new("images/bullet/bullet1.png")
    @bullets = Array.new
    @center = Gosu::Image.new("images/circle2.png")
    @hidan_count = 0
    @sample = Gosu::Sample.new("song/sound_effect_1st.wav")
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def center_x
    return @x + @image.width / 2
  end
  
  def center_y
    return @y + @image.height / 2
  end

  def move
    player_controller

     if @bullets != nil
      @bullets.each do |bullet| 
         bullet.update
      end 
      @bullets.delete_if do |bullet| 
       bullet.y < 0
      end
    end

  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle, 0.5, 0.5, 1, 1, 0xff_ffffff, :default)
    @bullets.each{ |bullet| bullet.draw}
    @center.draw(@x - @center.width / 2, @y - @center.height / 2, 1)
  end

attr_accessor :x, :y, :hidan_count
attr_reader :bullets, :image
end