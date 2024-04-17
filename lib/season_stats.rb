module SeasonStats
    
    def winningest_coach(season_id)
        get_all_games(season_id)
        load_coach_array
        load_coach_hash
        coach_percentage_hash
        @coach_percentages.sort_by {|k, v| -v}.first[0]
    end

    def get_all_games(season_id)
        @all_season_games = []
        @game_teams.each do |game_team|
            if game_team.season_id == season_id
                @all_season_games << game_team
            end
        end
        @all_season_games
    end

    def load_coach_array
        @coach_array = []
        @all_season_games.each do |game|
            if !@coach_array.include?(game.head_coach)
                @coach_array << game.head_coach
            end
        end
        @coach_array
    end

    def load_coach_hash
        @coach_hash = {}
        @coach_array.each do |coach|
            @coach_hash[coach] = coach_subhash(coach)
        end
        @coach_hash
    end

    def coach_subhash(coach)
        total_game_tally = 0
        win_tally = 0
        @all_season_games.each do |game|
            if game.head_coach == coach
                total_game_tally += 1
            end
            if game.head_coach == coach && game.result == "WIN"
                win_tally += 1
            end
        end
        {wins: win_tally, total_games: total_game_tally}
    end

    def coach_percentage_hash
        @coach_percentages = {}
        @coach_hash.each do |coach, subhash|
            @coach_percentages[coach] = subhash[:wins].to_f / subhash[:total_games].to_f
        end
        @coach_percentages
    end

    def worst_coach(season_id)
        get_all_games(season_id)
        load_coach_array
        load_coach_hash
        coach_percentage_hash
        @coach_percentages.sort_by {|k, v| v}.first[0]
    end

end