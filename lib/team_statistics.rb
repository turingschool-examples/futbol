class TeamStatistics
    attr_reader :teams,
                :stat_tracker,
                :games

    def initialize(teams,games, stat_tracker)
        @teams = teams
        @games = games
        @stat_tracker = stat_tracker
    end

    def team_name(team_id)
        @teams[team_id]&.team_name
    end

    def count_of_teams
        @teams.size
    end

    def most_goals_scored(team_id)
        goals = 0
        @games.each do |game|
            if game.away_team_id == team_id && game.away_goals.to_i > goals
                goals = game.away_goals.to_i
            end
            
            if game.home_team_id == team_id && game.home_goals.to_i > goals
                goals = game.home_goals.to_i
            end
        end
        goals
    end

    def fewest_goals_scored(team_id)
        goals = 99
        @games.each do |game|
            if game.away_team_id == team_id && game.away_goals.to_i < goals
                goals = game.away_goals.to_i
            end
            
            if game.home_team_id == team_id && game.home_goals.to_i < goals
                goals = game.home_goals.to_i
            end
        end
        goals
    end

    def head_to_head(team_id)
        results = Hash.new { |hash, key| hash[key] = { wins: 0, losses: 0 } }

        @games.each do |game|
          if game.away_team_id == team_id
            opp_team_id = game.home_team_id
            if game.away_goals.to_i > game.home_goals.to_i
                results[opp_team_id][:wins] +=1
                puts "Game #{game.game_id}: #{team_name(team_id)} won against #{team_name(opp_team_id)}"
            else
                results[opp_team_id][:losses] += 1
                puts "Game #{game.game_id}: #{team_name(team_id)} lost against #{team_name(opp_team_id)}"
            end            
          elsif game.home_team_id == team_id
            opp_team_id = game.away_team_id
            if game.home_goals.to_i > game.away_goals.to_i
            results[opp_team_id][:wins] += 1
             puts "Game #{game.game_id}: #{team_name(team_id)} won against #{team_name(opp_team_id)}"
            else
                results[opp_team_id][:losses] += 1
                 puts "Game #{game.game_id}: #{team_name(team_id)} lost against #{team_name(opp_team_id)}"
            end
          end
        end
        
        results.transform_keys! { |id| team_name(id) }
        results
    end

    def team_name(team_id)
        @teams.find { |team| team.team_id == team_id }.team_name
    end

    def favorite_opponent(team_id)
       head_to_head_results = head_to_head(team_id)
       highest_win_percentage = head_to_head_results.values.max_by { |record| record[:highest_win_percentage]}
       favorite = head_to_head_results.key(highest_win_percentage)
       favorite
    end 
end
