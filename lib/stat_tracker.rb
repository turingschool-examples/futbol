require 'CSV'

class StatTracker
    attr_reader

    def initialize(game_id, season, type, date_time, away_team, home_team_id, away_goals, home_goals, venue, venue_link)
        @game_id = game_id
        @season = season
        @type = type
        @date_time = date_time
        @away_team = away_team
        @home_team_id = home_team_id
        @away_goals = away_goals
        @home_goals = home_goals
        @venue = venue
        @venue_link = venue_link
    end

    def self.from_csv(locations)
    stats = []

    CSV.foreach(locations[:games], headers: true, header_converters: :symbol) do |row|
        stat_tracker = StatTracker.new(
            row[:game_id].to_i,
            row[:season],
            row[:type],
            row[:date_time],
            row[:away_team],
            row[:home_team_id],
            row[:away_goals].to_i,
            row[:home_goals].to_i,
            row[:venue],
            row[:venue_link]
        )
        stats << stat_tracker
    end
    stats
    end
end