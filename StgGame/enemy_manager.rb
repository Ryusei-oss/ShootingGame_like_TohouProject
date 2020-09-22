def enemy_manager_1st
  if $timer >1000 && $timer < 1300
    return false
  else
    return true
  end

end

def enemy_manager_2nd #敵のオールデリート
  if $timer < 2000 || $timer >= 2250
    return false
  else
    return true
  end
end
