class Season
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

  attr_accessor :home_coach,
                :home_shots,
                :home_tackles,
                :away_coach,
                :away_shots,
                :away_tackles

  def initialize(row)
    @game_id = row[:game_id]
    @season = row[:season]
    @type = row[:type]
    @date_time = row[:date_time]
    @home_team_id = row[:home_team_id]
    @away_team_id = row[:away_team_id]
    @away_goals = row[:away_goals]
    @home_goals = row[:home_goals]
    @venue = row[:venue]
    @venue_link = row[:venue_link]
    @home_coach = nil
    @home_shots = nil
    @home_tackles = nil
    @away_coach = nil
    @away_shots = nil
    @away_tackles = nil
  end
end
