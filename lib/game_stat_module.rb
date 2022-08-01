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
  end


  def ties_percentage
    tie = 0
    total_games = 0

    @game_teams_data.each do |row|
        if row[:hoa] == 'away'
          
          if row[:result] == 'TIE'
            tie += 1
            total_games += 1
          elsif row[:result] == 'WIN'
            total_games += 1
          elsif row[:result] == 'LOSS'
            total_games += 1
          end
        end
    end
      (tie / total_games.to_f).round(2)
  end
  
  def season_game_count
    season_games = {}

    seasons = @games_data.map { |row|row[:season] }
    seasons = seasons.uniq!
  
    seasons.each { |season| season_games[season] = 0 }

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

  def ave_goals_a_game
    total_games = []
    @games_data.each do |row|
      total_games << row[:game_id]
    end
    total_goals = 0

    @games_data.each do |row|
      total_goals += (row[:away_goals].to_i + row[:home_goals].to_i)
    end
    (total_goals.to_f / total_games.count).round(2)
  end

  def ave_goals_a_season
    seasons = Hash.new()
    @games_data.each do |row|
      seasons[row[:season]] = []
    end
    @games_data.each do |row|
      seasons[row[:season]] << (row[:away_goals].to_i + row[:home_goals].to_i)
    end
    average_goals_by_season = Hash.new()
    seasons.each do |season, goals|
      average_goals_by_season[season] = (goals.sum.to_f / goals.length).round(2)  
    end
    average_goals_by_season
  end











end