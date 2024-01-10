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
    
        def initialize(game_id, season, type, date_time, away_team_id, home_team_id, away_goals, home_goals, venue, venue_link)
            @game_id = game_id
            @season = season
            @type = type
            @date_time = date_time
            @away_team_id = away_team_id
            @home_team_id = home_team_id
            @away_goals = away_goals
            @home_goals = home_goals
            @venue = venue
            @venue_link = venue_link
        end
    
        # did not add `.to_i` to any intergers depending on how we want to do it
        def self.create_games(data_path)
        CSV.foreach(data_path, headers: true, header_converters: :symbol) do |row|
                game_id =row[:game_id]
                season = row[:season]
                type = row[:type]
                date_time = row[:date_time]
                away_team_id = row[:away_team_id]
                home_team_id = row[:home_team_id]
                away_goals = row[:away_goals]
                home_goals = row[:home_goals]
                venue = row[:venue]
                venue_link = row[:venue_link]
                game_instance = Game.new(game_id, season, game_type, game_date_time, away_team_id, home_team_id, away_goals, home_goals)
            end
        end
    end