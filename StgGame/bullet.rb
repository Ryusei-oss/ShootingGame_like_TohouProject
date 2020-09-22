require './bullet_pattern'

class Bullet

  def initialize(image, x, y, danmaku_pattern, theta = {})
    @image = image
    @x = x
    @y = y
    @theta = theta
    @radius = 10
    @pattern = danmaku_pattern
    @flag = false
    @sample = Gosu::Sample.new("song/sound_effect_2nd.wav")
  end

  def center_x
    return @x + @image.width / 2
  end
  
  def center_y
    return @y + @image.height / 2
  end

  def update
    bullet_pattern(@pattern)
  end

  def draw  
    @image.draw(@x, @y, 2)
  end
  attr_reader :x, :y, :theta, :image, :sample
  attr_accessor :flag
end
