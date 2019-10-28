module LeagueModule
  def count_of_teams
    teams.length
  end

  def best_offense
    team_id = self.generate_avg_goals_by_team.max_by {|team, avg| avg}
    self.convert_ids_to_team_name(team_id[0])
  end

  def worst_offense
    team_id = self.generate_avg_goals_by_team.min_by {|team, avg| avg}
    self.convert_ids_to_team_name(team_id[0])
  end

  def best_defense
    team_id = self.generate_avg_scored_upon_by_team.min_by {|team, avg| avg}
    self.convert_ids_to_team_name(team_id[0])
  end

  def worst_defense
    team_id = self.generate_avg_scored_upon_by_team.max_by {|team, avg| avg}
    self.convert_ids_to_team_name(team_id[0])
  end

  def highest_scoring_visitor
  end

  def lowest_scoring_visitor
  end

  def lowest_scoring_home_team
  end

  def winningest_team
    teams_hash = game_teams.reduce({}) do |acc, game_team|
      acc[game_team.team_id] = { :wins => 0, :total_games => games_played_by_team(game_team.team_id)}
      acc
    end
    game_teams.map do |game|
      teams_hash[game.team_id][:wins] += game.result == "WIN" ? 1 : 0
    end
    win_percent = teams_hash.reduce({}) do |acc, (k, v)|
      acc[k] = (v[:wins].to_f / v[:total_games].to_f).round(2)
      acc
    end
    result = win_percent.sort_by { |k, v| v }.last.first
    convert_ids_to_team_name(result)
  end

  def best_fans
    teams_hash = game_teams.reduce({}) do |acc, game_team|
      acc[game_team.team_id] = { :home_wins => 0, :home_games => 0, :away_wins => 0, :away_games => 0}
      acc
    end
    game_teams.map do |game|
      teams_hash[game.team_id][:home_wins] += game.result == "WIN" && game.hoa == "home" ? 1 : 0
      teams_hash[game.team_id][:away_wins] += game.result == "WIN" && game.hoa == "away" ? 1 : 0
      teams_hash[game.team_id][:home_games] += game.hoa == "home" ? 1 : 0
      teams_hash[game.team_id][:away_games] += game.hoa == "home" ? 1 : 0
    end
    biggest_diff = teams_hash.reduce({}) do |acc, (k, v)|
      acc[k] = (v[:home_wins].to_f / v[:home_games].to_f).round(2) - (v[:away_wins].to_f / v[:away_games].to_f).round(2)
      acc
    end
    result = biggest_diff.sort_by { |k, v| v }.last.first
    convert_ids_to_team_name(result)
  end

  def worst_fans
    teams_hash = game_teams.reduce({}) do |acc, game_team|
      acc[game_team.team_id] = { :home_wins => 0, :home_games => 0, :away_wins => 0, :away_games => 0}
      acc
    end
    game_teams.map do |game|
      teams_hash[game.team_id][:home_wins] += game.result == "WIN" && game.hoa == "home" ? 1 : 0
      teams_hash[game.team_id][:away_wins] += game.result == "WIN" && game.hoa == "away" ? 1 : 0
      teams_hash[game.team_id][:home_games] += game.hoa == "home" ? 1 : 0
      teams_hash[game.team_id][:away_games] += game.hoa == "away" ? 1 : 0
    end
    biggest_diff = teams_hash.reduce({}) do |acc, (k, v)|
      #acc[k] = ((v[:home_wins].to_f / v[:home_games].to_f).round(2) - (v[:away_wins].to_f / v[:away_games].to_f).round(2)).round(2)
      acc[k] = (v[:home_wins].to_f - v[:away_wins].to_f).round(2)
      acc
    end
    result = biggest_diff.select { |k, v| v < 0 }
    result.map { |k, v| convert_ids_to_team_name(k) }
  end

  ##Helper Methods##
  def generate_avg_goals_by_team
    games_by_team = game_teams.group_by do |game|
      game.team_id
    end
    avg_score_by_team = games_by_team.transform_values do |val|
      total_games = val.length
      val.map {|v| v.goals}.reduce {|sum, num| sum + num}.to_f / total_games
    end
    avg_score_by_team
  end

  def generate_avg_scored_upon_by_team
    teams_by_game = game_teams.group_by do |game|
      game.game_id
    end
    scored_upon_by_team = self.empty_team_hash
    teams_by_game.each do |game, teams|
      scored_upon_by_team[teams[0].team_id] += teams[1].goals
      scored_upon_by_team[teams[1].team_id] += teams[0].goals
    end
    avg_by_team = scored_upon_by_team.transform_values do |total_score|
      team_id = scored_upon_by_team.key(total_score)
      total_score / self.games_played_by_team(team_id).to_f
    end
    avg_by_team
  end

  def games_played_by_team(id)
    gbt = game_teams.group_by {|game| game.team_id}.transform_values {|val| val.length}
    gbt[id]
  end

  def empty_team_hash
    teams_hash = Hash.new
    teams.each {|team| teams_hash[team.team_id] = 0}
    teams_hash
  end

  def convert_ids_to_team_name(id)
    ids_to_name = teams.group_by {|team| team.team_id}.transform_values {|obj| obj[0].teamName}
    ids_to_name[id]
  end

end
