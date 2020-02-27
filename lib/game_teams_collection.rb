require 'csv'
require_relative './game_teams'
require_relative '../modules/mathables.rb'


class GameTeamsCollection
  include Mathable
  
  attr_reader :game_teams
  def initialize(game_teams_data)
    @game_teams = create_game_teams(game_teams_data)
  end

  def create_game_teams(game_teams_data)
    game_teams_data = game_teams_data.map do |row|
      GameTeams.new(row.to_h)
    end
  end

  def hoa_games_by_team(hoa)
    hoa_games_by_team = Hash.new(0)
    game_teams.find_all do |game|
      hoa_games_by_team[game.team_id] += 1 if hoa.downcase == game.hoa
    end
    hoa_games_by_team
  end

  def hoa_goals_by_team(hoa)
    hoa_goals_by_team = Hash.new(0)
    game_teams.find_all do |game|
      if game.hoa == hoa.downcase
        hoa_goals_by_team[game.team_id] += game.goals
      else
        hoa_goals_by_team[game.team_id] += 0
      end
    end
    hoa_goals_by_team
  end

  def hoa_wins_by_team(hoa)
    hoa_wins_by_team = Hash.new(0)
    game_teams.find_all do |game|
      if hoa.downcase == game.hoa && game.result == "WIN"
        hoa_wins_by_team[game.team_id] += 1
      else
        hoa_wins_by_team[game.team_id] += 0
      end
    end
    hoa_wins_by_team
  end

  def hoa_win_percentage(hoa)
    hoa_games_played = hoa_games_by_team(hoa)
    hoa_games_won = hoa_wins_by_team(hoa)
    hoa_percentage = hoa_games_played.merge(hoa_games_played) do |team, hoa_game|
      hoa_games_won[team] / hoa_game.to_f
    end
  end

  def total_wins_by_team
    total_wins = Hash.new(0)
    game_teams.each do |game|
      if game.result == "WIN"
        total_wins[game.team_id] += 1
      elsif game.result == "LOSS"
        total_wins[game.team_id] =+ 0
      end
    end
    total_wins
  end

  def find_games_in_season(season)
    game_teams.find_all do |game|
      season[0..3] == game.game_id.to_s[0..3]
    end
  end

  def season_tackles(season)
    totals = Hash.new(0)
    find_games_in_season(season).each do |game|
      totals[game.team_id] += game.tackles
    end
    totals
  end

  def offense_rankings
    game_teams_grouped_by_team_id = game_teams.group_by do |game_team|
      game_team.team_id
    end
    games_per_team = game_teams_grouped_by_team_id.each_pair do |team_id, games_by_team|
      total_goals = games_by_team.map do |single_game|
        single_game.goals
      end
      game_team_averages = divide(total_goals.sum, total_goals)
        game_teams_grouped_by_team_id[team_id] = game_team_averages
    end
  end

  def scores_as_visitor
    games_played_by_team = hoa_games_by_team('away')
    scores_by_team = hoa_goals_by_team('away')
    average_score_game = games_played_by_team.merge(games_played_by_team) do |team, games|
      games_played_by_team[team] = scores_by_team[team] / games.to_f
    end
  end

  def scores_as_home_team
    average_goals_home_game = {}
      hoa_goals_by_team("home").each do |team_id, total_home_goals|
      next if total_home_goals == 0
      average_goals_home_game [team_id] = total_home_goals / hoa_games_by_team("home")[team_id].to_f
    end
    average_goals_home_game
  end
end
