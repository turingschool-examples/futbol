require './lib/futbol_data.rb'

class Season < FutbolData
  # attr_reader :team_data,:game_teams_data
             
  # def initialize(teams_data, game_teams_data)
  #   @teams_data = teams_data
  #   @game_teams_data = game_teams_data
  # end

  #Method returns the name Coach with the best win percentage for the season in a string
  def winningest_coach(campaign)
    coached_games_in_season = Hash.new(0)
    coach_wins_in_season = Hash.new(0)
    game_results_percentage = Hash.new
    
    #method returns hash: coach (key), count fo RESULT(WIN) (value)
    season_data(campaign).find_all do |row|
      if row[:result] == "WIN"
        coach_wins_in_season [row[:head_coach]] += 1
      end
    end
    coach_wins_in_season 

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
    coached_games_in_season = Hash.new(0)
    coach_wins_in_season = Hash.new(0)
    game_results_percentage = Hash.new
    
    #method returns hash: coach (key), count fo RESULT(WIN) (value)
    season_data(campaign).select do |row|
      if row[:result] != "WIN"
        coach_wins_in_season [row[:head_coach]] += 1
      end
    end
    coach_wins_in_season 

    #method return a hash: coach(key), count of games coached in a season (value)-if coach had a WIN
    season_data(campaign).select do |row|
          coached_games_in_season[row[:head_coach]] += 1
      end
        coached_games_in_season 

    #method merges the wins and coached games hashes for comparison
        game_results_percentage.update(coached_games_in_season,coach_wins_in_season) do |coach, games_coached, games_won| 
            (games_won.fdiv(games_coached)).round(4)
        end
        worst_coach = game_results_percentage.max_by do |coach, percentage| 
          percentage 
        end
        worst_coach[0]
  end

  #Team with the best ratio of shots to goals for the season (goals/shots)
  def most_accurate_team(campaign)
    team_season_goals_count = Hash.new(0)
    team_season_shots_count = Hash.new(0)
    shot_efficiency = Hash.new

    #hash with team (key) and goals (value) in given season
    season_data(campaign).find_all do |row|
      goals = row[:goals].to_i
      shots = row[:shots].to_i

      team_season_goals_count[row[:team_id]] += goals
      team_season_shots_count[row[:team_id]] += shots
    end
    team_season_goals_count
    team_season_shots_count

    #merge shots, goal hashes; calculate team efficiecy; return team neame
    shot_efficiency.update(team_season_goals_count,team_season_shots_count) do |team, goals_made, shots_taken|
      goals_made.fdiv(shots_taken).round(4)
    end
    team_efficiency = shot_efficiency.max_by do |coach, percentage| 
      percentage end

      team_name_from_id_average(team_efficiency)
  end

  #Team with the worst ratio of shots to goals for the season
  def least_accurate_team	(campaign)
    team_season_goals_count = Hash.new(0)
    team_season_shots_count = Hash.new(0)
    shot_efficiency = Hash.new

    #2 seperate hash with team (key), goals (value) and shots(value) in given season - 
    season_data(campaign).each do |row|
      goals = row[:goals].to_i
      shots = row[:shots].to_i

      team_season_goals_count[row[:team_id]] += goals
      team_season_shots_count[row[:team_id]] += shots
    end
    team_season_goals_count
    team_season_shots_count

    #merge shots, goal hashes; calculate team efficiecy; return team neame
    shot_efficiency.update(team_season_goals_count,team_season_shots_count) do |team, goals_made, shots_taken|
      goals_made.fdiv(shots_taken).round(4)
    end
    team_efficiency = shot_efficiency.min_by do |coach, percentage| 
      percentage end

      team_name_from_id_average(team_efficiency)
  end

  #Team with the most tackles in the season
  def most_tackles(campaign)
    team_total_tackles = Hash.new(0)
    season_data(campaign)
    
    season_data(campaign).each do |row|
      tackles = row[:tackles].to_i
      team_total_tackles[row[:team_id]] += tackles
    end
    number_of_team_tackle = team_total_tackles.max_by do |coach, percentage| 
      percentage end
      team_name_from_id_average(number_of_team_tackle)
  end

  #Team with the fewest tackles in the season
  def fewest_tackles(campaign)
    team_total_tackles = Hash.new(0)
    season_data(campaign)
    
    season_data(campaign).each do |row|
      tackles = row[:tackles].to_i
      team_total_tackles[row[:team_id]] += tackles
    end
    team_tackle = team_total_tackles.min_by do |coach, percentage| 
      percentage end
      team_name_from_id_average(team_tackle)
  end

  #helper method from Darby - team_id used to find team name
  def team_name_from_id_average(data)
    @teams_data.each do |row|
      if data[0] == row[:team_id]
        return row[:teamname]
      end
    end
  end

  #collects all rows within the given campaign
  def season_data(campaign)
    season = Set.new
    @game_teams_data.each do |row|      
      row.find_all do |game_id|
        if campaign.scan(/.{4}/).shift == row[:game_id].scan(/.{4}/).shift
          season << row
        end
      end
    end
    season 
  end
end