require 'csv'

class StatTracker
  def self.from_csv(locations)
    all_data_hash = Hash.new{ |h, k| h[k] = [] }
    CSV.foreach(locations[:games], headers: true, header_converters: :symbol) do |row|
      all_data_hash[:games] << row
    end
    CSV.foreach(locations[:teams], headers: true, header_converters: :symbol) do |row|
      all_data_hash[:teams] << row
    end
    CSV.foreach(locations[:game_teams], headers: true, header_converters: :symbol) do |row|
      all_data_hash[:game_teams] << row
    end
  new(all_data_hash)
  end

  def initialize(all_data_hash)
    @all_data_hash = all_data_hash
  end

  def highest_total_score
    @all_data_hash[:games].map do |row|
      home_goals = row[:home_goals].to_i
      away_goals = row[:away_goals].to_i
      home_goals + away_goals
    end.max
  end

  def lowest_total_score
    total_scores = @all_data_hash[:games].map do |row|
      home_goals = row[:home_goals].to_i
      away_goals = row[:away_goals].to_i
      home_goals + away_goals
    end
    total_scores.min
  end

  def average_goals_per_game
    total_scores = @all_data_hash[:games].map do |row|
      home_goals = row[:home_goals].to_i
      away_goals = row[:away_goals].to_i
      home_goals + away_goals
    end
    (total_scores.sum(0.0) / total_scores.length).round(2)
  end

  def count_of_games_by_season
    games_by_season = Hash.new(0)

    @all_data_hash[:games].each do |row|
      games_by_season[row[:season]] += 1
    end
    games_by_season
  end

  def count_of_teams
    team_names = []

    @all_data_hash[:teams].each do |row|
      team_names << row[:teamname]
    end
    team_names.uniq.count
  end

  def average_goals_by_season
    goals_season_hash = Hash.new
    @all_data_hash[:games].each do |row|
      home_goals = row[:home_goals].to_i
      away_goals = row[:away_goals].to_i
      if !goals_season_hash[row[:season]]
        goals_season_hash[row[:season]] = []
      end
      goals_season_hash[row[:season]] << (home_goals + away_goals)
    end
    avg_goals_by_season = Hash.new(0)
    goals_season_hash.each do |season, total_scores|
      avg_goals_by_season[season] = (total_scores.sum(0.0) / total_scores.length).round(2)
    end
    avg_goals_by_season
  end

  def highest_scoring_visitor
    away_team_goals_hash = Hash.new
    @all_data_hash[:game_teams].each do |row|
      if !away_team_goals_hash[row[:team_id]]
        away_team_goals_hash[row[:team_id]] = []
      end
      if row[:hoa] == "away"
        away_team_goals_hash[row[:team_id]] << row[:goals].to_i
      end
    end
    avg_away_team_goals_hash = Hash.new(0)
    away_team_goals_hash.each do |team, goals|
      avg_away_team_goals_hash[team] = (goals.sum(0.0) / goals.length).round(2)
    end
    highest_team_id = avg_away_team_goals_hash.max_by do |team, avg_goals|
      avg_goals
    end[0]
    highest_team_name = nil
    @all_data_hash[:teams].each do |row|
      if row[:team_id] == highest_team_id
        highest_team_name = row[:teamname]
      end
    end
    highest_team_name
  end

  def lowest_scoring_visitor
    away_team_goals_hash = Hash.new
    @all_data_hash[:game_teams].each do |row|
      if !away_team_goals_hash[row[:team_id]]
        away_team_goals_hash[row[:team_id]] = []
      end
      if row[:hoa] == "away"
        away_team_goals_hash[row[:team_id]] << row[:goals].to_i
      end
    end
    avg_away_team_goals_hash = Hash.new(0)
    away_team_goals_hash.each do |team, goals|
      avg_away_team_goals_hash[team] = (goals.sum(0.0) / goals.length).round(2)
    end
    lowest_away_team_id = avg_away_team_goals_hash.min_by do |team, avg_goals|
      avg_goals
    end[0]
    lowest_away_team_name = nil
    @all_data_hash[:teams].each do |row|
      if row[:team_id] == lowest_away_team_id
        lowest_away_team_name = row[:teamname]
      end
    end
    lowest_away_team_name
  end
end
