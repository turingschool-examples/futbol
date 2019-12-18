require 'csv'

class Games

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
    csv = CSV.read("#{file_path}", headers: true, header_converters: :symbol)

    @@all_games = csv.map {|row| Games.new(row)}
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

  def highest_total_score
    #refactor later
    max = @@all_games.max_by {|game| game.away_goals + game.home_goals }
    max_score = (max.away_goals + max.home_goals)
  end

  def lowest_total_score
    #refactor later
    min = @@all_games.min_by {|game| game.away_goals + game.home_goals }
    min_score = (min.away_goals + min.home_goals)
  end

  def biggest_blowout
    #refactor later
    difference = @@all_games.max_by {|game| (game.away_goals - game.home_goals).abs }
    difference_absolutely = (difference.away_goals - difference.home_goals).abs
  end

  def percentage_home_wins
    #refactor later
    home_wins = @@all_games.find_all {|game| game.home_goals > game.away_goals }
    (home_wins.length / @@all_games.length.to_f).round(2)
  end

  def percentage_visitor_wins
    #refactor later
    vis_wins = @@all_games.find_all {|game| game.home_goals < game.away_goals }
    (vis_wins.length / @@all_games.length.to_f).round(2)
  end

  def percentage_ties
    #refactor later
    ties = @@all_games.find_all {|game| game.home_goals == game.away_goals }
    (ties.length / @@all_games.length.to_f).round(2)
  end

  def count_of_games_by_season
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

  def average_goals_per_game
    sums = @@all_games.sum do |game|
      (game.away_goals + game.home_goals)
    end
    (sums / @@all_games.length.to_f).round(2)
  end

  def average_goals_by_season
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
end
