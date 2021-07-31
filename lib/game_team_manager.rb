require 'CSV'
require './lib/game_team'
require 'pry'

class GameTeamManager
  attr_reader :game_teams

  def initialize(file_path)
    @file_path = file_path
    @game_teams = {}
    load
  end

  def load
    data = CSV.read(@file_path, headers: true)
    data.each do |row|
      if @game_teams[row["game_id"]].nil?
        @game_teams[row["game_id"]] = {away: GameTeam.new(row)}
      else
        @game_teams[row["game_id"]][:home] = GameTeam.new(row)
      end
    end
  end

  def total_games_all_seasons(team_id)
    total = 0
    @game_teams.each do |game_id, teams|
      teams.each do |hoa, team|
        total += 1 if team_id == team.team_id
      end
    end
    total
  end

  def total_goals_all_seasons(team_id)
    total = 0
    @game_teams.each do |game_id, teams|
      teams.each do |hoa, team|
        total += team.goals.to_i if team_id == team.team_id
      end
    end
    total
  end

  def average_goals_all_seasons(team_id)
    average = total_goals_all_seasons(team_id) / total_games_all_seasons(team_id).to_f
    average.round(2)
  end

  def best_offense(teams_by_id)
    best_average = 0
    best_team = nil
    teams_by_id.each do |team_id, team_name|
      average = average_goals_all_seasons(team_id)
      if average > best_average
        best_average = average
        best_team = team_name
      end
    end
    best_team
  end

  def worst_offense(teams_by_id)
    worst_average = 100000
    worst_team = nil
    teams_by_id.each do |team_id, team_name|
      average = average_goals_all_seasons(team_id)
      if average < worst_average
        worst_average = average
        worst_team = team_name
      end
    end
    worst_team
  end
end
