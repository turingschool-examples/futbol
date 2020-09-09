require "csv"
require "./lib/team"
require "./lib/game"
require "./lib/game_team"

class StatTracker
  attr_reader :teams, :games, :game_teams

  def initialize(teams, games, game_teams)
    @teams = teams
    @games = games
    @game_teams = game_teams
  end

  def self.from_csv(locations = {games: './data/games_sample.csv', teams: './data/teams_sample.csv', game_teams: './data/game_teams_sample.csv'})
    Game.from_csv(locations[:games])
    Team.from_csv(locations[:teams])
    GameTeam.from_csv(locations[:game_teams])
    self.new(Team.all_teams, Game.all_games, GameTeam.all_game_teams)
  end

# ~~~ Helper Methods ~~~~
  def total_games
    @games.count
  end

  def find_percent(numerator, denominator)
    (numerator.count / denominator.to_f * 100).round(2)
  end

  def sum_game_goals
    game_goals_hash = {}
    @games.each do |game|
      game_goals_hash[game.game_id] = (game.away_goals + game.home_goals)
    end
    game_goals_hash
  end

  def season_group
    @games.group_by do |row|
      row.season
    end
  end

# ~~~ Game Methods ~~~
  def lowest_total_score
    sum_game_goals.min_by do |game_id, score|
      score
    end.last
  end

  def highest_total_score
    sum_game_goals.max_by do |game_id, score|
      score
    end.last
  end

  def percentage_away_wins
    wins = @games.find_all { |game| game.away_goals > game.home_goals}
    find_percent(wins, total_games)
  end

  def percentage_ties
    ties = @games.find_all { |game| game.away_goals == game.home_goals}
    find_percent(ties, total_games)
  end

  def percentage_home_wins
    wins = @games.find_all { |game| game.away_goals < game.home_goals}
    find_percent(wins, total_games)
  end

  def count_of_games_by_season
    count_of_games_by_season = {}
    self.season_group.each do |group|
      count_of_games_by_season[group[0]] = group[1].count
    end
    count_of_games_by_season
  end

# ~~~ LEAGUE METHODS~~~
  def count_of_teams
    @teams.count
  end

  # def avg_team_score_as_visitor
  #   # hash = @games.group_by do |row|
  #   #   row.away_team_id
  #   # end
  #   # hash.each do |team_id, games|
  #   #   require "pry"; binding.pry
  #   # end
  #   hash = Hash.new(0)
  #   @games.each do |game|
  #     key = game.away_team_id
  #     hash[key] += game.away_goals
  #     hash.each do |key, value|
  #       require "pry"; binding.pry
  #       hash[key] = value/game.away_team_id.count
  #     end
  #   end
  #   # hash.each do |key, value|
  #   #   key =
  # end

  # def total_scores_by_team
  #   base = Hash.new(0)
  #   @game_teams.each do |game|
  #     key = game.team_id.to_s
  #     base[key] += game.goals
  #   end
  #   require "pry"; binding.pry
  #   base
  # end

# def avg_team_score_as_visitor
#   @games. do |game|
#     require "pry"; binding.pry
#   end
# end
  def ratio(numerator, denominator)
    (numerator.to_f / denominator).round(2)
  end

  def away_games
    @game_teams.select do |game_team|
      game_team.hoa == "away"
    end
  end

  def away_games_by_team
    away_games.group_by do |game_team|
      game_team.team_id
    end
  end

  def highest_scoring_visitor
    highest_scoring_visitor = away_games_by_team.max_by do |team_id, details|
      # require "pry"; binding.pry
      avg_score(details)
    end[0]
    team = (team_id_to_team_name(highest_scoring_visitor))
    team[0].team_name
  end

  #Wills methods
  def home_games_by_team
    home_games.group_by do |game_team|
      game_team.team_id
    end
  end

  def highest_scoring_home_team
    home_games_by_team.max_by do |team_id, details|
      avg_score(details)
    end[0]
  end

  def team_id_to_team_name(id)
    return @teams.select do |team|
      team.team_id == id
    end
  end

  def avg_score(filtered_game_teams = @game_teams)
    ratio(total_score(filtered_game_teams), total_game_teams(filtered_game_teams))
  end

  def total_score(filtered_game_teams = @game_teams)
    total_score = filtered_game_teams.reduce(0) do |sum, game_team|
      sum += game_team.goals
    end
  end

  def total_game_teams(filtered_game_teams = @game_teams)
    filtered_game_teams.count
  end

  def home_games
    home_games = @game_teams.select do |game|
      game.hoa == "home"
    end
    home_games
  end

# ~~~ SEASON METHODS~~~

# ~~~ TEAM METHODS~~~


end
