class GameData

  attr_reader :game_id, :season, :type,
      :date_time, :away_team_id, :home_team_id,
      :away_goals, :home_goals, :venue, :venue_link

    def initialize()
      @game_id = nil
      @season = nil
      @type = nil
      @date_time = nil
      @away_team_id = nil
      @home_team_id = nil
      @away_goals = nil
      @home_goals = nil
      @venue = nil
      @venue_link = nil
    end

end
