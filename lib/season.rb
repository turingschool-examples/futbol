require './lib/futbol_data.rb'

class Season < FutbolData
  def winningest_coach(campaign)
    game_results_percentage = Hash.new

    #method merges the wins and coached games hashes for comparison
    game_results_percentage.update(season_coached_games(campaign),season_coach_wins(campaign)) do |coach, games_coached, games_won| 
      (games_won.fdiv(games_coached)).round(4)
    end
  
    winning_coach = highest_success_rate(game_results_percentage) 
    winning_coach[0]
  end

  def worst_coach(campaign)
    coached_games = Hash.new(0)
    coach_loss_tie = Hash.new(0)
    
    # method returns 2 hash: coach (key),count fo RESULT(WIN) (value) and total games in season
    season_data(campaign).select do |row|
      coached_games[row[:head_coach]] += 1
      coach_loss_tie[row[:head_coach]] += 1 if row[:result] != "WIN"
    end
    coach_loss_tie
    coached_games 

    worst_coach = 
    merge_hashes_and_divide(coach_loss_tie, coached_games).max_by do |coach,percentage| 
      percentage 
    end
    worst_coach[0]
  end

  def most_accurate_team(campaign)
    team_name_from_team_id(highest_success_rate(team_accuracy(campaign)))
  end

  def least_accurate_team(campaign)
    team_name_from_team_id(lowest_success_rate(team_accuracy(campaign)))
  end

  #returns two Hashes with team (key) and shots taken (value) and goals made (value)
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

  def most_tackles(campaign)
    team_name_from_team_id(highest_success_rate(team_tackles(campaign)))
  end

  def fewest_tackles(campaign)    
    team_name_from_team_id(lowest_success_rate(team_tackles(campaign)))
  end

  #returns the total number of team tackles in a season
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

  # method returns hash: coach (key),count fo RESULT(WIN) (value)
  def season_coach_wins(campaign)
    coach_wins = Hash.new(0)
    season_data(campaign).select do |row|
      coach_wins[row[:head_coach]] += 1 if row[:result] == "WIN"
    end
    coach_wins 
  end

  # method return a hash: coach(key), count of games coached in a season (value)-if coach had a WIN
  def  season_coached_games(campaign)
    coached_games = Hash.new(0)
    season_data(campaign).find_all do |row|
      if season_coach_wins(campaign).has_key?(row[:head_coach])
        coached_games[row[:head_coach]] += 1
      end
    end
    coached_games 
  end
end