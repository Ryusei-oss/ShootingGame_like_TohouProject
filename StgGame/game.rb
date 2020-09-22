require 'gosu'
require './player'
require './bullet'
require './enemy'
require './boss'
require "csv"
require './collision'


module ZOrder
  BACKGROUND, STARS, PLAYER, UI = *0..3
end

$timer = 0

class Tutorial < Gosu::Window

#INITIALIZE=================================================
  def initialize
    super 640, 480, :fullscreen => false  # ウィンドウサイズの指定
    self.caption = "Danmaku Shooting Game"  # タイトルネームの指定
    # 背景画像とプレイヤークラスの読み込み
    @background_image = Gosu::Image.new("images/temple.jpg", :rect => [0, 50, 400, 300]) 
    @title_image = Gosu::Image.new("images/title_img.jpg", :rect => [0, 50, 400, 300]) 
    @font = Gosu::Font.new(20)
    @song = Gosu::Song.new("song/封印されし神々.mp3")
    @player = Player.new
    @player.warp(320, 240)
    @enemys = Array.new
      CSV.foreach("enemy_data/enemy_list.csv", headers: true) do |array|
        @enemys.push(Enemy.new(array, @player))
      end
    @boss = Boss.new(@player, @font)
    @status = "title"
    @boss_song = false
  end

#================================================================

# UPDATE ==========================================================
  def update
    case @status
    when "title"
      if Gosu::button_down? Gosu::KB_Z
        @status ="game"
        @song.stop
        @song =  Gosu::Song.new("song/亡き王女の為のセプテット.mp3")
        @song.volume = 0.01
      end
      if !@song.playing?
        @song.play
        @song.volume = 0.1
      end
    when "game"
      
      @player.move   
      @enemys.each do |enemy| 
            enemy.update 
      end
      @boss.update
      if @boss.status == 2 && !@boss_song
        @song.stop
        @song = Gosu::Song.new("song/U.N.オーエンは彼女なのか？.mp3")
        @song.play
        @song.volume = 0.05
        @boss_song = true
        puts "called @song"
      end
      if !@song.playing?
        @song.play
        @song.volume = 0.
        puts "song recalled"
      end
      #IMPACT METHOD
      collision
      #timer
      $timer += 1
    end
  end
#==========================================================
# DRAW ====================================================
  def draw #描画
    case @status 
    when "title"
      @title_image.draw(0,0,ZOrder::BACKGROUND, 1.6, 1.6)
      @font.draw_markup("<i>東方風弾幕ゲーム</i>", 120, 48, 2, 3, 3, 0xff_ff0000, :additive)
      @font.draw_text("~Ruby, Gosu~", 180, 100, 2, 2, 2, 0xff_ff0000, :default)
      Gosu.draw_rect(60,260, 500, 50, 0xff_0000ff, 2, :default)
      @font.draw_markup("<b>Start : [Z]</b>", 100, 270, 2, 2, 2, 0xff_ffff00, :default)
      @font.draw_markup("<b>End : [Esc]</b>",340,270,2, 2, 2, 0xff_ffff00, :default)
    when "game"
      @background_image.draw(0,0,ZOrder::BACKGROUND, 1.6, 1.6) # x, y, z
      @player.draw
      @enemys.each {|enemy| enemy.draw}
      @boss.draw
      @font.draw_text("Hit Counter #{@player.hidan_count}",480,15,2, 1.2, 1.2, 0xff_00ff00)
      #Game end
      if @boss.hp <= 0 && !@boss.apperance 
        @font.draw_text("Congraturation!!",200,220,2, 2, 2, 0xff_ffff00, :default)
        @font.draw_text("Your hit count is #{@player.hidan_count}",200,270,2, 2, 2, 0xff_ffff00, :default)
        @font.draw_text("Thank you for your playing, and press [Esc] key to end this game",50,320,2, 1, 1, 0xff_ffff00, :default)
      end
    end
  end
#=============================================================

  def button_down(id)
    if id == Gosu::KB_ESCAPE
      close
    elsif id == Gosu::KB_Q
      
    else
      super
    end
  end

#================================================================

attr_writer :bullets
attr_accessor :timer, :player_position_x, :player_position_y
end

  Tutorial.new.show
