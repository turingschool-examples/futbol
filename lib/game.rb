require_relative 'loadable'

class Game
  extend Loadable

  def self.from_csv(file_path)
    @@all = []
    load_csv(file_path, self)
  end


  def self.all
    @@all
  end

  attr_reader :game_id, :season, :type, :date_time,
              :away_team_id, :home_team_id, :away_goals,
              :home_goals, :venue, :venue_link

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
