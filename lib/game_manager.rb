require_relative 'game'
require 'csv'

class GameManager
  attr_reader :games
  def initialize(locations, stat_tracker)
    @stat_tracker = stat_tracker
    @games = generate_games(locations[:games])
    @av = {}
  end

  def generate_games(location)
    array = []
    CSV.foreach(location, headers: true) do |row|
      array << Game.new(row.to_hash)
    end
    array
  end

  def group_by_season
    @games.group_by do |game|
      game.season
    end.uniq
  end

  def best_offense
    avg = return_average_goals_per_game(data_away + data_home)
    team_data[return_max(avg)]["team_name"]
  end

  def worst_offense
    avg = return_average_goals_per_game(data_away + data_home)
    team_data[return_min(avg)]["team_name"]
  end

  def highest_scoring_visitor
    avg = return_average_goals_per_game(data_away)
    team_data[return_max(avg)]["team_name"]
  end

  def highest_scoring_home_team
    avg = return_average_goals_per_game(data_home)
    team_data[return_max(avg)]["team_name"]
  end

  def lowest_scoring_visitor
    avg = return_average_goals_per_game(data_away)
    team_data[return_min(avg)]["team_name"]
  end

  def lowest_scoring_home_team
    avg = return_average_goals_per_game(data_home)
    team_data[return_min(avg)]["team_name"]
  end

  def return_average_goals_per_game(scoredata)
    team_data.keys.each do |team|
      goals = 0
      scoredata.each do |score|
        if score[0] == team
          goals += score[1]
        end
      end
      avghash[team] = (goals.to_f / (scoredata.flatten.count(team))).round(4)
    end
    avghash

  end

  def data_home
    @games.map {|game| [game.home_team_id, game.home_goals]}.to_h
    require "pry"; binding.pry
  end

  def data_away
    @games.map {|game| [game.away_team_id, game.away_goals]}
  end

  def team_data
    @stat_tracker.team_manager.teams_data
  end

  def return_max(hash)
    hash.key(hash.values.max)
  end

  def return_min(hash)
    hash.key(hash.values.min)
  end



end
