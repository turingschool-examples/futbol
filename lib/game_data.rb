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

    def self.create_objects
      table = CSV.parse(File.read('./data/dummy_file_games.csv'), headers: true)
      line_index = 0
      all_games = []
      table.size.times do
        game_data = GameData.new
        game_data.create_attributes(table, line_index)
        all_games << game_data
        line_index += 1
      end
      all_games
    end
end
