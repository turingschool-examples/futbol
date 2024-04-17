module SeasonStats
    
    def winningest_coach(season_id)
        @all_season_games = []
        @game_teams.each do |game_team|
            if game_team.season_id == season_id
                @all_season_games << game_team
            end
        end
        coach_array = []
        coach_hash = {}
        @all_season_games.each do |game|
            if !coach_array.include?(game.head_coach)
                coach_array << game.head_coach
            end
        end
        coach_array.each do |coach|
            coach_hash[coach] = coach_subhash(coach)
        end
        coach_percentages = {}
        coach_hash.each do |coach, subhash|
            coach_percentages[coach] = subhash[:wins].to_f / subhash[:total_games].to_f
        end
        sorted_percentages = coach_percentages.sort_by {|k, v| -v}
        sorted_percentages.first[0]
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

    def worst_coach(season_id)
        @all_season_games = []
        @game_teams.each do |game_team|
            if game_team.season_id == season_id
                @all_season_games << game_team
            end
        end
        coach_array = []
        coach_hash = {}
        @all_season_games.each do |game|
            if !coach_array.include?(game.head_coach)
                coach_array << game.head_coach
            end
        end
        coach_array.each do |coach|
            coach_hash[coach] = coach_subhash(coach)
        end
        coach_percentages = {}
        coach_hash.each do |coach, subhash|
            coach_percentages[coach] = subhash[:wins].to_f / subhash[:total_games].to_f
        end
        sorted_percentages = coach_percentages.sort_by {|k, v| -v}
        sorted_percentages.last[0]
    end

end