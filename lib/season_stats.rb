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

    def most_accurate_team(season_id)
        get_all_games(season_id)
        load_team_array
        load_team_hash
        accuracy_hash
        team_id = @accuracy_hash.sort_by {|k, v| -v}.first[0]
        team_index(team_id)
    end

    def load_team_array
        @team_array = []
        @all_season_games.each do |game|
            if !@team_array.include?(game.team_id)
                @team_array << game.team_id
            end
        end
        @team_array
    end

    def load_team_hash
        @team_hash = {}
        @team_array.each do |team|
            @team_hash[team] = team_subhash(team)
        end
        @team_hash
    end

    def team_subhash(team_id)
        goal_tally = 0
        shot_tally = 0
        @all_season_games.each do |game|
            if game.team_id == team_id
                goal_tally += game.goals.to_i
                shot_tally += game.shots.to_i
            end
        end
        {goals: goal_tally, shots: shot_tally}
    end

    def accuracy_hash
        @accuracy_hash = {}
        @team_hash.each do |team, subhash|
            @accuracy_hash[team] = subhash[:goals].to_f / subhash[:shots].to_f
        end
        @accuracy_hash
    end

    def least_accurate_team(season_id)
        get_all_games(season_id)
        load_team_array
        load_team_hash
        accuracy_hash
        team_id = @accuracy_hash.sort_by {|k, v| v}.first[0]
        team_index(team_id)
    end

    def team_index(team_id)
        team_object = @teams.find do |team|
            team.team_id == team_id
        end
        team_object.team_name
    end
        
end