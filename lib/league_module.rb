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

  end

  def worst_defense

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
      #binding.pry
      total_games = val.length
      #binding.pry
      val.map {|v| v.goals}.reduce {|sum, num| sum + num}.to_f / total_games
    end
    avg_score_by_team
    #binding.pry
  end

  def generate_avg_scored_upon_by_team
    teams_by_game = game_teams.group_by do |game|
      game.game_id
    end


  end

  def empty_team_hash

  end

  def convert_ids_to_team_name(id)
    ids_to_name = teams.group_by {|team| team.team_id}.transform_values {|obj| obj[0].teamName}
    ids_to_name[id]
  end
end
