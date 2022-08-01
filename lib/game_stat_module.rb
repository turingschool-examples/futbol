require './lib/game_statistics'

module GameStatsable


  def goals_scored
    @games_data.map do |row| 
    row[:away_goals].to_i + row[:home_goals].to_i
    end
  end


  def percentage_wins_for_team_playing(home_or_away)
    wins = 0
    # total_games = 0
    @game_teams_data.each do |row|
      if row[:hoa] == (home_or_away)
        if row[:result] == 'WIN'
          wins += 1
        #   total_games += 1
        # elsif row[:result] == 'LOSS'|| 'TIE'
        #   total_games += 1
        end
      end
    end
    (wins / game_count_on_game_teams).round(2)
  end


 ## XX Game_Count method does not work at the moment
  # XX divides the total games by 2 (not sure why)
  def game_teams_total_games_count
    total_games = 0
    @game_teams_data.each do |row|
      if row[:result] == 'TIE' || 'LOSS' || 'WIN'
    # elsif 
    #   row[:result] == 
        total_games += 1
    end
    total_games
  end
## XX

# XX working count 
  def game_count_on_game_teams
    total_games = []
      @games_data.each do |row|
      total_games << row[:game_id]
      end
      total_games.uniq!
      total_games.size.to_f
    end

    season_games.each do |season, games| #tally method work?
        @games_data.each do |row|
          # require 'pry';binding.pry
          if row[:season] == season
            season_games[season] += 1
          end 
        end
    end
    return season_games


  end




end