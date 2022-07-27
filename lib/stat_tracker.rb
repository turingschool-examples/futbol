require 'csv'

class StatTracker
  attr_reader :locations,
              :games_data,
              :teams_data,
              :game_teams_data

  def initialize(locations)
    @locations = locations
    @games_data = CSV.read(@locations[:games], headers: true, header_converters: :symbol)
    @teams_data = CSV.read(@locations[:teams], headers: true, header_converters: :symbol)
    @game_teams_data = CSV.read(@locations[:game_teams], headers: true, header_converters: :symbol)
  end

  def self.from_csv(locations)
    new_stat_tracker = StatTracker.new(locations)#games_data, teams_data, game_teams_data)
  end

  # Game statistics 
  def highest_total_score
    scores = @games_data.map do |row|
      row[:away_goals].to_i + row[:home_goals].to_i 
    end
    scores.max
  end

  def lowest_total_score

  end

  def percentage_home_wins

  end

  def percentage_visitor_wins

  end

  def percentage_ties

  end

  def count_of_games_by_season

  end

  def average_goals_per_game
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

  def average_goals_by_season
    new_hash = Hash.new()
    @games_data.each do |row|
      new_hash[row[:season]] = []
    end
    @games_data.each do |row|
      new_hash[row[:season]] << (row[:away_goals].to_i + row[:home_goals].to_i)
    end
    average_goals_by_season = Hash.new()
    new_hash.each do |season, goals|
      average_goals_by_season[season] = (goals.sum.to_f / goals.length).round(2)  
    end
    average_goals_by_season
  end
# League Statistics
  def count_of_teams
    teams = []
    @teams_data.select do |team|
      teams << team[:team_id] 
    end
    teams.count
  end

  def best_offense 
    teams = Hash.new()
    @game_teams_data.each do |row|
      teams[row[:team_id]] = []
    end
    @game_teams_data.each do |row|
      teams[row[:team_id]] << row[:goals].to_i 
    end
    team_average_goals = Hash.new()
    teams.each do |team, goals|
      team_average_goals[team] = (goals.sum.to_f / goals.length).round(2)
    end
    team_best_offense = team_average_goals.key(team_average_goals.values.max)
    find_team_name_by_id(team_best_offense)
  end 

  def worst_offense # team w/ lowest average goals scored per game.
    teams = Hash.new()
    @game_teams_data.each do |row|
      teams[row[:team_id]] = []
    end
    @game_teams_data.each do |row|
      teams[row[:team_id]] << row[:goals].to_i 
    end
    team_average_goals = Hash.new()
    teams.each do |team, goals|
      team_average_goals[team] = (goals.sum.to_f / goals.length).round(2)
    end
    team_worst_offense = team_average_goals.key(team_average_goals.values.min)
    find_team_name_by_id(team_worst_offense)
  end

  def highest_scoring_visitor
    teams = Hash.new()
    @game_teams_data.each do |row|
      teams[row[:team_id]] = []
    end
    @game_teams_data.each do |row|
      if row[:hoa] == "away"
        teams[row[:team_id]] << row[:goals].to_i
      end
    end
    team_average_goals = Hash.new()
    teams.each do |team, goals|
      team_average_goals[team] = (goals.sum.to_f / goals.length).round(2)
    end
    highest_score_visitor = team_average_goals.key(team_average_goals.values.max)
    find_team_name_by_id(highest_score_visitor)
  end

  def highest_scoring_home_team
    teams = Hash.new()
    @game_teams_data.each do |row|
      teams[row[:team_id]] = []
    end
    @game_teams_data.each do |row|
      if row[:hoa] == "home"
        teams[row[:team_id]] << row[:goals].to_i
      end
    end
    team_average_goals = Hash.new()
    teams.each do |team, goals|
      team_average_goals[team] = (goals.sum.to_f / goals.length).round(2)
    end
    highest_score_home_team = team_average_goals.key(team_average_goals.values.max)
    find_team_name_by_id(highest_score_home_team)
  end

  def lowest_scoring_visitor
    teams = Hash.new()
    @game_teams_data.each do |row|
      teams[row[:team_id]] = []
    end
    @game_teams_data.each do |row|
      if row[:hoa] == "away"
        teams[row[:team_id]] << row[:goals].to_i
      end
    end
    team_average_goals = Hash.new()
    teams.each do |team, goals|
      team_average_goals[team] = (goals.sum.to_f / goals.length).round(2)
    end
    lowest_score_visitor = team_average_goals.key(team_average_goals.values.min)
    find_team_name_by_id(lowest_score_visitor)
  end

  def lowest_scoring_home_team
    teams = Hash.new()
    @game_teams_data.each do |row|
      teams[row[:team_id]] = []
    end
    @game_teams_data.each do |row|
      if row[:hoa] == "home"
        teams[row[:team_id]] << row[:goals].to_i
      end
    end
    team_average_goals = Hash.new()
    teams.each do |team, goals|
      team_average_goals[team] = (goals.sum.to_f / goals.length).round(2)
    end
    lowest_score_home_team = team_average_goals.key(team_average_goals.values.min)
    find_team_name_by_id(lowest_score_home_team)
  end
  
  # Season Statistics
  
  def winningest_coach
    coach_records = {}
    all_coaches_array.each do |coach|
      coach_records[coach] = {wins: 0, total_games: 0}
    end
    @game_teams_data.each do |row|
      result = row[:result]
      coach = row[:head_coach].to_sym
      if result == "WIN"
        coach_records[coach][:wins] += 1
        coach_records[coach][:total_games] += 1
      else
        coach_records[coach][:total_games] += 1
      end
    end
    new_hash = coach_records.map do |coach, record|
      [coach, (record[:wins].to_f/record[:total_games].to_f)]
    end.to_h
    new_hash.key(new_hash.values.max)
  end
    
  def worst_coach
    coach_records = {}
    all_coaches_array.each do |coach|
      coach_records[coach] = {wins: 0, total_games: 0}
    end
    @game_teams_data.each do |row|
      result = row[:result]
      coach = row[:head_coach].to_sym
      if result == "WIN"
        coach_records[coach][:wins] += 1
        coach_records[coach][:total_games] += 1
      else
        coach_records[coach][:total_games] += 1
      end
    end
    new_hash = coach_records.map do |coach, record|
      [coach, (record[:wins].to_f/record[:total_games].to_f)]
    end.to_h
    new_hash.key(new_hash.values.min)
  end

  def most_accurate_team
    accuracy_by_id = Hash.new(0)
    @game_teams_data.each do |row|
      goals = row[:goals].to_f
      shots = row[:shots].to_f
      team_id = row[:team_id]
      accuracy = goals / shots
      accuracy_by_id[team_id] = accuracy
    end
    accurate_id = accuracy_by_id.key(accuracy_by_id.values.max)
    find_team_name_by_id(accurate_id)
  end

  def least_accurate_team
    accuracy_by_id = Hash.new
    @game_teams_data.each do |row|
      goals = row[:goals].to_f
      shots = row[:shots].to_f
      team_id = row[:team_id]
      accuracy = goals / shots
      accuracy_by_id[team_id] = accuracy
    end
    accurate_id = accuracy_by_id.key(accuracy_by_id.values.min)
    find_team_name_by_id(accurate_id)
  end

  def most_tackles
    tackles_by_id = Hash.new
    @game_teams_data.each do |row|
      tackles_by_id[row[:team_id]] = row[:tackles]
    end
    most_tackle_id = tackles_by_id.key(tackles_by_id.values.max)
    find_team_name_by_id(most_tackle_id)
  end

  def fewest_tackles
    tackles_by_id = Hash.new
    @game_teams_data.each do |row|
      tackles_by_id[row[:team_id]] = row[:tackles]
    end
    least_tackle_id = tackles_by_id.key(tackles_by_id.values.min)
    find_team_name_by_id(least_tackle_id)
  end

  # Team Statistics

  def team_info

  end

  def best_season

  end

  def worst_season

  end

  def average_win_percentage

  end

  def most_goals_scored

  end

  def fewest_goals_scored

  end

  def favorite_opponent

  end

  def rival

  end

  # Helper Methods Below

  def find_team_name_by_id(id_number)
    team_name = nil
    @teams_data.each do |row|
      team_name = row[:teamname] if row[:team_id] == id_number.to_s
    end
    team_name
  end

  def all_coaches_array
    coach_array = []
    @game_teams_data.each do |row|
      coach_array << row[:head_coach]
    end
    coach_array.uniq!.map do |coach|
      coach.to_sym
    end
  end

end

