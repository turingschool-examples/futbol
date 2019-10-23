require 'csv'


class Games
  attr_reader :game_id, :season, :type, :date_time, :away_team_id, :home_team_id, :away_goals, :home_goals, :venue, :venue_link

  def initialize(game_id, season, type, date_time, away_team_id, home_team_id, away_goals, home_goals, venue, venue_link)
    @game_id = game_id
    @season = season
    @type = type
    @date_time = date_time
    @away_team_id = away_team_id
    @home_team_id = home_team_id
    @away_goals = away_goals
    @home_goals = home_goals
    @venue = venue
    @venue_link = venue_link
  end

  def self.create(file_path)
    @games = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @games << self.new(row[:game_id],
                        row[:season],
                        row[:type],
                        row[:date_time],
                        row[:away_team_id],
                        row[:home_team_id],
                        row[:away_goals].to_i,
                        row[:home_goals].to_i,
                        row[:venue],
                        row[:venue_link])
    end
    @games
  end


end
