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


  def initialize(hash)
    @game_id = hash[:game_id]
    @season = hash[:season]
    @type = hash[:type]
    @date_time = hash[:date_time]
    @away_team_id = hash[:away_team_id]
    @home_team_id = hash[:home_team_id]
    @away_goals = hash[:away_goals]
    @home_goals = hash[:home_goals]
    @venue = hash[:venue]
    @venue_link = hash[:venue_link]

  end

end
