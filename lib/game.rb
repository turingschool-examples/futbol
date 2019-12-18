require 'csv'

class Game
  attr_reader :game_id,
              :season,
              :type,
              :date_time,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals,
              :venue,
              :venue_link

@@games = []

  def self.from_csv(file_path)
    csv = CSV.read(file_path, headers: true, header_converters: :symbol)
    @@games = csv.map do |row|
      Game.new(row)
    end
  end

  def initialize(game_info)
    @game_id  = game_info[:game_id].to_i
    @season  = game_info[:season].to_i
    @type  = game_info[:type]
    @date_time = game_info[:date_time]
    @away_team_id = game_info[:away_team_id].to_i
    @home_team_id = game_info[:home_team_id].to_i
    @away_goals = game_info[:away_goals].to_i
    @home_goals = game_info[:home_goals].to_i
    @venue = game_info[:venue]
    @venue_link = game_info[:venue_link]
  end

  def self.highest_total_score
    most_goals = @@games.max_by do |game|
      game.home_goals + game.away_goals
    end
    most_goals.home_goals + most_goals.away_goals
  end

  def self.lowest_total_score
    least_goals = @@games.min_by do |game|
      game.home_goals + game.away_goals
    end
    least_goals.home_goals + least_goals.away_goals
  end

  def self.count_of_games_by_season
    @@games.reduce({}) do |acc, game_1|
      games_per_season = @@games.find_all do |game_2|
        game_2.season == game_1.season
      end
      acc[game_1.season] = games_per_season.length
      acc
    end
  end

  def self.average_goals_per_game
    total_games = 0
    total_goals = @@games.reduce(0) do |acc, game|
      total_games += 1
      acc += game.away_goals
      acc += game.home_goals
    end
    total_goals.to_f/total_games
  
  def self.average_goals_by_season
    goal_count_per_season = @@games.reduce({}) do |acc, game_1|
      games_per_season = @@games.find_all do |game_2|
        game_2.season == game_1.season
      end
      acc[game_1.season] = games_per_season.sum do |game|
        game.home_goals + game.away_goals
      end
      acc
    end
    count_of_games_by_season.merge(goal_count_per_season) do |key, game_count, goal_count|
      goal_count / game_count.to_f.round(2)
    end
  end
end
