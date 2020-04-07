require 'CSV'
class Game
  @@all = []
  attr_reader :game_id, :season,
              :type, :date_time,
              :away_team_id, :home_team_id,
              :away_goals, :home_goals,
              :venue, :venue_link

  def self.from_csv(file_path)
    csv = CSV.read("#{file_path}", headers: true, header_converters: :symbol )
    @@all = csv.map{|row| Game.new(row)}
  end

  def self.all
    @@all
  end

  def initialize(game_details)
    @game_id = game_details[:game_id].to_i
    @season = game_details[:season].to_i
    @type = game_details[:type]
    @date_time = game_details[:date_time]
    @away_team_id = game_details[:away_team_id].to_i
    @home_team_id = game_details[:home_team_id].to_i
    @away_goals = game_details[:away_goals].to_i
    @home_goals = game_details[:home_goals].to_i
    @venue = game_details[:venue]
    @venue_link = game_details[:venue_link]
  end
end
