module Hashable

  def visitor_scores_hash
    games_grouped_by_away_team = @game_teams_path.group_by {|row| row[:team_id]}
    average_away_goals_per_team = {}

    games_grouped_by_away_team.each do |team, games|
      average_away_goals_per_team[team] = 0
        games.each do |game|
        average_away_goals_per_team[team] += game[:goals].to_i if game[:hoa] == "away"
      end
      average_away_goals_per_team[team] = (average_away_goals_per_team[team].to_f / games.size).round(2)
    end
    average_away_goals_per_team
  end

  def home_scores_hash
		games_grouped_by_home_team = @game_teams_path.group_by {|row| row[:team_id]}
		average_home_goals_per_team = {}

		games_grouped_by_home_team.each do |team, games|
			average_home_goals_per_team[team] = 0
				games.each do |game|
				average_home_goals_per_team[team] += game[:goals].to_i if game[:hoa] == "home"
			end
			average_home_goals_per_team[team] = (average_home_goals_per_team[team].to_f / games.size).round(2)
		end
		average_home_goals_per_team
	end
end