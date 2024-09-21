

class SeasonStatistics
    attr_reader :games, :teams, :game_teams, :stat_tracker
  
    def initialize(games, teams, game_teams, stat_tracker)
      @games = games
      @teams = teams
      @game_teams = game_teams
      @stat_tracker = stat_tracker
    end

    def most_accurate_team
      goals = Hash.new(0)
      shots = Hash.new(0)
  
      @game_teams.each do |game_team| #gets goals and shots for each team
        team_id = game_team.team_id
        goals[team_id] += game_team.goals.to_i
        shots[team_id] += game_team.shots.to_i
      end
  
      most_accurate_team_id = goals.keys.max_by do |team_id|
        accuracy(goals[team_id], shots[team_id]) #calculates accuracy for each team and then finds most accurate
      end
  
      team_name(most_accurate_team_id)
    end
  
    def accuracy(goals, shots)
      (goals.to_f / shots) * 100
    end

    end
  
    def winningest_coach; end

    def most_tackles
      tackles_teams = Hash.new(0)
      @game_teams.each do |game_team|
        team_id = game_team.team_id
        tackles_teams[team_id] += game_team.tackles.to_i
      end
  
      team_most_tackles = tackles_teams.max_by { |team, tackles| tackles }[0]
  
      team_name(team_most_tackles)
    end

