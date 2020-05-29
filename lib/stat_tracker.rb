require_relative './game'
require_relative './team'
require_relative './game_teams'
require_relative './team_collection'
require 'csv'
require 'pry'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams


  def self.from_csv(csv_files)
    games = create_games(csv_files[:games])
    teams = create_teams(csv_files[:teams])
    game_teams = create_game_teams(csv_files[:game_teams])
    StatTracker.new(games, teams, game_teams)
  end

  def self.create_games(game_file)
    games = []
    CSV.foreach(game_file, headers: true, header_converters: :symbol) do |row|
      games << Game.new(row)
    end
    games
  end

  def self.create_teams(team_file)
    teams = []
    CSV.foreach(team_file, headers: true, header_converters: :symbol) do |row|
      teams << Team.new(row)
    end
    teams
  end

  def self.create_game_teams(game_teams_file)
    game_teams = []
    CSV.foreach(game_teams_file, headers: true, header_converters: :symbol) do |row|
      game_teams << GameTeams.new(row)
    end
    game_teams
  end

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def highest_total_score
    sum_total_score = []
    games.each do |game|
        sum_total_score << game.away_goals.to_i + game.home_goals.to_i
    end
    sum_total_score.max
  end

  def lowest_total_score
    sum_total_score = []
    games.each do |game|
        sum_total_score << game.away_goals.to_i + game.home_goals.to_i
    end
    sum_total_score.min
  end

  def percentage_home_wins
    home_wins = []
    games.each do |game|
      home_wins << game if game.home_goals > game.away_goals
    end
    percentage_of_home_wins = home_wins.count.to_f / games.count.to_f * 100
    percentage_of_home_wins.round(2)
  end

  def percentage_visitor_wins
    visitor_wins = []
    games.each do |game|
      visitor_wins << game if game.home_goals < game.away_goals
    end
    percentage_of_visitor_wins = visitor_wins.count.to_f / games.count.to_f * 100
    percentage_of_visitor_wins.round(2)
  end

  def percentage_ties
    ties = []
    games.each do |game|
      ties << game if game.home_goals == game.away_goals
    end
    percentage_of_ties = ties.count.to_f / games.count.to_f * 100
    percentage_of_ties.round(2)
  end

  def count_of_games_by_season
    games_by_season = @games.group_by do |game|
      game.season
    end
    games_by_season.transform_values do |game|
      game.length
    end
  end

  def average_goals_per_game
    sum_total_score = 0
    games.each do |game|
        sum_total_score += game.away_goals.to_i + game.home_goals.to_i
      end
      average_goals_per_game = sum_total_score / (games.count * 2).to_f
      average_goals_per_game.round(2)
  end

  def average_goals_by_season
    games_by_season = @games.group_by do |game|
      game.season
    end
    games_by_season.transform_values do |game|
      sum_total_score = 0
      game.each do |game|
        sum_total_score += game.away_goals.to_i + game.home_goals.to_i
      end
      average_goals_per_season = sum_total_score / (game.count * 2).to_f
      average_goals_per_season.round(2)
    end
  end

  ## start of league statistics

  def count_of_teams
    teams.count
  end

  def best_offense
    id_score = Hash.new(0)
    games.map do |game|
      id_score[game.away_team_id] += game.away_goals.to_i
      id_score[game.home_team_id] += game.home_goals.to_i
    end
      id = id_score.key(id_score.values.max)
      found = teams.find do |team|
        if team.team_id == id
           return team.team_name
        end
      found
    end
  end

  def worst_offense
    id_score = Hash.new(0)
    games.map do |game|
      id_score[game.away_team_id] += game.away_goals.to_i
      id_score[game.home_team_id] += game.home_goals.to_i
    end
      id = id_score.key(id_score.values.min)
      found = teams.find do |team|
        if team.team_id == id
           return team.team_name
        end
      found
    end
  end

  def number_of_games_played_away_team
    games_played = games.reduce(Hash.new(0)) do |team, game|
      team[game.away_team_id] += 1
      team
    end
  end

  def number_of_games_played_home_team
    games_played = games.reduce(Hash.new(0)) do |team, game|
      team[game.home_team_id] += 1
      team
    end
  end

  def highest_scoring_visitor
    away_team_goals = games.reduce(Hash.new(0)) do |team, game|
      team[game.away_team_id] += game.away_goals.to_f
      team
    end
     away_team_goals.merge!(number_of_games_played_away_team) { |k, o, n| o / n }
     away_team_goals
     id = away_team_goals.key(away_team_goals.values.max)
     found = teams.find do |team|
       if team.team_id == id
          return team.team_name
       end
     found
   end
  end

  def highest_scoring_home_team
    home_team_goals = games.reduce(Hash.new(0)) do |team, game|
      team[game.home_team_id] += game.home_goals.to_f
      team
    end
    home_team_goals.merge!(number_of_games_played_home_team) { |k, o, n| o / n }
    home_team_goals
    id = home_team_goals.key(home_team_goals.values.max)
    found = teams.find do |team|
      if team.team_id == id
        return team.team_name
        found
      end
    end
  end


  ### Begin team stat methods

  def team_info(team_id)
    x = {}
    teams.find_all do |team|
      if team.team_id == team_id.to_s
        x = team.instance_variables.each_with_object({}) { |var, hash| hash[var.to_s.delete("@")] = team.instance_variable_get(var) }
        return x
      end
    end
  end

  def find_number_of_games_played_in_a_season(team_id)
    games_played_that_season = Hash.new(0)
    game_teams.find_all do |team|
      if team.team_id == team_id.to_s
        if team.result == "WIN" || "TIE" || "LOSS"
          games_played_that_season[team.game_id.slice(0...4)] += 1.to_f
        end
      end
    end
    games_played_that_season
  end

  def best_season(team_id)
    games_won_that_season = Hash.new(0)
    game_teams.find_all do |team|
      if team.team_id == team_id.to_s
        if team.result == "WIN"
          games_won_that_season[team.game_id.slice(0...4)] += 1.to_f
        end
      end
    end
    games_won_that_season.merge!(find_number_of_games_played_in_a_season(team_id)) { |k, o, n| o / n }
    ((games_won_that_season.key(games_won_that_season.values.max) * 2).to_i + 1).to_s
  end

  def worst_season(team_id)
    games_lost_that_season = Hash.new(0)
    game_teams.find_all do |team|
      if team.team_id == team_id.to_s
        if team.result == "LOSS"
          games_lost_that_season[team.game_id.slice(0...4)] += 1.to_f
        end
      end
    end
    games_lost_that_season.merge!(find_number_of_games_played_in_a_season(team_id)) { |k, o, n| o / n }
    ((games_lost_that_season.key(games_lost_that_season.values.min) * 2).to_i + 1).to_s
  end

  def average_win_percentage(team_id)
    games_won_that_season = Hash.new(0)
    game_teams.find_all do |team|
      if team.team_id == team_id.to_s
        if team.result == "WIN"
          games_won_that_season[team.game_id.slice(0...4)] += 1.to_f
        end
      end
    end
    (games_won_that_season.values.sum / find_number_of_games_played_in_a_season(team_id).values.sum * 100).round(2)
  end

  def goals_scored(team_id)
    highest_goals = []
      game_teams.map do |team|
        if team.team_id == team_id.to_s
        highest_goals << team.goals.to_i
      end
    end
    highest_goals
  end

  def most_goals_scored(team_id)
    goals_scored(team_id).max
  end

  def fewest_goals_scored(team_id)
    goals_scored(team_id).min
  end
end
