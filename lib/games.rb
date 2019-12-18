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
    @game_id = game_info[:game_id]
    @season = game_info[:season]
    @type = game_info[:type]
    @date_time = game_info[:date_time]
    @away_team_id = game_info[:away_team_id]
    @home_team_id = game_info[:home_team_id]
    @away_goals = game_info[:away_goals]
    @home_goals = game_info[:home_goals]
    @venue = game_info[:venue]
  end
end
