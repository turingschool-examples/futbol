module SeasonStats

  def most_accurate_team(season)
    team_ratios = Hash.new { |hash, key| hash[key] = [0, 0] }
  
    games_in_season = @games.select { |game| game.season == season }
    games_in_season.each do |game|
      home_team_id = game.home_team_id
      away_team_id = game.away_team_id
  
      home_team_stats = @game_teams.find { |team| team.game_id == game.game_id && team.team_id == home_team_id }
      away_team_stats = @game_teams.find { |team| team.game_id == game.game_id && team.team_id == away_team_id }
  
      home_shots = home_team_stats.shots.to_f
      home_goals = home_team_stats.goals.to_f
      away_shots = away_team_stats.shots.to_f
      away_goals = away_team_stats.goals.to_f
  
      home_team = @teams.find { |team| team.team_id == home_team_id }
      away_team = @teams.find { |team| team.team_id == away_team_id }
  
      team_ratios[home_team.name][0] += home_shots
      team_ratios[home_team.name][1] += home_goals
      team_ratios[away_team.name][0] += away_shots
      team_ratios[away_team.name][1] += away_goals
    end
  
    accuracies = {}
    team_ratios.each do |team_name, (shots, goals)|
      if shots > 0
        accuracy = goals / shots
        accuracies[team_name] = accuracy
      end
    end
    accuracies.max_by { |_, accuracy| accuracy }.first
  end

  def most_tackles(season)
    games_for_season = @games.find_all { |game| game.season == season }
    game_teams_for_season = @game_teams.find_all do |game_team|
      games_for_season.any? { |game| game.game_id == game_team.game_id }
    end
  
    team_tackles = game_teams_for_season.group_by(&:team_id).transform_values do |game_teams|
      game_teams.sum(&:tackles)
    end
  
    team_with_most_tackles = team_tackles.sort_by { |_, tackles| tackles }.last.first
    @teams.find { |team| team.team_id == team_with_most_tackles }.team_name
  end
end