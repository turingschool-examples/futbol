require 'pry'

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
    self.generate_avg_scored_upon_by_team
  end

  def worst_defense
    self.generate_avg_scored_upon_by_team
  end

  def highest_scoring_visitor

  end

  def lowest_scoring_visitor

  end

  def lowest_scoring_home_team

  end

  def winningest_team

  end

  def best_fans

  end

  def worst_fans

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
    scored_upon_by_team
    binding.pry
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
