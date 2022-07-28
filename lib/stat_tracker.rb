require 'csv'

class StatTracker
  attr_reader :locations, :data

  def initialize(game_path, team_path, game_teams_path)
    # @locations = locations
    # @data = {}
    # locations.each_key do |key|
    #   data[key] = CSV.read locations[key]
    # end
    @game_path = game_path
    @team_path = team_path
    @game_teams_path = game_teams_path
    # games = Games.new(locations[:games])
  end

  def self.from_csv(locations)
    StatTracker.new(
      locations[:games],
      locations[:teams],
      locations[:game_teams]
    )
  end

  def highest_total_score
    score_sum = 0
    contents = CSV.open(@game_path, headers: true, header_converters: :symbol)
    contents.each do |row|
      away_goals = row[:away_goals].to_i
      home_goals = row[:home_goals].to_i
      if score_sum < (away_goals + home_goals)
        score_sum = (away_goals + home_goals)
      end
    end
    score_sum
  end


  def lowest_total_score
    score_sum = 10000 #need to update for csv file with no data
    contents = CSV.open(@game_path, headers: true, header_converters: :symbol)
    contents.each do |row|
      away_goals = row[:away_goals].to_i
      home_goals = row[:home_goals].to_i
      if score_sum > (away_goals + home_goals)
        score_sum = (away_goals + home_goals)
      end
    end
    score_sum
  end


  def percentage_home_wins
    total_games = 0.0
    home_wins = 0.0
    contents = CSV.open(@game_path, headers: true, header_converters: :symbol)
    contents.each do |row|
      total_games += 1
      away_goals = row[:away_goals].to_i
      home_goals = row[:home_goals].to_i
      if home_goals > away_goals
        home_wins += 1
      end
    end

    (home_wins / total_games).round(2)
  end

  def percentage_visitor_wins
    total_games = 0.0
    visitor_wins = 0.0
    contents = CSV.open(@game_path, headers: true, header_converters: :symbol)
    contents.each do |row|
      total_games += 1
      away_goals = row[:away_goals].to_i
      home_goals = row[:home_goals].to_i
      if home_goals < away_goals
        visitor_wins += 1
      end
    end

    (visitor_wins / total_games).round(2)
  end

  def percentage_ties
    total_games = 0.0
    ties = 0.0
    contents = CSV.open(@game_path, headers: true, header_converters: :symbol)
    contents.each do |row|
      total_games += 1
      away_goals = row[:away_goals].to_i
      home_goals = row[:home_goals].to_i
      if home_goals == away_goals
        ties += 1
      end
    end

    (ties / total_games).round(2)
  end

  def count_of_games_by_season
    season_games = Hash.new(0)
    contents = CSV.open(@game_path, headers: true, header_converters: :symbol)
    contents.each do |row|
      season_games[row[:season]] += 1
    end
    season_games
  end

  def average_goals_per_game
    total_goals = 0.0
    total_games = 0.0
    contents = CSV.open(@game_path, headers: true, header_converters: :symbol)
    contents.each do |row|
      total_games += 1
      away_goals = row[:away_goals].to_i
      home_goals = row[:home_goals].to_i
      total_goals += (away_goals + home_goals)
    end
    (total_goals / total_games).round(2)
  end

  def total_goals_by_season
    total_season_goals = Hash.new(0.0)
    contents = CSV.open(@game_path, headers: true, header_converters: :symbol)
    contents.each do |row|
      away_goals = row[:away_goals].to_i
      home_goals = row[:home_goals].to_i
      total_season_goals[row[:season]] += away_goals + home_goals
    end
    total_season_goals
  end

  def average_goals_by_season
    total_goals = total_goals_by_season
    count = count_of_games_by_season
    avg_season_goals = Hash.new(0.0)
      total_goals.each do |season, goal|
        avg_season_goals[season] = (goal / count[season]).round(2)
      end
    avg_season_goals
  end

  def count_of_teams
    team_count = 0
    contents = CSV.open(@team_path, headers: true, header_converters: :symbol)
    contents.each do |row|
      teams = row[:team_id].to_i
      if teams != 0
        team_count += 1
      end
    end
    team_count
  end

  def best_offense
    game_teams_csv = CSV.open(@game_teams_path, headers: true, header_converters: :symbol)
    goals_by_team_id = Hash.new(0)
    game_teams_csv.each do |row|
      goals_by_team_id[row[:team_id].to_i] += row[:goals].to_i
    end
    best_offense_team_id = goals_by_team_id.max_by { |team_id, goals| goals }[0]
    teams_csv = CSV.open(@team_path, headers: true, header_converters: :symbol)
    team_row = teams_csv.find do |row|
      row[:team_id].to_i == best_offense_team_id
    end
    team_row[:teamname]
  end

  def worst_offense
    game_teams_csv = CSV.open(@game_teams_path, headers: true, header_converters: :symbol)
    goals_by_team_id = Hash.new(0)
    game_teams_csv.each do |row|
      goals_by_team_id[row[:team_id].to_i] += row[:goals].to_i
    end
    #in the method below we are checking the lowest scoring team by accessing the key at the end "[0]"
    best_offense_team_id = goals_by_team_id.min_by { |team_id, goals| goals }[0]
    teams_csv = CSV.open(@team_path, headers: true, header_converters: :symbol)
    team_row = teams_csv.find do |row|
      row[:team_id].to_i == best_offense_team_id
    end
    team_row[:teamname]
  end

  def highest_scoring_visitor
    games_csv = CSV.open(@game_path, headers: true, header_converters: :symbol)
    away_goals_by_team_id = Hash.new(0)
    games_csv.each do |row|
      away_goals_by_team_id[row[:away_team_id].to_i] += row[:away_goals].to_i
    end
    best_away_team_id = away_goals_by_team_id.max_by { |away_team_id, goals| goals }[0]
    teams_csv = CSV.open(@team_path, headers: true, header_converters: :symbol)
    visitor_team_row = teams_csv.find do |row|
      row[:team_id].to_i == best_away_team_id
    end
    visitor_team_row[:teamname]
  end

end
