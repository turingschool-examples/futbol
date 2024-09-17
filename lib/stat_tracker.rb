require 'CSV'
require './lib/game'
require './lib/game_factory'
require './lib/team'
require './lib/teams_factory'
require './lib/game_team'
require './lib/game_team_factory'

class Stattracker
  attr_reader :game_teams_factory,
              :teams_factory,
              :game_factory,
              :all_games,
              :all_teams,
              :all_game_teams

  def initialize
    @game_teams_factory = GameTeamFactory.new
    @teams_factory = Teams_factory.new
    @game_factory = GameFactory.new
    @all_games = []
    @all_teams = []
    @all_game_teams = []
  end

  def self.from_csv(source)
    stattracker = Stattracker.new

    source.each do |key, value|
      case key
      when :games
        stattracker.game_factory.create_games(value)
      when :teams
        stattracker.teams_factory.create_teams(value)
      when :game_teams
        stattracker.game_teams_factory.create_game_teams(value)
      end
    end

    stattracker.instance_variable_set(:@all_games, stattracker.game_factory.games)
    stattracker.instance_variable_set(:@all_teams, stattracker.teams_factory.teams)
    stattracker.instance_variable_set(:@all_game_teams, stattracker.game_teams_factory.game_teams)

    stattracker
  end

  def percentage_home_wins
    total_games = @games.length
    home_wins = @games.count { |game| game.home_goals > game.away_goals }

    percentage = (home_wins.to_f / total_games) * 100
    percentage.round(2)
  end

  def from_csv(locations)
    @game_teams = GameTeamFactory.new
    @game_teams.create_game_teams(locations[:game_teams])
    @games = GameFactory.new
    @games.create_games(locations[:games])

    @teams = Teams_factory.new
    @teams.create_teams(:teams)
  end

  def average_goals_per_game
    # TODO: required
    # Average number of goals scored in a game across all
    # seasons including both home and away goals (rounded to the nearest 100th)
    # returns float
  end

  def average_goals_season
    # TODO: required
    # Average number of goals scored in a game organized
    # in a hash with season names (e.g. 20122013) as keys
    # and a float representing the average number of goals
    # in a game for that season as values (rounded to the nearest 100th)
    # returns hash
  end

  def get_average(scores)
    # TODO: helper method
    # returns float
  end

  def get_sum(scores)
    # TODO: helper method
    # returns int
  end

  def get_scores(team_id, season)
    # TODO: helper method
    # returns array of scores
    # season parameter option, set to all seasons by default
  end
end
