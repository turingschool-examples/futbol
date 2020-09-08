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

  def total_scores_by_team
    base = Hash.new(0)
    @game_teams.each do |game|
      key = game.team_id.to_s
      # require "pry"; binding.pry
      base[key] += game.goals
    end
    base
  end

  def average_scores_by_team
    total_scores_by_team.merge(games_containing_team){|team_id, scores, games_played| (scores.to_f / games_played).round(2)}
  end

  def games_containing_team
    games_by_team = Hash.new(0)
    @game_teams.each do |game|
      games_by_team[game.team_id.to_s] += 1
    end
    games_by_team
  end

  def team_names_by_team_id(id)
    team_id_hash = {}
    @teams.each do |team|
      team_id_hash[team.team_id.to_s] = team.team_name
    end
    team_id_hash[id.to_s]
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


# ~~~ LEAGUE METHODS~~~
  def worst_offense
    #could use something like a map to iterate on average_scores_by_team, then invert the hash and call team_names_by_team_id
  end

# ~~~ SEASON METHODS~~~

# ~~~ TEAM METHODS~~~

end
