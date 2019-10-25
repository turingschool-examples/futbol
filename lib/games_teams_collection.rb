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

  # Helper method designed to be reusable; consider moving to a parent Collection class
  def find_by_in(element, attribute, collection)
    collection.find_all { |member| member.send(attribute) == element }
  end

  # Helper method designed to be reusable; consider moving to a parent Collection class
  def total_found_by_in(element, attribute, collection)
    find_by_in(element, attribute, collection).length
  end

  # Helper method
  def games_with_team(team_id)
    find_by_in(team_id, "team_id", @games_teams)
  end

  # Helper method
  def total_games_with_team(team_id)
    total_found_by_in(team_id, "team_id", @games_teams)
  end

  # Helper method
  def total_wins_of_team(team_id)
    games_with_team(team_id).count { |game_team| game_team.result == "WIN" }
  end

  # Helper method designed to be reusable; consider moving to a stats module
  def percent_of(numerator, denominator)
    ((numerator / denominator.to_f) * 100).round(2)
  end

  # Helper method
  def team_win_percentage(team_id)
    percent_of(total_wins_of_team(team_id), total_games_with_team(team_id))
  end

  # Helper method designed to be reusable; consider moving to a module
  def every(attribute, collection)
    collection.map { |element| element.send(attribute) }
  end

  # Helper method designed to be reusable; consider moving to a module
  def every_unique(attribute, collection)
    every(attribute, collection).uniq
  end

  # Helper method
  def all_team_ids
    every_unique("team_id", @games_teams)
  end

  # Core helper method for several Iteration 3 methods
  def team_id_with_best_win_percentage
    all_team_ids.max_by { |team_id| team_win_percentage(team_id) }
  end

  # Helper method
  def away_games_of_team(team_id)
    find_by_in(team_id, "team_id", find_by_in("away", "hoa", @games_teams))
  end

  # Helper method
  def home_games_of_team(team_id)
    find_by_in(team_id, "team_id", find_by_in("home", "hoa", @games_teams))
  end

  # Helper method
  def number_of_wins_in(collection)
    collection.count { |game_team| game_team.result == "WIN" }
  end

  # Helper method
  def team_home_win_percentage(team_id)
    percent_of(number_of_wins_in(home_games_of_team(team_id)), home_games_of_team(team_id).length)
  end

  # Helper method
  def team_away_win_percentage(team_id)
    percent_of(number_of_wins_in(away_games_of_team(team_id)), home_games_of_team(team_id).length)
  end

  def team_with_best_home_win_percentage
    all_team_ids.max_by do |team_id|
      team_home_win_percentage(team_id)
    end
  end

  def teams_with_better_away_win_percentage_than_home
    all_team_ids.find_all do |team_id|
      team_home_win_percentage(team_id) < team_away_win_percentage(team_id)
    end
  end
end
