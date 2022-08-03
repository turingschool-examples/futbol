module GameStatsable
  
  def goals_scored
    @games_data.map do |row| 
    row[:away_goals].to_i + row[:home_goals].to_i
    end
  end
  
  def percentage_wins_for_team_playing(home_or_away)
    wins = 0
    total_games = 0
    @game_teams_data.each do |row|
      if row[:hoa] == (home_or_away)
        if row[:result] == 'WIN'
          wins += 1
          total_games += 1
        elsif row[:result] == 'LOSS'|| row[:result] == 'TIE'
          total_games += 1
        end
      end
    end
    (wins / total_games.to_f).round(2)
  end

  def ties_percentage
    tie = 0
    total_games = 0

    @game_teams_data.each do |row|
        if row[:hoa] == 'away'
          if row[:result] == 'TIE'
            tie += 1
            total_games += 1
          elsif row[:result] == 'LOSS'|| row[:result] == 'WIN'
            total_games += 1
          end
        end
    end
      (tie / total_games.to_f).round(2)
  end
  
  def build_empty_season_hash
    season_games = Hash.new(0)
    seasons = @games_data.map { |row|row[:season] }.uniq
    seasons.each { |season| season_games[season] = 0 }
    season_games
  end
  
  def season_game_count
    season_hash = build_empty_season_hash
    season_hash.each do |season, games|
      @games_data.each do |row|
        if row[:season] == season
          season_hash[season] += 1
        end 
      end
    end
    season_hash
  end

  def sum_of_goals(row)
    (row[:away_goals].to_i + row[:home_goals].to_i)
  end

  def total_games_array
    @games_data.map { |row| row[:game_id] }
  end

  # def ave_goals_a_game
  #   total_goals = @games_data.sum { |row| sum_of_goals(row) }
  #   (total_goals.to_f / total_games_array.count).round(2)
  # end

  def build_ave_goal_hash
    seasons = Hash.new { |h, k| h[k] = [] }
    @games_data.each do |row|
      seasons[row[:season]] << sum_of_goals(row)
    end
    seasons
  end

  def ave_goals_a_season
    average_goals_by_season = Hash.new()
    build_ave_goal_hash.each do |season, goals|
      average_goals_by_season[season] = (goals.sum.to_f / goals.length).round(2)  
    end
    average_goals_by_season
  end











end