class Game

  attr_reader :game_id, :season, :type, :date_time, :away_team_id,
              :home_team_id, :away_goals, :home_goals, :venue, :venue_link
  def initialize(csv_row)
    @game_id = csv_row[:game_id]
    @season = csv_row[:season]
    @type = csv_row[:type]
    @date_time = csv_row[:date_time]
    @away_team_id = csv_row[:away_team_id]
    @home_team_id = csv_row[:home_team_id]
    @away_goals = csv_row[:away_goals]
    @home_goals = csv_row[:home_goals]
    @venue = csv_row[:venue]
    @venue_link = csv_row[:venue_link]
  end

end
