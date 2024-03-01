require 'CSV'

class Game
  @@all = []
  attr_reader :game_id,
              :season,
              :type,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals

  def initialize(game_data)
    @game_id = game_data[:game_id]
    @season = game_data[:season]
    @type = game_data[:type].to_s
    @away_team_id = game_data[:away_team_id]
    @home_team_id = game_data[:home_team_id]
    @away_goals = game_data[:away_goals]
    @home_goals = game_data[:home_goals]
  end

  def self.create_from_csv(file_path)
    CSV.foreach(file_path, headers: true, converters: :all) do |row|
      game_data = {
        game_id: row["game_id"],
        season: row["season"],
        type: row["type"],
        away_team_id: row["away_team_id"],
        home_team_id: row["home_team_id"],
        away_goals: row["away_goals"],
        home_goals: row["home_goals"]
      }
    @@all << Game.new(game_data)
    end
    @@all
  end

  def self.all
    @@all
  end

  def self.percentage_home_wins
    home_win_counter = 0
    @@all.each do |game|
      if game.home_goals > game.away_goals
        home_win_counter += 1
      end
    end
    (home_win_counter / @@all.length.to_f).round(2) # 3237 / 7441
  end

  def self.percentage_visitor_wins
    visitor_win_counter = 0
    @@all.each do |game|
      if game.away_goals > game.home_goals
        visitor_win_counter += 1
      end
    end
    (visitor_win_counter / @@all.length.to_f).round(2) # 2687 / 7441
  end

  def self.percentage_ties
    tie_counter = 0
    @@all.each do |game|
      if game.away_goals == game.home_goals
        tie_counter += 1
      end
    end
    (tie_counter / @@all.length.to_f).round(2) # 1517 / 7441
  end

  def self.count_of_games_by_season
    season_counts = Hash.new(0)
    @@all.each do |game|
      season_counts[game.season] += 1
    end
    season_counts
  end

  def self.count_of_goals_by_season
    goals_count = Hash.new(0)
    @@all.each do |game|
      goals_count[game.season] += game.away_goals + game.home_goals
    end
    goals_count
  end

  def self.average_goals_by_season
    goals_per_season = Hash.new(0)

    games_count = count_of_games_by_season
    goals_count = count_of_goals_by_season

    games_count.each_key do |season|
      goals_per_season[season] = (goals_count[season].to_f / games_count[season]).round(2)
    end
    goals_per_season
  end

  def average_goals_per_game
    total_goals = self.games.map do |game|
        (game.away_goals.to_f + game.home_goals)
    end.sum
    (total_goals / games.count).round(2)
  end
end