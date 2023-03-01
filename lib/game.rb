class Game

    attr_reader :id,
                :season,
                :type,
                :date_time,
                :away_id,
                :home_id,
                :away_goals,
                :home_goals,
                :venue

    def initialize(game_data)
      @id = game_data[:game_id]
      @season = game_data[:season]
      @type = game_data[:type]
      @date_date = game_data[:date_time]
      @away_id = game_data[:away_team_id]
      @home_id = game_data[:home_team_id]
      @away_goals = game_data[:away_team_goals]
      @home_goals = game_data[:home_goals]
      @venue = game_data[:venue]
    end
end