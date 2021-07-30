require 'CSV'
require_relative './game'
require_relative './team'
require_relative './game_teams'

class StatTracker
  attr_reader :games, :teams, :game_teams
  def initialize (games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    games = []
    teams = []
    game_teams = []

    CSV.foreach(locations[:games], headers: true, header_converters: :symbol) do |row|
      headers ||= row.headers

      games << Game.new(row)
    end

    CSV.foreach(locations[:teams], headers: true, header_converters: :symbol) do |row|
      headers ||= row.headers

      teams << Team.new(row)

    end

    CSV.foreach(locations[:game_teams], headers: true, header_converters: :symbol) do |row|
      headers ||= row.headers

      game_teams << GameTeams.new(row)
    end

    StatTracker.new(games, teams, game_teams)

  end

  # def highest_total_score
  #   highest_scoring_game =
  #   @games.max_by do |game|
  #     game.away_goals.to_i + game.home_goals.to_i
  #   end
  #   highest_scoring_game.away_goals.to_i + highest_scoring_game.home_goals.to_i
  # end

  # def lowest_total_score
  #   lowest_scoring_game =
  #   @games.min_by do |game|
  #     game.away_goals.to_i + game.home_goals.to_i
  #   end
  #   lowest_scoring_game.away_goals.to_i + lowest_scoring_game.home_goals.to_i
  # end

  # def percentage_home_wins
  #   (home_team_wins.fdiv(@games.length)).round(2)
  # end
  #
  # def percentage_visitor_wins
  #   (visitor_team_wins.fdiv(@games.length)).round(2)
  # end
  #
  # def percentage_ties
  #   (ties.fdiv(@games.length)).round(2)
  # end
  #
  # def home_team_wins
  #   home_wins =
  #   @games.count do |game|
  #     game.home_goals > game.away_goals
  #   end
  #   home_wins
  # end
  #
  # def visitor_team_wins
  #   visitor_wins =
  #   @games.count do |game|
  #     game.home_goals < game.away_goals
  #   end
  #   visitor_wins
  # end
  #
  # def ties
  #   ties =
  #   @games.count do |game|
  #     game.home_goals == game.away_goals
  #   end
  #   ties
  # end
  #
  # def count_of_games_by_season
  #   games_by_season = Hash.new(0)
  #   @games.each do |game|
  #       games_by_season[game.season] += 1
  #   end
  #   games_by_season
  # end
  #
  # def average_goals_per_game
  #   goals = []
  #   @games.each do |game|
  #     goals << game.home_goals.to_i + game.away_goals.to_i
  #   end
  #   goals.sum.fdiv(goals.length).round(2)
  # end
  #
  # def total_goals_by_season
  #   goals_by_season = Hash.new(0)
  #   @games.each do |game|
  #     goals_by_season[game.season] += game.home_goals.to_i + game.away_goals.to_i
  #   end
  #   goals_by_season
  # end
  #
  # def average_goals_by_season
  #   average_goals_by_season = Hash.new(0)
  #   total_goals_by_season.each do |season, goals|
  #     count_of_games_by_season.each do |key, games|
  #       if season == key
  #         average_goals_by_season[season] = goals.fdiv(games).round(2)
  #       end
  #     end
  #   end
  #   average_goals_by_season
  # end
  #
  # def best_offense
  #   acc = {}
  #   @teams.each do |team|
  #     #conditional handles edge cases where there are no games for the teams. Should not be a problem when dealing with the full dataset.
  #                           #this will fail spec suite because we tweaked the csv files to be tame_name instead of taemname
  #     if games_by_team(team[:team_id]).length != 0
  #       acc[games_average(team[:team_id])] = team[:teamname]
  #       # require "pry"; binding.pry
  #     end
  #   end
  #   # require "pry"; binding.pry
  #   acc[acc.keys.max]
  # end
  #
  # #this will hit @game_teams again. Will need refactor to minimize time, nest games_by_team and add denominator count?.
  # def games_average(team_id)
  #   goals_scored = 0.00
  #   games_by_team(team_id).each do |game|
  #     goals_scored += game[:goals].to_i
  #   end
  #   goals_scored / games_by_team(team_id).length
  # end
  #
  # def games_by_team(team_id)
  #   @game_teams.find_all do |game|
  #     game[:team_id] == team_id.to_s
  #   end
  # end

  def team_identifier(id)
    id = '4'
    matching_team =
    @teams.find do |team|
      team.team_id == id
    end
    matching_team.team_name
  end

  def total_shots(season)
    shots_by_team = Hash.new(0)
    season_shorten = season.slice(0..3)
    @game_teams.each do |game|
      if game.game_id.start_with?(season_shorten)
        shots_by_team[game.team_id] += game.shots.to_i
      end
    end
    shots_by_team
  end

  def most_accurate_team(season)
    goals_by_team = Hash.new(0)
    season_shorten = season.slice(0..3)
    @game_teams.each do |game|
      if game.game_id.start_with?(season_shorten)
        goals_by_team[game.team_id] += game.goals.to_i
      end
    end
    accuracy =
      goals_by_team.max_by do |id, goals|
      tot_goals = total_shots(season)[id]
      goals.fdiv(tot_goals)
    end
    team_identifier(accuracy[0])
  end

  def least_accurate_team(season)
    goals_by_team = Hash.new(0)
    season_shorten = season.slice(0..3)
    @game_teams.each do |game|
      if game.game_id.start_with?(season_shorten)
        goals_by_team[game.team_id] += game.goals.to_i
      end
    end
    accuracy =
      goals_by_team.min_by do |id, goals|
      tot_goals = total_shots(season)[id]
      goals.fdiv(tot_goals)
    end
    team_identifier(accuracy[0])
  end

  def total_games_by_coach(season)
    games_by_coach = Hash.new(0)
    season_shorten = season.slice(0..3)
    @game_teams.each do |game|
      if game.game_id.start_with?(season_shorten)
        games_by_coach[game.head_coach] += 1
      end
    end
    games_by_coach
  end

  def winningest_coach(season)
    wins_by_coach = Hash.new(0)
    season_shorten = season.slice(0..3)
    @game_teams.each do |game|
      if game.game_id.start_with?(season_shorten) && game.result == 'WIN'
        wins_by_coach[game.head_coach] += 1
      end
    end
    coach = wins_by_coach.max_by do |coach, wins|
      tot_games = total_games_by_coach(season)[coach]
      wins.fdiv(tot_games)
    end
    coach[0]
  end

  def worst_coach(season)
    losses_by_coach = Hash.new(0)
    season_shorten = season.slice(0..3)
    @game_teams.each do |game|
      if game.game_id.start_with?(season_shorten) && game.result == 'LOSS'
        losses_by_coach[game.head_coach] += 1
      end
    end
    coach = losses_by_coach.max_by do |coach, losses|
      tot_games = total_games_by_coach(season)[coach]
      losses.fdiv(tot_games)
    end
    coach[0]
  end

  def most_tackles(season)
    tackles_by_team = Hash.new(0)
    season_shorten = season.slice(0..3)
    @game_teams.each do |game|
      if game.game_id.start_with?(season_shorten)
        tackles_by_team[game.team_id] += game.tackles.to_i
      end
    end
    team_highest = tackles_by_team.max_by do |team_id, tackles|
      tackles
    end
    team_identifier(team_highest[0])
  end

  def fewest_tackles(season)
    tackles_by_team = Hash.new(0)
    season_shorten = season.slice(0..3)
    @game_teams.each do |game|
      if game.game_id.start_with?(season_shorten)
        tackles_by_team[game.team_id] += game.tackles.to_i
      end
    end
    team_highest = tackles_by_team.min_by do |team_id, tackles|
      tackles
    end
    team_identifier(team_highest[0])
  end
end
