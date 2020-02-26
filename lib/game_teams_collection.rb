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

  def total_loss_by_team
    total_loss = Hash.new(0)
    game_teams.each do |game|
      if game.result == "LOSS"
        total_loss[game.team_id] += 1
      elsif game.result == "WIN"
        total_loss[game.team_id] =+ 0
      end
    end
    total_loss
  end

  def total_tie_by_team
    total_loss = Hash.new(0)
    game_teams.each do |game|
      if game.result == "TIE"
        total_loss[game.team_id] += 1
      elsif game.result == "WIN"
        total_loss[game.team_id] =+ 0
      elsif game.result == "LOSS"
        total_loss[game.team_id] += 0
      end
    end
    total_loss
  end
end
