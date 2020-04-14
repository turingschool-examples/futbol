require_relative 'game_team'
require_relative 'game'
require_relative 'team'
require_relative 'calculable'

class Stats
  include Calculable

  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end


  def average_goals_by_team(team_id, hoa = nil)
    goals = total_games_and_goals_by_team(team_id, hoa)[0]
    games = total_games_and_goals_by_team(team_id, hoa)[1]
    return 0 if games == 0
    average(goals, games)
  end

  def total_games_and_goals_by_team(team_id, hoa)
    goals_games = [0, 0]
    @game_teams.each do |game_team|
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

  def unique_team_ids
    @game_teams.map{|game_team| game_team.team_id}.uniq
  end

  def team_by_id(team_id)
    @teams.find{|team| team.team_id == team_id}
  end

  def team_games_by_season(season) # test
    season_games = @games.find_all{|game| game.season == season}
    season_game_ids = season_games.map{|game| game.game_id}
    @game_teams.find_all{|team| season_game_ids.include?(team.game_id)}
  end

end
