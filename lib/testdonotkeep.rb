def winningest_coach(season)

  raw_hash_values(season, "winning")

end 

def worst_coach(season)

  raw_hash_values(season, "worst")

end 

def raw_hash_values(season, type)

new_hash_games = Hash.new(0)
new_hash_victories = Hash.new(0)

games.each do |game|
  game_teams.each do |game_team|
    if game[:season] == season 
      if game_team[:game_id] == game[:game_id]
        if game_team[:result]== "LOSS"
          new_hash_games[game_team[:head_coach]] += 1
        elsif game_team[:result] == "TIE"
          new_hash_games[game_team[:head_coach]] += 1
        elsif game_team[:result] == "WIN"
          new_hash_victories[game_team[:head_coach]] += 1 
          new_hash_games[game_team[:head_coach]] += 1
        end
      end 
    end 
  end 
  end 
  require 'pry'; binding.pry
sort_coach_percentages(new_hash_games, new_hash_victories, type)
end 

def sort_coach_percentages(new_hash_games, new_hash_victories, type)

  additional_hash = {}
  
  new_hash_games.each do |key, value|
  new_hash_victories.each do |key_v, value_v|
    if key == key_v 
      percent = (value_v / value.to_f) 
    additional_hash[key] = percent
    end
  end
  end
  sorted_array = additional_hash.sort_by do |key, value|
  value
  end
  require 'pry'; binding.pry
  determine_coach(sorted_array, type)
end 

def determine_coach(sorted_array, type)
  require 'pry'; binding.pry
  if type == "winning"
    sorted_array = sorted_array.reverse
  elsif type == "worst"
  sorted_array = sorted_array

  end 

  result = sorted_array[0][0]
  return result 
end 












def winningnest_coach(season)

  total_relevant_games = determine_games(season)
  all_coaches = total_relevant_games.group_by do |game|
        game[:head_coach]
      end
    
    all_coaches.each do |coach, games|
      all_coaches[coach] = 0
      games.each do |game|
       
        all_coaches[coach] += game[:result].count("WIN")
      end 
        all_coaches[coach] = all_coaches[coach]/games.count
    end
      require 'pry'; binding.pry
  end 