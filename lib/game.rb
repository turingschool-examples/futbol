class Game
  attr_reader :game_id,
              :away_goals,
              :home_goals,
              :season

  def initialize(raw_data)
    @game_id = raw_data[:game_id]
    @season = raw_data[:season]
    # @type = raw_data[:type]
    # @date_time = raw_data[:date_time]
    # @away_team_id = raw_data[:away_team_id]
    # @home_team_id = raw_data[:home_team_id]
    @away_goals = raw_data[:away_goals].to_i
    @home_goals = raw_data[:home_goals].to_i
    # @venue = raw_data[:venue]
    # @venue_link = raw_data[:venue_link]
  end
end
