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
  def self.from_csv(file_path)
    csv = CSV.read("#{file_path}", headers: true, header_converters: :symbol)

    @@all = csv.map do |row|
       Game.new(row)
    end
  end


  def self.all
    @@all
  end

  def initialize(game_info)
    @game_id = game_info[:game_id].to_i
    @season = game_info[:season]
    @type = game_info[:type]
    @date_time = game_info[:date_time]
    @away_team_id = game_info[:away_team_id]
    @home_team_id = game_info[:home_team_id]
    @away_goals = game_info[:away_goals].to_i
    @home_goals = game_info[:home_goals].to_i
    @venue = game_info[:venue]
    @venue_link = game_info[:venue_link]
  end

end
