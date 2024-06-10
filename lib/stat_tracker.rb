require_relative './game_teams.rb'
require_relative './games.rb'
require_relative './teams.rb'

class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(game_teams, games, teams)
    @game_teams = game_teams
    @games = games
    @teams = teams
  end

  def self.from_csv(locations)
    game_teams = GameTeams.create_game_teams_data_objects(locations[:game_teams])
    games = Games.create_games_data_objects(locations[:games])
    teams = Teams.create_teams_data_objects(locations[:teams])

    StatTracker.new(game_teams, games, teams)
  end

  #Game Statistics

  def highest_total_score
    @games.map { |game| game.away_goals + game.home_goals }.max
  end

  def lowest_total_score
    @games.map { |game| game.away_goals + game.home_goals }.min
  end

  def percentage_home_wins
    total_games = @games.length
    home_wins = @games.count { |game| game.home_goals > game.away_goals }
    (home_wins.to_f / total_games).round(2)
  end

  def percentage_visitor_wins
    total_games = @games.length
    away_wins = @games.count { |game| game.away_goals > game.home_goals }
    (away_wins.to_f / total_games).round(2)
  end

  def percentage_ties
    total_games = @games.length
    tie_games = @games.count { |game| game.home_goals == game.away_goals }
    (tie_games.to_f / total_games).round(2)
  end

  def count_of_games_by_season
    games_by_season = Hash.new(0)
    @games.each do |game|
        games_by_season[game.season] += 1
    end
    games_by_season
  end

  def average_goals_per_game
    total_games = @games.length
    total_goals = games.sum { |game| game.home_goals + game.away_goals}
    (total_goals.to_f / total_games).round(2)
  end

  def average_goals_by_season
    total_goals_by_season = Hash.new(0)
    total_games_by_season = Hash.new(0)
    @games.each do |game|
      total_goals_by_season[game.season] += game.home_goals + game.away_goals
      total_games_by_season[game.season] += 1
      total_goals_by_season[game.season] += game.home_goals + game.away_goals
      total_games_by_season[game.season] += 1
    end
    average_goals_by_season = {}
    total_goals_by_season.each_key do |season|
      average_goals_by_season[season] = (total_goals_by_season[season].to_f / total_games_by_season[season]).round(2)
      average_goals_by_season[season] = (total_goals_by_season[season].to_f / total_games_by_season[season]).round(2)
    end
      average_goals_by_season
  end

  #League Statistics
  
  def count_of_teams
    @teams.length
  end

  def best_offense
    total_goals_hash = Hash.new(0)
    @game_teams.each do |game_teams|
      total_goals_hash[game_teams.team_id] = total_goals_hash.fetch(game_teams.team_id, []) << game_teams.goals
    end
    total_goals_hash.each do |team_id, goals_array|
      goals_array.sum
    end
    team_id_goals_array = total_goals_hash.max_by {|_, goals_array| goals_array}
    @teams.each do |team|
      return team.team_name if team.team_id == team_id_goals_array.first
    end
  end

  def worst_offense
    total_goals_hash = Hash.new(0)
    @game_teams.each do |game_teams|
      total_goals_hash[game_teams.team_id] = total_goals_hash.fetch(game_teams.team_id, []) << game_teams.goals
    end
    total_goals_hash.each do |team_id, goals_array|
      goals_array.sum
    end
    team_id_goals_array = total_goals_hash.min_by {|_, goals_array| goals_array}
    @teams.each do |team|
      return team.team_name if team.team_id == team_id_goals_array.first
    end
  end

  def highest_scoring_visitor
    total_away_goals_hash = Hash.new(0)
    @games.each do |game|
      total_away_goals_hash[game.away_team_id] = total_away_goals_hash.fetch(game.away_team_id, []) << game.away_goals
    end
    avg_away_goals_hash = Hash.new(0)
    total_away_goals_hash.map do |away_team_id, goals_scored_array|
      avg_away_goals_hash[away_team_id] = (goals_scored_array.sum.to_f/goals_scored_array.count)
    end
    team_id_goals_array = avg_away_goals_hash.max_by {|_, avg_away_goals| avg_away_goals}
    @teams.each do |team|
      return team.team_name if team.team_id == team_id_goals_array.first
    end
  end

  def lowest_scoring_visitor
    total_away_goals_hash = Hash.new(0)
    @games.each do |game|
      total_away_goals_hash[game.away_team_id] = total_away_goals_hash.fetch(game.away_team_id, []) << game.away_goals
    end
    avg_away_goals_hash = Hash.new(0)
    total_away_goals_hash.map do |away_team_id, goals_scored_array|
      avg_away_goals_hash[away_team_id] = (goals_scored_array.sum.to_f/goals_scored_array.count)
    end
    team_id_goals_array = avg_away_goals_hash.min_by {|_, avg_away_goals| avg_away_goals}
    @teams.each do |team|
      return team.team_name if team.team_id == team_id_goals_array.first
    end
  end

  def highest_scoring_home_team
    total_home_goals_hash = Hash.new(0)
    @games.each do |game|
      total_home_goals_hash[game.home_team_id] = total_home_goals_hash.fetch(game.home_team_id, []) << game.home_goals
    end
    avg_home_goals_hash = Hash.new(0)
    total_home_goals_hash.map do |home_team_id, goals_scored_array|
      avg_home_goals_hash[home_team_id] = (goals_scored_array.sum.to_f/goals_scored_array.count)
    end
    team_id_goals_array = avg_home_goals_hash.max_by {|_, avg_home_goals| avg_home_goals}
    @teams.each do |team|
      return team.team_name if team.team_id == team_id_goals_array.first
    end
  end

  def lowest_scoring_home_team
    total_home_goals_hash = Hash.new(0)
    @games.each do |game|
      total_home_goals_hash[game.home_team_id] = total_home_goals_hash.fetch(game.home_team_id, []) << game.home_goals
    end
    avg_home_goals_hash = Hash.new(0)
    total_home_goals_hash.map do |home_team_id, goals_scored_array|
      avg_home_goals_hash[home_team_id] = (goals_scored_array.sum.to_f/goals_scored_array.count)
    end
    team_id_goals_array = avg_home_goals_hash.min_by {|_, avg_home_goals| avg_home_goals}
    @teams.each do |team|
      return team.team_name if team.team_id == team_id_goals_array.first
    end
  end

  #Season Statistics

  def most_accurate_team(season_id) #does not pass
    total_shots_in_a_season = {}
    total_goals_in_a_season = {}
    team_accuracy = {}
    @game_teams.each do |game, season|
      total_shots_in_a_season[game.team_id] = total_shots_in_a_season.fetch(game.team_id, []) << game.shots
      total_goals_in_a_season[game.team_id] = total_goals_in_a_season.fetch(game.team_id, []) << game.goals
    end
    team_accuracy.map do |team_id, accuracy_array|
      team_accuracy[team_id] = (total_goals_in_a_season.sum.to_f/total_shots_in_a_season.sum)
    end
    team_id_accuracy_array = team_accuracy.max_by {|__, accuracy| accuracy}
    @teams.each do |team|
      return team.team_name if team.team_id == team_id_accuracy_array.first
    end
  end

  def least_accurate_team(season_id) #does not pass
    total_shots_in_a_season = {}
    total_goals_in_a_season = {}
    team_accuracy = {}
    @game_teams.each do |game, season|
      if season == season
        total_shots_in_a_season[game.team_id] = total_shots_in_a_season.fetch(game.team_id, []) << game.shots
        total_goals_in_a_season[game.team_id] = total_goals_in_a_season.fetch(game.team_id, []) << game.goals
      end
    end
    team_accuracy.map do |team_id, accuracy_array|
      team_accuracy[team_id] = (total_goals_in_a_season.sum.to_f/total_shots_in_a_season.sum)
    end
    team_id_accuracy_array = team_accuracy.min_by {|__, accuracy| accuracy}
    @teams.each do |team|
      return team.team_name if team.team_id == team_id_accuracy_array.first
    end
  end

  def winningest_coach(season_id) #does not pass
    coach_wins = Hash.new(0)
    season_games = games.select { |game| game.season == season_id }
    season_games.each do |game|
      if game.home_goals > game.away_goals
        winning_team_id = game.home_team_id
      else
        winning_team_id = game.away_team_id
      end
      winning_team = teams.find { |team| team.team_id == winning_team_id } 
      winning_coach = winning_team.head_coach if winning_team
      coach_wins[winning_coach] += 1 if winning_coach
    end
    winningest_coach_name = coach_wins.max_by { |_, wins| wins }
    winningest_coach_name.first
  end

  def most_tackles(season) #pass 1 of two spec harness tests
    season_game_hash = Hash.new(0)
    @games.each do |game|
      season_game_hash[game.season] = season_game_hash.fetch(game.season, []) << game.game_id
    end
    season_game_id = season_game_hash.values.flatten
    game_team_array = []
    @game_teams.each do |game_team|
      game_team_array << game_team if season_game_id.include?(game_team.game_id)
    end
    team_id_tackles_hash = Hash.new(0)
    game_team_array.each do |game_team|
      team_id_tackles_hash[game_team.team_id] = team_id_tackles_hash.fetch(game_team.team_id, []) << game_team.tackles
    end
    team_id_total_tackles_hash = Hash.new(0)
    team_id_tackles_hash.map do |team_id, tackles_array|
      team_id_total_tackles_hash[team_id] = tackles_array.sum
    end 
    most_tackles_hash = team_id_total_tackles_hash.max_by do |_, total_tackles|
      total_tackles
    end
    target_team_name = []
    @teams.each do |team|
      target_team_name << team.team_name if team.team_id == most_tackles_hash.first
    end
    target_team_name.first
  end

  def fewest_tackles(season) #does not pass spec_harness
    season_game_hash = Hash.new(0)
    @games.each do |game|
      season_game_hash[game.season] = season_game_hash.fetch(game.season, []) << game.game_id
    end
    season_game_id = season_game_hash.values.flatten
    game_team_array = []
    @game_teams.each do |game_team|
      game_team_array << game_team if season_game_id.include?(game_team.game_id)
    end
    team_id_tackles_hash = Hash.new(0)
    game_team_array.each do |game_team|
      team_id_tackles_hash[game_team.team_id] = team_id_tackles_hash.fetch(game_team.team_id, []) << game_team.tackles
    end
    team_id_total_tackles_hash = Hash.new(0)
    team_id_tackles_hash.map do |team_id, tackles_array|
      team_id_total_tackles_hash[team_id] = tackles_array.sum
    end 
    fewest_tackles_hash = team_id_total_tackles_hash.min_by do |_, total_tackles|
      total_tackles
    end
    target_team_name = []
    @teams.each do |team|
      target_team_name << team.team_name if team.team_id == fewest_tackles_hash.first
    end
    target_team_name.first
  end

end

