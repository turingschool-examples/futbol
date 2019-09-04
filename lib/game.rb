class Game

  attr_reader :id,
              :season,
              :type,
              :date_time,
              :settled_in,
              :venue,
              :venue_link,
              :home_team,
              :away_team

  def initialize(game_hash)
    @id = game_hash[:id]
    @season = game_hash[:season]
    @type = game_hash[:type]
    @date_time = game_hash[:date_time]
    @settled_in = game_hash[:settled_in]
    @venue = game_hash[:venue]
    @venue_link = game_hash[:venue_link]
    @home_team = {id: game_hash[:home_team][:id]}
    # game_hash[:home_team]
    @away_team = {id: game_hash[:away_team][:id]}
    # game_hash[:away_team]
  end

end
