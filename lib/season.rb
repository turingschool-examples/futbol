class Season
  def initialize(game_team_data, game_data, team_data)

    @game_team_data = game_team_data
    @game_data = game_data
    @team_data = team_data
  end

  def most_tackles(season)
    game_ids = []
    @game_data.each do |row|
      game_ids << row[:game_id] if row[:season] == season
    end
    game_ids
   
    season_game_team_data = []
    @game_team_data.each do |row|
     season_game_team_data << row if game_ids.include?(row[:game_id]) 
    end

    season_game_team_data
  
    tackles_by_team = Hash.new(0)
    season_game_team_data.each do |row|
      tackles_by_team[row[:team_id]] += row[:tackles].to_i   
    end

    top_team_tackles = tackles_by_team.max_by{ |k, v| v}
  
    top_tackle_team = @team_data.find do |row|
      top_team_tackles.first == row[:team_id]
    end

    top_tackle_team[:team_name]
  end 

  def fewest_tackles(season)
    game_ids = []
    @game_data.each do |row|
      game_ids << row[:game_id] if row[:season] == season
    end
    game_ids
   
    season_game_team_data = []
    @game_team_data.each do |row|
     season_game_team_data << row if game_ids.include?(row[:game_id]) 
    end

    season_game_team_data
  
    tackles_by_team = Hash.new(0)
    season_game_team_data.each do |row|
      tackles_by_team[row[:team_id]] += row[:tackles].to_i   
    end

    least_team_tackles = tackles_by_team.min_by{ |k, v| v}
  
    least_tackle_team = @team_data.find do |row|
      least_team_tackles.first == row[:team_id]
    end

    least_tackle_team[:team_name]
  end 

  def coach_totals(season)
    coach_hash_total = Hash.new(0)
    @game_data.each do |game_row|
      if game_row[:season] == season
        season_game_id = game_row[:game_id]
        @game_team_data.each do |row|
          if row[:game_id] == season_game_id 
            head_coach = row[:head_coach]
            coach_hash_total[head_coach] += 1
          end
        end
      end
    end
    coach_hash_total
  end
  
  def coach_wins(season)
    coach_hash_winnings =  Hash.new(0)
    @game_data.each do |game_row|
      if game_row[:season] == season
        season_game_id = game_row[:game_id]
        @game_team_data.each do |row|
          if row[:game_id] == season_game_id && row[:result] == "WIN"
            head_coach = row[:head_coach]
            coach_hash_winnings[head_coach] += 1
          end
        end
      end
    end
    coach_hash_winnings
  end

  def winningest_coach(season)
    coach_win_percentage = Hash.new(0)

    coach_totals(season).each do |coach, total|
      win_count = coach_wins(season)[coach]
      percentage = (win_count.to_f / total.to_f) * 100
      coach_win_percentage[coach] = percentage
    end
    winningest_coach = coach_win_percentage.max_by { |coach, percentage| percentage }

    return winningest_coach[0]
  end

  def worst_coach(season)
    coach_win_percentage = Hash.new(0)

    coach_totals(season).each do |coach, total|
      win_count = coach_wins(season)[coach]
      percentage = (win_count.to_f / total.to_f) * 100
      coach_win_percentage[coach] = percentage
    end
    winningest_coach = coach_win_percentage.min_by { |coach, percentage| percentage }

    return winningest_coach[0]
  end

  def goals_accurate_team(season)
    goals = Hash.new(0)
    @game_data.each do |row|
      if row[:season] == season
        season_game_id = row[:game_id]
        @game_team_data.each do |game_row|
          if game_row[:game_id] == season_game_id
            team = game_row[:team_id]
            goals[team] += game_row[:goals].to_i
          end
        end
      end
    end
    goals
  end

  def shots_accurate_team(season)
    shots = Hash.new(0)
    @game_data.each do |row|
      if row[:season] == season
        season_game_id = row[:game_id]
        @game_team_data.each do |game_row|
          if game_row[:game_id] == season_game_id
            team = game_row[:team_id]
            shots[team] += game_row[:shots].to_i
          end
        end
      end
    end
    shots
  end

  def most_accurate_team(season)
    accuracy = Hash.new(0)

    shots_accurate_team(season).each do |team, attempts|
      goals_made = goals_accurate_team(season)[team]
      ratio = (goals_made / attempts.to_f)
      accuracy[team] = ratio

    end
  end
end


