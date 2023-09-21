class Season
  def initialize(game_team_data, game_data)
    @game_team_data = game_team_data
    @game_data = game_data
  end

  def winningest_coach(season)
    
    total_games = 0

    coach_hash_winnnings =  Hash.new(0)
    coach_hash_total = Hash.new(0)

    @game_data.each do |game_row|
      # require 'pry'; binding.pry
      if game_row[:season] == season
        #Total Games is only for ensuring that the season has been successfully isolated.
        total_games += 1 
        season_game_id = game_row[:game_id]
        @game_team_data.each do |row|
          if row[:game_id] == season_game_id && row[:result] == "WIN"
            head_coach = row[:head_coach]
            coach_hash_winnnings[head_coach] += 1
          elsif row[:game_id] == season_game_id 
            head_coach = row[:head_coach]
            coach_hash_total[head_coach] += 1
           #Perhaps I want to make an object that accumulates the wins and losses?
          end
        end
      end
    end
    coach_hash_winnnings
    coach_hash_total
    require 'pry'; binding.pry
  end
end