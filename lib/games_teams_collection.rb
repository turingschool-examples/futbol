require_relative 'game_team'
require 'csv'

class GamesTeamsCollection
  attr_reader :games_teams

  def initialize(games_teams_path)
    @games_teams = generate_objects_from_csv(games_teams_path)
  end

  def generate_objects_from_csv(csv_file_path)
    objects = []
    CSV.foreach(csv_file_path, headers: true, header_converters: :symbol) do |row_object|
      objects << GameTeam.new(row_object)
    end
    objects
  end

  def total_home_games
    @games_teams.count do |game_team|
      game_team.hoa == 'home'
    end
  end

  def total_home_wins
    @games_teams.count do |game_team|
      game_team.hoa == 'home' && game_team.result == 'WIN'
    end
  end

  def percentage_home_wins
    ((total_home_wins / total_home_games.to_f) * 100).round(2)
  end

  def total_away_games
    @games_teams.count do |game_team|
      game_team.hoa == 'away'
    end
  end

  def total_away_wins
    @games_teams.count do |game_team|
      game_team.hoa == 'away' && game_team.result == 'WIN'
    end
  end

  def percentage_visitor_wins
    ((total_away_wins / total_away_games.to_f) * 100).round(2)
  end

  def total_ties
    @games_teams.count do |game_team|
      game_team.result == 'TIE'
    end
  end

  def percentage_ties
    ((total_ties.to_f / @games_teams.count) * 100).round(2)
  end

  def number_of_wins
    teams = @games_teams.group_by {|game_team| game_team.team_id}
    teams.values.map do |game|
      game.count do |game|
        game.result == "WIN"
      end
    end
  end

  def number_of_losses
    teams = @games_teams.group_by {|game_team| game_team.team_id}
    teams.values.map do |game|
      game.count do |game|
        game.result == "LOSS"
      end
    end
  end

  def biggest_blowout
    difference = []
    number_of_wins.each do |wins|
      number_of_losses.each do |losses|
        difference << wins - losses
      end
    end
    difference.min
  end
end
