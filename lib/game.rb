class Game
    attr_reader :game_id,
                :season,
                :type,
                :away_team_id,
                :home_team_id,
                :away_goals,
                :home_goals

    def initialize(game_id, season, type, away_team_id, home_team_id, away_goals, home_goals)
        @game_id = game_id
        @season = season
        @type = type.to_s
        @away_team_id = away_team_id
        @home_team_id = home_team_id
        @away_goals = away_goals
        @home_goals = home_goals
    end

    def self.create_from_csv(file_path)
        CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
            game_id = row[:game_id]
            season = row[:season]
            type = row[:type]
            away_team_id = row[:away_team_id]
            home_team_id = row[:home_team_id]
            away_goals = row[:away_goals]
            home_goals = row[:home_goals]
            Game.new(game_id, season, type, away_team_id, home_team_id, away_goals, home_goals)
        end
    end
end