require_relative "./game"
require_relative "./team"
require_relative "./gameteam"

class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    games = Game.create_from_csv(locations[:games])
    teams = Team.create_from_csv(locations[:teams])
    game_teams = GameTeam.create_from_csv(locations[:game_teams])
    StatTracker.new(games, teams, game_teams)
  end

  def highest_total_score
    Game.highest_total_score
  end

  def lowest_total_score
    Game.lowest_total_score
  end

  def count_of_teams
    Team.count_of_teams
  end

  def best_offense
    GameTeams.best_offense
  end

  def worst_offense
    GameTeams.worst_offense
  end

  def most_tackles
    # Game.most_tackles
  end






end
