require 'csv'
require './lib/csv_loadable'
require './lib/team'

class Games < Team
  extend CsvLoadable

  @@all_games = []

  def self.all
    @@all_games
  end

  attr_reader :game_id,
              :season,
              :type,
              :date_time,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals,
              :venue

  def self.from_csv(file_path)
    @@all_games = load_from_csv(file_path, Games)
  end

  def initialize(game_info)
    @game_id = game_info[:game_id].to_i
    @season = game_info[:season].to_i
    @type = game_info[:type]
    @date_time = game_info[:date_time]
    @away_team_id = game_info[:away_team_id].to_i
    @home_team_id = game_info[:home_team_id].to_i
    @away_goals = game_info[:away_goals].to_i
    @home_goals = game_info[:home_goals].to_i
    @venue = game_info[:venue]
  end

  def self.highest_total_score
    #refactor later
    max = @@all_games.max_by {|game| game.away_goals + game.home_goals }
    max_score = (max.away_goals + max.home_goals)
  end

  def self.lowest_total_score
    #refactor later
    min = @@all_games.min_by {|game| game.away_goals + game.home_goals }
    min_score = (min.away_goals + min.home_goals)
  end

  def self.biggest_blowout
    #refactor later
    difference = @@all_games.max_by {|game| (game.away_goals - game.home_goals).abs }
    difference_absolutely = (difference.away_goals - difference.home_goals).abs
  end

  def self.percentage_home_wins
    #refactor later
    home_wins = @@all_games.find_all {|game| game.home_goals > game.away_goals }
    (home_wins.length / @@all_games.length.to_f).round(2)
  end

  def self.percentage_visitor_wins
    #refactor later
    vis_wins = @@all_games.find_all {|game| game.home_goals < game.away_goals }
    (vis_wins.length / @@all_games.length.to_f).round(2)
  end

  def self.percentage_ties
    #refactor later
    ties = @@all_games.find_all {|game| game.home_goals == game.away_goals }
    (ties.length / @@all_games.length.to_f).round(2)
  end

  def self.count_of_games_by_season
    @@all_games.reduce({}) do |hash, game|
      if hash.keys.include?(game.season)
        hash[game.season] += 1
        hash
      else
        hash[game.season] = 1
        hash
      end
    end
  end

  def self.average_goals_per_game
    sums = @@all_games.sum do |game|
      (game.away_goals + game.home_goals)
    end
    (sums / @@all_games.length.to_f).round(2)
  end

  def self.average_goals_by_season
    games_by_season = count_of_games_by_season
    @@all_games.reduce({}) do |hash, game|
      if hash.keys.include?(game.season)
        hash[game.season] += ((game.away_goals + game.home_goals) / games_by_season[game.season].to_f).round(2)
        hash
      else
        hash[game.season] = ((game.away_goals + game.home_goals) / games_by_season[game.season].to_f).round(2)
        hash
      end
    end
  end

  # Start of iteration 3
  def self.count_of_teams
    @@all_teams.count
  end

  def self.best_offense
    # go through games and teams
    # get all goals scored for that team and divide by game count
    # Find highest average
    # return that team name

    team_id_scores = @@all_teams.reduce({}) do |hash, team|
      hash[team.team_id] = []
      hash
    end

    @@all_teams.each do |team|
      @@all_games.each do |game|
        if team.team_id == game.home_team_id
          team_id_scores[team.team_id] << game.home_goals
        elsif team.team_id == game.away_team_id
          team_id_scores[team.team_id] << game.away_goals
        end
      end.compact
    end

    team_id_scores.each do |key, value|
      average = (value.sum / value.count.to_f).round(2)
      team_id_scores[key] = average
    end

    team_id = team_id_scores.key(team_id_scores.values.max)

    team = @@all_teams.find {|team| team.team_name if team.team_id == team_id}
    team_name = team.team_name
  end
end
