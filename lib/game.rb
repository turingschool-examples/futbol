class Game
  attr_reader :game_id,
              :season_id,
              :season_type,
              :game_date,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals,
              :venue_name,
              :venue_link

  def initialize(data)
    @game_id = data[:game_id]
    @season_id = data[:season]
    @season_type = data[:type]
    @game_date = data[:date_time]
    @away_team_id = data[:away_team_id].to_i
    @home_team_id = data[:home_team_id].to_i
    @away_goals = data[:away_goals].to_i
    @home_goals = data[:home_goals].to_i
    @venue_name = data[:venue]
    @venue_link = data[:venue_link]
  end
end
