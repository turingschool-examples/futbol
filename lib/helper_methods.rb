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

  def opponent_stats(team_id)
    team_id = team_id.to_i
    opponent_count = Hash.new { |h,k| h[k] = Hash.new(0) }

    @game_teams.each do |game_id, game_teams|
      game_teams.each do |game_team|
        if game_team.team_id == team_id

          if game_team.hoa == "away"
            opponent_id = @games[game_id].home_team_id
            opponent_count[opponent_id][:games] += 1
            opponent_count[opponent_id][:wins] += 1 if game_team.result == "LOSS"
            opponent_count[opponent_id][:losses] += 1 if game_team.result == "WIN"

          elsif game_team.hoa == "home"
            opponent_id = @games[game_id].away_team_id
            opponent_count[opponent_id][:games] += 1
            opponent_count[opponent_id][:wins] += 1 if game_team.result == "LOSS"
            opponent_count[opponent_id][:losses] += 1 if game_team.result == "WIN"
          end
        end
      end
    end

    opponent_count
  end

end
