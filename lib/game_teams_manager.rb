require_relative '../lib/game_teams'

class GameTeamsManager

  attr_reader :game_teams_array

  def initialize(game_teams_path)
    @game_teams_array = []

    CSV.foreach(game_teams_path, headers: true) do |row|
      @game_teams_array << GameTeam.new(row)
    end
  end

  def team_average_goals(team_id)
    teams_by_id = @game_teams_array.find_all do |gameteam|
      gameteam.team_id == team_id
    end

    total_goals = teams_by_id.sum do |team|
      team.goals.to_i
    end
    (total_goals.to_f / teams_by_id.size).round(2)
  end

  def teams_sort_by_average_goal
    average = @game_teams_array.sort_by do |team|
      team_average_goals(team.team_id)
    end
  end

  def count_home_games
    home_games = []
    @game_teams_array.each do |game|
      if game.hoa.to_s == 'home'
        home_games << game
      end
    end
    home_games
  end

  def home_game_results(home_games)
    home_wins = []
    home_losses = []
    tie_games = []
    results = {}
    home_games.each do |game|
      home_wins << game.game_id if game.result.to_s == 'WIN'
      home_losses << game.game_id if game.result.to_s == 'LOSS'
      tie_games << game.game_id if game.result.to_s == 'TIE'

    end
    results[:wins] = home_wins
    results[:losses] = home_losses
    results[:ties] = tie_games
    results
  end


  def find_all_away_teams
    @game_teams_array.find_all do |gameteam|
      gameteam.hoa == "away"
    end
  end

  def away_games_by_team_id
    find_all_away_teams.group_by do |game|
      game.team_id
    end
  end

  def highest_visitor_team
    away_games_by_team_id.max_by do |team_id, gameteam|
      gameteam.sum{|game1| game1.goals.to_i} / gameteam.count.to_f
    end
  end

  def lowest_visitor_team
    away_games_by_team_id.min_by do |team_id, gameteam|
      gameteam.sum{|game1| game1.goals.to_i} / gameteam.count.to_f
    end
  end

  def find_all_home_teams
    @game_teams_array.find_all do |gameteam|
      gameteam.hoa == "home"
    end
  end
  def home_games_by_team_id
    find_all_home_teams.group_by do |game|
      game.team_id
    end
  end

  def highest_home_team
    home_games_by_team_id.max_by do |team_id, gameteam|
      gameteam.sum{|game1| game1.goals.to_i} / gameteam.count.to_f
    end
  end

  def lowest_home_team
    home_games_by_team_id.min_by do |team_id, gameteam|
      gameteam.sum{|game1| game1.goals.to_i} / gameteam.count.to_f
    end
  end

  def percentage_home_wins(home_games, home_wins)
    (home_wins.count.to_f/home_games.count.to_f).round(2)
  end
  
  def percentage_visitor_wins(home_games, home_losses)
    (home_losses.count.to_f/home_games.count.to_f).round(2)
  end

  def percentage_ties(home_games, tie_games)
    (tie_games.count.to_f/home_games.count.to_f).round(2)
  end
end
