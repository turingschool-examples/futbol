class SeasonStatistics
    attr_reader :game_teams, :games, :teams
    def initialize(game_teams,games,teams)
        @game_teams = game_teams
        @games = games
        @teams = teams
    end

    #helper method one - makes an array of all the games in a season
    def games_in_season(season_id)
        game_ids = []
        @games.each do |game|
            if game[:season] == season_id
               game_ids << game[:game_id]
            end
        end

        season_games = []
        @game_teams.find_all do |games|
            if game_ids.include?(games[:game_id])
                season_games << games.to_h
            end
        end
        season_games
    end

    #helper method two - makes a nested array of the data grouped by coach
    def group_by_coach(season_id)
        games = games_in_season(season_id)

        grouped_arrays = games.group_by do |row|
            row[:head_coach]
        end.values
        grouped_arrays
    end

    #helper method three - makes a nested array grouped by team_id
    def group_by_team(season_id)
        games = games_in_season(season_id)

        grouped_arrays = games.group_by do |row|
            row[:team_id]
        end.values
        grouped_arrays
    end

    #helper method four
    def calculate_coach_stats(season_id)
        grouped_array = group_by_coach(season_id)
        
        coach_stats = {}
        grouped_array.each do |coach_array|  
            wins = 0
            games = 0
            coach_array.map do |row| 
                if row[:result] == "WIN"
                    wins += 1
                end
                games += 1
                coach_stats[row[:head_coach]] = {wins: wins, games: games}
            end
        end
        coach_stats   
    end

    #helper method five
    def calculate_team_stats(season_id, *stats)
        grouped_array = group_by_team(season_id)
        team_stats = {}

        grouped_array.each do |team_array|
            team_id = team_array.first[:team_id]
            team_stats[team_id] ||= {}

            stats.each do |stat|
                total_stat = team_array.sum { |row| row[stat].to_i }
                team_stats[team_id][stat] = total_stat
            end
        end
        team_stats   
    end

    #helper method six
    def find_team_name(team_id)
        team_row = @teams.find do |row|
            row[:team_id].to_s == team_id.to_s
        end
        team_row[:teamname]
    end

    #Season Statistics Methods
    def winningest_coach(season_id)
        coach_stats = calculate_coach_stats(season_id)

        best_coach = coach_stats.max_by do |coach,stats|
            (stats[:wins].to_f / stats[:games].to_f) * 100
        end
        
        best_coach[0]
    end
  
    def worst_coach(season_id)
        coach_stats = calculate_coach_stats(season_id)

        worst_coach = coach_stats.min_by do |coach,stats|
            (stats[:wins].to_f / stats[:games].to_f) * 100
        end
        worst_coach[0]  
    end
    
    def most_accurate_team(season_id)
        team_stats = calculate_team_stats(season_id, :shots, :goals)

        most_accurate = team_stats.min_by do |team,stats| #lower ratio means more accurate
            stats[:shots].to_f / stats[:goals].to_f
        end

        team_name = find_team_name(most_accurate[0])
        team_name
    end
  
    def least_accurate_team(season_id)
        team_stats = calculate_team_stats(season_id, :shots, :goals)

        least_accurate = team_stats.max_by do |team,stats| #higher ratio means less accurate
            stats[:shots].to_f / stats[:goals].to_f
        end

        team_name = find_team_name(least_accurate[0])
        team_name
    end
    
    def most_tackles(season_id)
        team_stats = calculate_team_stats(season_id,:tackles)

        most_tackles = team_stats.max_by do |team,stats|
            stats[:tackles]
        end
        
        team_name = find_team_name(most_tackles[0])
        team_name
    end
  
    def fewest_tackles(season_id)
        team_stats = calculate_team_stats(season_id,:tackles)

        least_tackles = team_stats.min_by do |team,stats|
            stats[:tackles]
        end
        
        team_name = find_team_name(least_tackles[0])
        team_name
    end
end