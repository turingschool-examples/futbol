class GameTeamsRepo
    def initialize(game_teams_path)
      @game_teams = make_game_teams(game_teams_path)
    end
  
    def make_game_teams(game_teams_path)
      game_teams = []
      CSV.foreach(game_teams_path, headers: true, header_converters: :symbol) do |row|
        game_teams << GameTeams.new(row)
      end
      game_teams
    end

    # def teams
    #   @stat_tracker.teams
    # end
#REMEMBER TO REFACTOR THESE

    def game_teams_by_team
        @game_teams.group_by do |game|
          game.team_id
        end
    end

    def game_teams_by_away
        @game_teams.group_by do |game|
          game.team_id unless game.hoa == "home"
        end
    
      end
    
      def game_teams_by_home
        @game_teams.group_by do |game|
          game.team_id unless game.hoa == "away"
        end
    
      end

      def game_teams_by_coach
        @game_teams.group_by do |game|
          game.head_coach
        end
      end

      def best_offense
        average_goals = {}
        game_teams_by_team.map do |team , games|
          average_goals[team] = (games.sum {|game|  game.goals}).to_f / games.count
        end
        average_goals.key(average_goals.values.max)
      end

      def worst_offense
        average_goals = {}
        game_teams_by_team.map do |team , games|
          average_goals[team] = (games.sum {|game|  game.goals}).to_f / games.count
        end
        average_goals.key(average_goals.values.min)
      end
    
end