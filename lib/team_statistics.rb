class TeamStatistics
    attr_reader :teams,
                :stat_tracker,
                :games,
                :game_teams

    def initialize(teams,games, stat_tracker)
        @teams = teams
        @games = games
        @game_teams = game_teams
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

    def team_games(team_id)
        @games.select { |game| game.away_team_id == team_id || game.home_team_id == team_id }
      end

    #def team_wins(team_id)
        #total_wins = Hash.new(0)
        #@game_teams.each do |game|
            #total_wins[team_id] += 1 if game.result == 'WIN'
        #end 
        #total_wins
    #end

    #def team_losses(team_id)
        #total_losses = Hash.new(0)
        #@game_teams.each do |game|
            #total_losses[team_id] += 1 if game.result == 'LOSS'
        #end 
        #total_losses
    #end

    #
    
    #def worst_season
    #end
    
    
    
    
    
end
