require_relative './csv_helper'
require 'pry'

class SeasonStatistics
  def self.set_seasoncsv(games, game_teams, teams)
    @@games = CSVHelper.gamesCSV(games)
    @@game_teams = CSVHelper.game_teamsCSV(game_teams)
    @@teams = CSVHelper.teamsCSV(teams)
  end

  def self.winningest_coach(season)
    season_games = self.game_teams_in_season(season)
    season_coaches = self.sort_coach_games(season_games)
    season_wins = self.coaches_wins(season_coaches)

    season_wins.max_by { |coach, win_percentage| win_percentage }[0]

  end

  def self.worst_coach(season)
    season_games = self.game_teams_in_season(season)
    season_coaches = self.sort_coach_games(season_games)
    season_wins = self.coaches_wins(season_coaches)

    season_wins.min_by { |coach, win_percentage| win_percentage }[0]
  end

  def self.most_accurate_team(season)
    season_games = self.game_teams_in_season(season)
    season_teams = self.sort_team_games(season_games)
    season_accuracy = self.teams_accuracy(season_teams)

    most_accurate_team_id = season_accuracy.max_by { |team_id, accuracy| accuracy }[0]
    @@teams.select { |team| team.team_id == most_accurate_team_id }[0].team_name
  end

  def self.least_accurate_team(season)
    season_games = self.game_teams_in_season(season)
    season_teams = self.sort_team_games(season_games)
    season_accuracy = self.teams_accuracy(season_teams)

    least_accurate_team_id = season_accuracy.min_by { |team_id, accuracy| accuracy }[0]
    @@teams.select { |team| team.team_id == least_accurate_team_id }[0].team_name
  end

  def self.most_tackles(season)
    season_game_teams = self.game_teams_in_season(season)
    tackles_per_team = Hash.new(0)
    
    season_game_teams.each do |game_team|
      tackles_per_team[game_team.team_id] += game_team.tackles
    end
    
    most_tackles = tackles_per_team.max_by { |team_id, tackles| tackles }[0]
    @@teams.find do |team|
      team.team_id == most_tackles
    end.team_name
  end

  def self.fewest_tackles(season)
    season_game_teams = self.game_teams_in_season(season)
    tackles_per_team = Hash.new(0)
    
    season_game_teams.each do |game_team|
      tackles_per_team[game_team.team_id] += game_team.tackles
    end
    
    fewest_tackles = tackles_per_team.min_by { |team_id, tackles| tackles }[0]
    @@teams.find do |team|
      team.team_id == fewest_tackles
    end.team_name
  end
  
  private

  def self.game_teams_in_season(season)
    games = @@games.find_all { |game| game.season == season.to_i }.map { |game| game.game_id }

    @@game_teams.find_all { |game| games.include?(game.game_id) }
  end

  def self.sort_team_games(games)
    team_ids = StatsHelper.team_ids
    teams = {}

    team_ids.each { |team_id| teams[team_id] = [] }

    games.each { |game| teams[game.team_id] << game }

    teams
  end

  def self.teams_accuracy(teams)
    accuracy = {}
    
    teams.each do |team_id, games|

      next if games.size == 0

      total_accuracy = games.sum { |game| game.goals.to_f / game.shots }
      accuracy[team_id] =  total_accuracy / games.size
    end
    accuracy
  end

  def self.sort_coach_games(games)
    head_coaches = StatsHelper.coaches
    coaches_games = {}

    head_coaches.each { |coach| coaches_games[coach] = [] }

    games.each { |game| coaches_games[game.head_coach] << game }

    coaches_games
  end

  def self.coaches_wins(coaches)
    
    coaches_wins = {}

    coaches.each do |coach, games|
      next if games.size == 0
      wins = games.count { |game| game.result == 'WIN' }
      coaches_wins[coach] = wins.to_f / games.count
    end

    coaches_wins
  end
end