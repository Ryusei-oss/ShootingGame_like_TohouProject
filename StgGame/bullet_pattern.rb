def bullet_pattern(pattern)
  case pattern
  when 0
    @y -= 10      
  when 1

  when 2
    @x += 4 * Math.cos(@theta)
    @y += 4 * Math.sin(@theta)
  when 3
    @x += 2 * Math.cos(@theta)
    @y += 2 * Math.sin(@theta)
  when 4
    @x += 10 * Math.sin(@theta / 180 * Math::PI)
    @y -= 10 * Math.cos(@theta / 180 * Math::PI)
  when 5
    @x += 7 * Math.sin(@theta / 180 * Math::PI)
    @y -= 7 * Math.cos(@theta / 180 * Math::PI)
  when 6
    @x += 3
  when 7
    @y += 3
  else
    puts "ellor bullet_pattern"
  end
end

