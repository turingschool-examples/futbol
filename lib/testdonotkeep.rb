def hash(relevant_games, team_id)
   new_hash = Hash.new { |hash, key| hash[key] = [] }
   relevant_games.each do |game|
     if game[:away_team_id] != team_id 
       new_hash[game[:away_team_id]] << game[:game_id]
     elsif game[:home_team_id] != team_id
       new_hash[game[:home_team_id]] << game[:game_id]
     end
   end
   require 'pry'; binding.pry
   return new_hash
 end

 def winloss(team_id, relevant_game_teams)
   hashed_win_lost = Hash.new 
   relevant_game_teams.each do |game_team|
     require 'pry'; binding.pry
     hashed_win_lost[game_team[:game_id]] = game_team[:result]
   end
   require 'pry'; binding.pry
   return hashed_win_lost
 end 

 def splitwin(game_id_win_loss)
   wins = []
   game_id_win_loss.each do |key, value|
     if value == "WIN"
       wins << key 
     end
   end
   return wins
 end

 def splitloss(game_id_win_loss)
   losses = []
   game_id_win_loss.each do |key, value|
     if value == "LOSS" 
       losses << key 
     end
   end
   return losses

 end

 def split_ties(game_id_win_loss)
   ties = []
   game_id_win_loss.each do |key, value|
     if value == "TIE" 
       ties << key 
     end
   end
   return ties

 end

 def accumulate(game_id_win, game_id_loss, game_id_ties, hashed_info)
   victories_over_team = Hash.new{ |hash, key| hash[key] = 0 }
   losses = Hash.new{ |hash, key| hash[key] = 0 }
   ties = Hash.new{ |hash, key| hash[key] = 0 }
   final_calculations = Hash.new
   
   game_id_win.each do |id|
     hashed_info.keys.each do |key|
       if hashed_info[key].include?(id)
         victories_over_team[key] += 1
         end
       end
     end
   
   game_id_loss.each do |id|
     hashed_info.keys.each do |key|
       if hashed_info[key].include?(id)
         losses[key] += 1
         end
       end
     end

     game_id_ties.each do |id|
       hashed_info.keys.each do |key|
         if hashed_info[key].include?(id)
           ties[key] += 1
           end
         end
       end

   hashed_info.keys.each do |key|
     final_calculations[key] = victories_over_team[key]/ ((victories_over_team[key].to_f) +(losses[key].to_f) +ties[key].to_f) 
   end 
   
     sorted_calculations = final_calculations.sort_by do |key, value|
       value
     end 

   end 


  # def rival(team_id)
  #   relevant_game_teams = find_relevant_game_teams_by_teamid(team_id)
  #   relevant_games = find_relevant_games(relevant_game_teams)
  #   hashed_info = hash(relevant_games, team_id)
  #   game_id_win_loss = winloss(team_id, relevant_game_teams)
  #   game_id_win = splitwin(game_id_win_loss)
  #   game_id_loss = splitloss(game_id_win_loss)
  #   game_id_ties = split_ties(game_id_win_loss)
  #   accumulate_hash = accumulate(game_id_win, game_id_loss, game_id_ties, hashed_info)

  #   sorted_calculations = accumulate_hash
  #   result_id = sorted_calculations.first.first

  #   selected = teams.select do |team|
  #     team[:team_id] == result_id
  #   end
  #   conclusion = selected.first[:team_name]

#   end 