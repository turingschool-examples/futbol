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
end
