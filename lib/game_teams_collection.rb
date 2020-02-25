require 'csv'
require_relative './game_teams'

class GameTeamsCollection
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

  def hoa_loss_by_team(hoa)
    hoa_loss_by_team = Hash.new(0)
    game_teams.find_all do |game|
      if hoa.downcase == game.hoa && game.result == "LOSS"
        hoa_loss_by_team[game.team_id] += 1
      else
        hoa_loss_by_team[game.team_id] += 0
      end
    end
    hoa_loss_by_team
  end

  def hoa_tie_by_team(hoa)
    hoa_tie_by_team = Hash.new(0)
    game_teams.find_all do |game|
      if hoa.downcase == game.hoa && game.result == "TIE"
        hoa_tie_by_team[game.team_id] += 1
      else
        hoa_tie_by_team[game.team_id] += 0
      end
    end
    hoa_tie_by_team
  end
end
