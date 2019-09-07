module HelperMethods

  def team_result_count
    team_result_count = Hash.new { |h,k| h[k] = Hash.new(0) }

    @game_teams.each do |game_id, game_teams|
      game_teams.each do |game_team|
        team_result_count[game_team.team_id][:games] += 1
        team_result_count[game_team.team_id][:total_goals] += game_team.goals

        if game_team.hoa == "away"
          team_result_count[game_team.team_id][:goals_allowed] += @games[game_team.game_id].home_goals
          team_result_count[game_team.team_id][:away_goals] += game_team.goals
          team_result_count[game_team.team_id][:away_games] += 1
          team_result_count[game_team.team_id][:away_wins] += 1 if game_team.result == "WIN"

        elsif game_team.hoa == "home"
          team_result_count[game_team.team_id][:goals_allowed] += @games[game_team.game_id].away_goals
          team_result_count[game_team.team_id][:home_goals] += game_team.goals
          team_result_count[game_team.team_id][:home_games] += 1
          team_result_count[game_team.team_id][:home_wins] += 1 if game_team.result == "WIN"
          # require 'pry'; binding.pry
        end

      end
    end

    team_result_count
  end

end
