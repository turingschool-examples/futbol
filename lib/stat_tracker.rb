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

  def season_group
    @games.group_by do |row|
      row.season
    end
  end

  def count_of_games_by_season
    count_of_games_by_season = {}
    self.season_group.each do |group|
      count_of_games_by_season[group[0]] = group[1].count
    end
    count_of_games_by_season
  end

  def count_of_teams
    @teams.count
  end

  def avg_team_score_as_visitor(team)
    array = @games.group_by do |row|
      row.away_team_id
    end
    require "pry"; binding.pry
  end

  def avg_team_score_at_home(team_id)

  end

  def highest_scoring_visitor

  end

  def highest_scoring_home_team

  end
end
