require './lib/futbol_data.rb'

class Season < FutbolData

  #Method returns the name Coach with the best win percentage for the season in a string
  def winningest_coach(campaign)
    coached_games = Hash.new(0)
    coach_wins = Hash.new(0)
    
    # method returns hash: coach (key),count fo RESULT(WIN) (value)
    season_data(campaign).select do |row|
      coach_wins [row[:head_coach]] += 1 if row[:result] == "WIN"
    end
    coach_wins 

    # method return a hash: coach(key),count of games coached in a season (value)-if coach had a WIN
    season_data(campaign).select do |row|
      coached_games[row[:head_coach]] += 1 if coach_wins.has_key?(row[:head_coach])
    end
    coached_games 

    # method return a hash: coach(key), count of games coached in a season (value)-if coach had a WIN
    season_data(campaign).find_all do |row|
      if coach_wins_in_season.has_key?(row[:head_coach])
        coached_games_in_season[row[:head_coach]] += 1
      end
    end
        coached_games_in_season 

    #method merges the wins and coached games hashes for comparison
    game_results_percentage.update(coached_games_in_season,coach_wins_in_season) do |coach, games_coached, games_won| 
            (games_won.fdiv(games_coached)).round(4)
        end
    
    winning_coach = game_results_percentage.max_by do |coach, percentage| 
       percentage 
    end
      
    winning_coach[0]
  end

  #Coach with the worst win percentage for the season
  def worst_coach(campaign)
    coached_games = Hash.new(0)
    coach_loss_tie = Hash.new(0)
    
    # method returns 2 hash: coach (key),count fo RESULT(WIN) (value) and total games in season
    season_data(campaign).select do |row|
      coached_games[row[:head_coach]] += 1
      coach_loss_tie [row[:head_coach]] += 1 if row[:result] != "WIN"
    end
    coach_loss_tie
    coached_games 

    worst_coach = 
    merge_hashes_and_divide(coach_loss_tie, coached_games).max_by do |coach,percentage| 
      percentage 
    end
        worst_coach[0]
  end

  #Team with the best ratio of shots to goals for the season (goals/shots)
  def most_accurate_team(campaign)
    team_name_from_team_id(highest_success_rate(team_accuracy(campaign)))
  end

  #Team with the worst ratio of shots to goals for the season
  def least_accurate_team(campaign)
    team_name_from_team_id(lowest_success_rate(team_accuracy(campaign)))
  end

  def team_accuracy(campaign)
    season_goals = Hash.new(0)
    team_shots = Hash.new(0)

    season_data(campaign).select do |row|
      season_goals[row[:team_id]] += row[:goals].to_i
      team_shots[row[:team_id]] += row[:shots].to_i
    end
    season_goals
    team_shots

    merge_hashes_and_divide(season_goals,team_shots)
  end

  #Team with the most tackles in the season
  def most_tackles(campaign)
    team_name_from_team_id(highest_success_rate(team_tackles(campaign)))
  end

  #Team with the fewest tackles in the season
  def fewest_tackles(campaign)    
    team_name_from_team_id(lowest_success_rate(team_tackles(campaign)))
  end

  def team_tackles(campaign)
    team_total_tackles = Hash.new(0)
      
    season_data(campaign).select do |row|
      tackles = row[:tackles].to_i
      team_total_tackles[row[:team_id]] += tackles
    end
    team_total_tackles
  end

  # helper method from Darby - team_id used to find team name
  def team_name_from_team_id(data)
    @teams_data.find do |row|
      if data[0] == row[:team_id]
        return row[:teamname]
      end
    end
  end

  #collects all rows within the given campaign
  def season_data(campaign)
    season = Set.new
    @game_teams_data.select do |row|      
      row.select do |game_id|
        season << row if campaign.scan(/.{4}/).shift == row[:game_id].scan(/.{4}/).shift
      end
    end
    season 
  end

  def highest_success_rate(data)
    data.max_by { |team,percentage| percentage }
  end

  def lowest_success_rate(data)
    data.min_by { |team,percentage| percentage }
  end

  def merge_hashes_and_divide(objective, attempts)
    efficiency = Hash.new

    efficiency.update(objective,attempts) do |team,goal,attempts|
      goal.fdiv(attempts).round(4)
    end
    efficiency
  end

end