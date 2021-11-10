class Games
  attr_reader :game_id,
              :season,
              :date_time,
              :type,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals,
              :venue,
              :venue_link

  def initialize(info_hash)
    @game_id       = info_hash[:game_id].to_i
    @season        = info_hash[:season]
    @date_time     = info_hash[:date_time]
    @type          = info_hash[:type]
    @away_team_id  = info_hash[:away_team_id].to_i
    @home_team_id  = info_hash[:home_team_id].to_i
    @away_goals    = info_hash[:away_goals].to_i
    @home_goals    = info_hash[:home_goals].to_i
    @venue         = info_hash[:venue]
    @venue_link    = info_hash[:venue_link]
  end
end
