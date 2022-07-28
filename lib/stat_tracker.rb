require 'csv'


class StatTracker
  attr_reader :games, :teams, :game_teams
  def initialize(games, teams, game_teams)
    @games = read_data(games)
    @teams = read_data(teams)
    @game_teams = read_data(game_teams)
    #require "pry"; binding.pry
  end

  def self.from_csv(locations)
    games = CSV.open(locations[:games], { headers: true, header_converters: :symbol })
    teams = CSV.open(locations[:teams], { headers: true, header_converters: :symbol })
    game_teams = CSV.open(locations[:game_teams], {headers: true, header_converters: :symbol })
    StatTracker.new(games, teams, game_teams)
  end

  def read_data(data)
    list_of_data = []
    data.each do |row|
      list_of_data << row
    end
    list_of_data
  end

  def highest_total_score
    max = @games.max_by { |game| game[:away_goals].to_i + game[:home_goals].to_i }
    max[:away_goals].to_i + max[:home_goals].to_i
  end

  def lowest_total_score
    min = @games.min_by { |game| game[:away_goals].to_i + game[:home_goals].to_i }
    min[:away_goals].to_i + min[:home_goals].to_i
  end

  def percentage_home_wins
    wins = @games.count { |game| game[:home_goals].to_i > game[:away_goals].to_i}
    games = @games.count
    (wins / games.to_f).round(2)
  end

  def percentage_visitor_wins
    wins = @games.count { |game| game[:home_goals].to_i < game[:away_goals].to_i}
    games = @games.count
    (wins / games.to_f).round(2)
  end

  def percentage_ties
    wins = @games.count { |game| game[:home_goals].to_i == game[:away_goals].to_i}
    games = @games.count
    (wins / games.to_f).round(2)
  end

  def count_of_games_by_season
    seasons = Hash.new
    @games.each do |game|
      if seasons[game[:season]]
        seasons[game[:season]] += 1
      else
        seasons[game[:season]] = 1
      end
    end
    seasons
  end

  def average_goals_per_game
    (@games.sum { |game| game[:away_goals].to_f + game[:home_goals].to_f } / @games.count).round(2)
  end

  def average_goals_by_season
    seasons = count_of_games_by_season
    avg_arr = []
    seasons.each do |season, count|
      games_in_season = @games.find_all { |game| game[:season] == season }
      avg_arr << ((games_in_season.sum { |game| game[:away_goals].to_i + game[:home_goals].to_i}) / count.to_f).round(2)
    end
    Hash[seasons.keys.zip(avg_arr)]
  end

  def count_of_teams
    @teams.count
  end

  def best_offense
    teams = ((@games.map { |game| game[:home_team_id] }) + (@games.map { |game| game[:away_team_id] })).uniq.sort_by { |num| num.to_i }
    avgs = []
    teams.each do |team|
      home_goal = (@games.find_all { |game| team == game[:home_team_id]}.map { |game| game[:home_goals].to_i}).sum
      away_goal = (@games.find_all { |game| team == game[:away_team_id]}.map { |game| game[:away_goals].to_i}).sum
      avgs << ((home_goal + away_goal).to_f / (@games.find_all { |game| game[:home_team_id] == team || game[:away_team_id] == team}).count).round(3)
    end
    best_o_id = (Hash[teams.zip(avgs)].max_by { |_k, v| v })[0]
    @teams.find { |team| team[:team_id] == best_o_id }[:teamname]
  end

  def worst_offense
    teams = ((@games.map { |game| game[:home_team_id] }) + (@games.map { |game| game[:away_team_id] })).uniq.sort_by { |num| num.to_i }
    avgs = []
    teams.each do |team|
      home_goal = (@games.find_all { |game| team == game[:home_team_id]}.map { |game| game[:home_goals].to_i}).sum
      away_goal = (@games.find_all { |game| team == game[:away_team_id]}.map { |game| game[:away_goals].to_i}).sum
      avgs << ((home_goal + away_goal).to_f / (@games.find_all { |game| game[:home_team_id] == team || game[:away_team_id] == team}).count).round(3)
    end
    worst_o_id = (Hash[teams.zip(avgs)].min_by { |_k, v| v })[0]
    @teams.find { |team| team[:team_id] == worst_o_id }[:teamname]
  end

  def highest_scoring_visitor
    teams = (@games.map { |game| game[:away_team_id] }).uniq.sort_by { |num| num.to_i }
    avgs = []
     teams.each do |team|
      away_goal = (@games.find_all { |game| team == game[:away_team_id]}.map { |game| game[:away_goals].to_i}).sum
      avgs << ((away_goal).to_f / (@games.find_all { |game| game[:away_team_id] == team}).count).round(3)
    end
      highest_visitor = (Hash[teams.zip(avgs)].max_by { |_k, v| v })[0]
    @teams.find { |team| team[:team_id] == highest_visitor }[:teamname]
  end

  def highest_scoring_home_team
    teams = (@games.map { |game| game[:home_team_id] }).uniq.sort_by { |num| num.to_i }
    avgs = []
     teams.each do |team|
      home_goal = (@games.find_all { |game| team == game[:home_team_id]}.map { |game| game[:home_goals].to_i}).sum
      avgs << ((home_goal).to_f / (@games.find_all { |game| game[:home_team_id] == team}).count).round(3)
    end
      highest_home_team = (Hash[teams.zip(avgs)].max_by { |_k, v| v })[0]
    @teams.find { |team| team[:team_id] == highest_home_team }[:teamname]
  end

  def lowest_scoring_visitor
    teams = (@games.map { |game| game[:away_team_id] }).uniq.sort_by { |num| num.to_i }
    avgs = []
    teams.each do |team|
      away_goal = (@games.find_all { |game| team == game[:away_team_id]}.map { |game| game[:away_goals].to_i}).sum
      avgs << ((away_goal).to_f / (@games.find_all { |game| game[:away_team_id] == team}).count).round(3)
    end
    lowest_visitor = (Hash[teams.zip(avgs)].min_by { |_k, v| v })[0]
    @teams.find { |team| team[:team_id] == lowest_visitor }[:teamname]
  end

  def lowest_scoring_home_team
    teams = (@games.map { |game| game[:home_team_id] }).uniq.sort_by { |num| num.to_i }
    avgs = []
    teams.each do |team|
      home_goal = (@games.find_all { |game| team == game[:home_team_id]}.map { |game| game[:home_goals].to_i}).sum
      avgs << ((home_goal).to_f / (@games.find_all { |game| game[:home_team_id] == team}).count).round(3)
    end
    lowest_home_team = (Hash[teams.zip(avgs)].min_by { |_k, v| v })[0]
    @teams.find { |team| team[:team_id] == lowest_home_team }[:teamname]
  end

end
