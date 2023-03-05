module Offensive_2

  def offensive_2(*away_or_home)
    offense = Hash.new

    applicable_games = @game_teams.select { |game_team|
      away_or_home.include?(game_team.hoa)
    }

    @teams.each { |team|
      this_teams_goals = applicable_games.select{ |game_team|
        game_team.team_id == team.team_id
        }.sum{|game_team| 
          game_team.goals.to_f}
      this_teams_games = applicable_games.select{|game_team| 
        game_team.team_id == team.team_id}.length
      offense[team.team_id] = (this_teams_goals / this_teams_games.to_f)
    }
    offense
  end

end