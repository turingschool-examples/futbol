require_relative 'game_team'
require_relative 'game'
require_relative 'team'

class Stats

  attr_reader :games, :teams, :game_teams
  def self.from_csv(locations)
    games_path = locations[:games]
    teams_path = locations[:teams]
    game_teams_path = locations[:game_teams]
    Stats.new(games_path, teams_path, game_teams_path)
  end

  def initialize(games_path, teams_path, game_teams_path)
    Game.from_csv(games_path)
    GameTeam.from_csv(game_teams_path)
    Team.from_csv(teams_path)

    @@games = Game.all
    @@teams = Team.all
    @@game_teams = GameTeam.all
  end

  def self.games
    @@games
  end

  def self.teams
    @@teams
  end

  def self.game_teams
    @@game_teams
  end

  def average_goals_by_team(team_id, hoa = nil) # game_teams?
    goals = total_games_and_goals_by_team(team_id, hoa)[0]
    games = total_games_and_goals_by_team(team_id, hoa)[1]
    return 0 if games == 0
    (goals.to_f / games.to_f).round(2) # average
  end

  def total_games_and_goals_by_team(team_id, hoa)
    goals_games = [0, 0]
    @@game_teams.each do |game_team|
      if hoa && game_team.team_id == team_id && game_team.hoa == hoa
        add_goals_and_games(goals_games, game_team)
      elsif !hoa && game_team.team_id == team_id
        add_goals_and_games(goals_games, game_team)
      end
    end
    goals_games
  end

  def add_goals_and_games(goals_games, game_team)
    goals_games[0] += game_team.goals
    goals_games[1] += 1
  end

  def unique_team_ids # parent?
    @@game_teams.map{|game_team| game_team.team_id}.uniq
  end

  def team_by_id(team_id) # parent class
    @@teams.find{|team| team.team_id == team_id}
  end

end
