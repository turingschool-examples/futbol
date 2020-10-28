# Sum up Away and Home team's score per game_id
# Get data by col
  # Col by winning score + Col by losing score
# Parse CSV table initially and save as instance variable
# Method will iterate through instance variable
require 'csv'

class StatTracker
  attr_reader :games, :game_teams, :teams
  def self.from_csv(locations)
    new(locations)
  end

  def initialize(locations)
    @games = locations[:games]
    @game_teams = locations[:game_teams]
    @teams = locations[:teams]
  end

  def highest_total_score # Rename later, for now from Games Table
    most = 0
    CSV.foreach(games, :headers => true, header_converters: :symbol) do |row|
      total = row[:away_goals].to_i + row[:home_goals].to_i
      most = total if total > most
    end
    most
  end

  def lowest_total_score
    least = 1000
    CSV.foreach(games, :headers => true, header_converters: :symbol) do |row|
      total = row[:home_goals].to_i + row[:away_goals].to_i
      least = total if total < least
    end
    least
  end

  def percentage_home_wins
    home_wins = 0
    visitor_wins = 0
    ties = 0
    CSV.foreach(game_teams, headers: true, header_converters: :symbol) do |row|
      next if row[:result] == "LOSS"
      if row[:result] == "TIE"
        ties += 0.5
      elsif row[:hoa] == "away"
        visitor_wins += 1
      elsif row[:hoa] == "home"
        home_wins += 1
      end
    end
    total_games = home_wins + visitor_wins + ties
    percentage = calc_percentage(home_wins, total_games)
  end

  def percentage_visitor_wins
    home_wins = 0
    visitor_wins = 0
    ties = 0
    CSV.foreach(game_teams, headers: true, header_converters: :symbol) do |row|
      next if row[:result] == "LOSS"
      if row[:result] == "TIE"
        ties += 0.5
      elsif row[:hoa] == "away"
        visitor_wins += 1
      elsif row[:hoa] == "home"
        home_wins += 1
      end
    end
    total_games = home_wins + visitor_wins + ties
    percentage = calc_percentage(visitor_wins, total_games)
  end

  def percentage_ties
    home_wins = 0
    visitor_wins = 0
    ties = 0.0
    CSV.foreach(game_teams, headers: true, header_converters: :symbol) do |row|
      next if row[:result] == "LOSS"
      if row[:result] == "TIE"
        ties += 0.5
      elsif row[:hoa] == "away"
        visitor_wins += 1
      elsif row[:hoa] == "home"
        home_wins += 1
      end
    end
    total_games = home_wins + visitor_wins + ties
    percentage = calc_percentage(ties, total_games)
  end

  def count_of_games_by_season
    season_games = {}
    CSV.foreach(games, headers: true, header_converters: :symbol) do |row|
      if season_games.key?(row[:season])
        season_games[row[:season]] += 1
      else
        season_games[row[:season]] = 1
      end
    end
    season_games
  end

  def calc_percentage(numerator, denominator)
    (numerator.to_f / denominator * 100).round(2)
  end

  def average_goals_per_game
    total_goals = 0
    game_count = 0
    CSV.foreach(games, headers: true, header_converters: :symbol) do |row|
      total_goals += row[:home_goals].to_i
      total_goals += row[:away_goals].to_i
      game_count += 1
    end
    avg = (total_goals.to_f / game_count).round(2)
  end

  def average_goals_by_season
    season_avgs = {}
    seasons = []

      CSV.foreach(games, headers: true, header_converters: :symbol) do |row|
        next if seasons.include?(row[:season])
        seasons << row[:season]
      end

    seasons.each do |season|
      total_goals = 0
      game_count = 0

      CSV.foreach(games, headers: true, header_converters: :symbol) do |row|
        next if season != row[:season]
        game_count += 1
        total_goals += row[:home_goals].to_i
        total_goals += row[:away_goals].to_i
      end

      avg = (total_goals.to_f / game_count).round(2)
      season_avgs[season] = avg
    end
    season_avgs
  end

  def winningest_coach(season)
    season = season.to_s
    coaches_by_id = {}
    game_counts = {}
    team_percentage = {}
    # generate coaches_by_id key/value pairs
    CSV.foreach(game_teams, headers: true, header_converters: :symbol) do |row|
      next if coaches_by_id.key?(row[:team_id])
      coaches_by_id[row[:team_id]] = row[:head_coach]
    end
    # generate empty game_counts key/value pairs
    CSV.foreach(games, headers: true, header_converters: :symbol) do |row|
      next if row[:season] != season
      game_counts[row[:home_team_id]] = [0, 0] if !game_counts.key?(row[:home_team_id])

      game_counts[row[:away_team_id]] = [0, 0] if !game_counts.key?(row[:away_team_id])
    end
    # generate wins and total games for game_counts values array
    CSV.foreach(games, headers: true, header_converters: :symbol) do |row|
      next if row[:season] != season
      require "pry"; binding.pry
      game_counts[:home_team_id][1] += 1
      game_counts[:away_team_id][1] += 1
      if row[:away_goals] > row[:home_goals]
        game_counts[:away_team_id][0] += 1
      elsif row[:home_goals] > row[:away_goals]
        game_counts[:home_team_id][0] += 1
      end
    end
    require "pry"; binding.pry
    # empty wins_by_team
    # empty games_by_team
    # filter games file by season
    # if statement for away win/ home win/ tie
    # ties: skip
    # Inside winner blocks: accumulate in teams_id hash or create new hash key

    game_counts.each do |team_id, data|
      percentage = calc_percentage(data[0], data[1]) # data[0] is wins, data[1] is total
      team_percentage[team_id] = percentage
    end

    team_percentage.max_by
  end
end
