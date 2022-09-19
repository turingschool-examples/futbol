require 'csv'

class StatTracker
  attr_reader :games_data, :teams_data, :game_teams_data
  def initialize(locations)
    @games_data = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    @teams_data = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    @game_teams_data = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
    # @season = Season.new(@teams_data,@game_teams_data)
  end
  
  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def highest_total_score
    @games_data.map do |row| 
    row[:away_goals].to_i + row[:home_goals].to_i
    end.max
  end

  def lowest_total_score
    @games_data.map do |row| 
    row[:away_goals].to_i + row[:home_goals].to_i
    end.min
  end

  def percentage_home_wins
    wins =0
    @games_data.each do |row| 
      if row[:away_goals].to_i < row[:home_goals].to_i
        wins += 1
      end
    end
    (wins.to_f/games_data.count).round(2)
  end

  def percentage_visitor_wins
    wins =0
    @games_data.each do |row| 
      if row[:away_goals].to_i > row[:home_goals].to_i
        wins += 1
      end
    end
    (wins.to_f/games_data.count).round(2)
  end

  def percentage_ties
    ties =0 
    @games_data.each do |row| 
      if row[:away_goals].to_i == row[:home_goals].to_i
        ties += 1
      end
    end
    (ties.to_f/games_data.count).round(2)
  end














































  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  def winningest_coach(campaign)
    coached_games_in_season = Hash.new(0)
    coach_wins_in_season = Hash.new(0)
    game_results_percentage = Hash.new
    
    season_data(campaign).find_all do |row|
      if row[:result] == "WIN"
        coach_wins_in_season [row[:head_coach]] += 1
      end
    end
    coach_wins_in_season 

    season_data(campaign).find_all do |row|
      if coach_wins_in_season.has_key?(row[:head_coach])
        coached_games_in_season[row[:head_coach]] += 1
      end
    end
    coached_games_in_season 

    game_results_percentage.update(coached_games_in_season,coach_wins_in_season) do |coach, games_coached, games_won| 
      (games_won.fdiv(games_coached)).round(4)
    end
    winning_coach = game_results_percentage.max_by { |coach, percentage| percentage }

    winning_coach[0]
  end

  def worst_coach(campaign)
    coached_games_in_season = Hash.new(0)
    coach_wins_in_season = Hash.new(0)
    game_results_percentage = Hash.new
    
    season_data(campaign).select do |row|
      if row[:result] != "WIN"
        coach_wins_in_season [row[:head_coach]] += 1
      end
    end
    coach_wins_in_season 

    season_data(campaign).select { |row| coached_games_in_season[row[:head_coach]] += 1}
      coached_games_in_season 

    game_results_percentage.update(coached_games_in_season,coach_wins_in_season) do |coach, games_coached, games_won| 
      (games_won.fdiv(games_coached)).round(4)
    end
    worst_coach = game_results_percentage.max_by { |coach, percentage| percentage }
      
    worst_coach[0]
  end

  def most_accurate_team(campaign)
    team_season_goals_count = Hash.new(0)
    team_season_shots_count = Hash.new(0)
    shot_efficiency = Hash.new

    season_data(campaign).find_all do |row|
      goals = row[:goals].to_i
      shots = row[:shots].to_i

      team_season_goals_count[row[:team_id]] += goals
      team_season_shots_count[row[:team_id]] += shots
    end
    team_season_goals_count
    team_season_shots_count

    shot_efficiency.update(team_season_goals_count,team_season_shots_count) do |team, goals_made, shots_taken|
      goals_made.fdiv(shots_taken).round(4)
    end
    team_efficiency = shot_efficiency.max_by { |coach, percentage| percentage }
    
    team_name_from_id_average(team_efficiency)
  end

  def least_accurate_team	(campaign)
    team_season_goals_count = Hash.new(0)
    team_season_shots_count = Hash.new(0)
    shot_efficiency = Hash.new

    season_data(campaign).each do |row|
      goals = row[:goals].to_i
      shots = row[:shots].to_i

      team_season_goals_count[row[:team_id]] += goals
      team_season_shots_count[row[:team_id]] += shots
    end
    team_season_goals_count
    team_season_shots_count

    shot_efficiency.update(team_season_goals_count,team_season_shots_count) do |team, goals_made, shots_taken|
      goals_made.fdiv(shots_taken).round(4)
    end
    team_efficiency = shot_efficiency.min_by { |coach, percentage| percentage }

    team_name_from_id_average(team_efficiency)
  end

  def most_tackles(campaign)
    team_total_tackles = Hash.new(0)
    season_data(campaign)
    
    season_data(campaign).each do |row|
      tackles = row[:tackles].to_i
      team_total_tackles[row[:team_id]] += tackles
    end
    number_of_team_tackle = team_total_tackles.max_by { |coach, percentage| percentage }
    
    team_name_from_id_average(number_of_team_tackle)
  end

  def fewest_tackles(campaign)
    team_total_tackles = Hash.new(0)
    season_data(campaign)
    
    season_data(campaign).each do |row|
      tackles = row[:tackles].to_i
      team_total_tackles[row[:team_id]] += tackles
    end
    team_tackle = team_total_tackles.min_by { |coach, percentage| percentage }
    team_name_from_id_average(team_tackle)
  end

  def team_name_from_id_average(data)
    @teams_data.each do |row|
      if data[0] == row[:team_id]
        return row[:teamname]
      end
    end
  end

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

  #Method returns best season for each team
  def best_season(team)
    team = "6"
    campaign = @games_data.map { |row| row[:season] }.uniq
  
    hash = Hash.new do |h,k| 
      h[k] = { games_won: 0, games_played: 0 } 
    end
    
    campaign.each do |year|
      a = @games_data.find_all do |row|
        row[:season] == year &&
        (row[:away_team_id] == team || row[:home_team_id] == team)
      end

      a.each do |game_row|
        b = @game_teams_data.find do |game_team_row|
          game_team_row[:game_id] == game_row[:game_id] && game_team_row[:team_id] == team 
        end 
        hash[year][:games_won] += 1 if b[:result] == "WIN"
        hash[year][:games_played] += 1
      end
    end
    require 'pry';binding.pry

    hash.

    season_win_percentage.update(played_games_in_season,wins_in_season) do |coach, games_played, games_won| 
      (games_won.fdiv(games_played)).round(4)
    end
    season_record = season_win_percentage.max_by { |coach, percentage| percentage }
require 'pry';binding.pry
    # season_record[0]
  end

  #Method returns best season for each team
  def worst_season (team)
  end

end