module SeasonStats

  def stats_by_group(season_id, group_by = nil) # Returns all stat objects for a given season
    stats = creator.seasons_hash[season_id].map { |game| game.home_team_stat } + creator.seasons_hash[season_id].map { |game| game.away_team_stat }
    if group_by == 'team_id'
      stats.group_by { |stat| stat.team_id }
    elsif group_by == 'coach'
      stats.group_by { |stat| stat.head_coach }
    else
      stats
    end
  end

  def team_ids_sorted_by_tackles(season_id) # Returns an array of team ids sorted by amount of tackles for a given season
    team_stat_pairs = self.stats_by_group(season_id, "team_id").sort_by do |team_id, stats|
      stats.sum { |stat| stat.tackles }
    end
    team_stat_pairs.map { |pair| pair[0] }
  end

  def team_ids_sorted_by_accuracy(season_id) # Returns an array of team ids sorted by accuracy for a given season
    team_stat_pairs = self.stats_by_group(season_id, "team_id").sort_by do |team_id, stats|
      shots = stats.sum { |stat| stat.shots }
      goals = stats.sum { |stat| stat.goals }
      shots > 0 ? goals.to_f / shots.to_f : 0
    end
    team_stat_pairs.map { |pair| pair[0] }
  end

  def winningest_coach(season_id) # Returns the name of the coach that had the highest win percentage for a given season
    self.stats_by_group(season_id, 'coach').max_by do |coach, stats|
      wins = stats.sum { |stat| stat.result == "WIN" ? 1 : 0 }
      losses = stats.sum { |stat| stat.result == "LOSS" ? 1 : 0 }
      wins.to_f / (wins + losses).to_f
    end[0]
  end

  def worst_coach(season_id) # Returns the name of the coach that had the lowest win percentage for a given season
    self.stats_by_group(season_id, 'coach').min_by do |coach, stats|
      wins = stats.sum { |stat| stat.result == "WIN" ? 1 : 0 }
      losses = stats.sum { |stat| stat.result == "LOSS" ? 1 : 0 }
      wins.to_f / (wins + losses).to_f
    end[0]
  end

  def most_accurate_team(season_id) # Returns the name of the team that had the highest goals:shots ratio for a given season
    team_id_most_accuracy = self.team_ids_sorted_by_accuracy(season_id).last
    creator.teams_hash[team_id_most_accuracy].team_name
  end

  def least_accurate_team(season_id) # Returns the name of the team that had the lowest goals:shots ratio for a given season
    team_id_least_accuracy = self.team_ids_sorted_by_accuracy(season_id).first
    creator.teams_hash[team_id_least_accuracy].team_name
  end

  def most_tackles(season_id) # Returns the name of the team that has the most tackles for a given season
    team_id_most_tackles = self.team_ids_sorted_by_tackles(season_id).last
    creator.teams_hash[team_id_most_tackles].team_name
  end

  def fewest_tackles(season_id) # Returns the name of the team that has the least tackles for a given season
    team_id_least_tackles = self.team_ids_sorted_by_tackles(season_id).first
    creator.teams_hash[team_id_least_tackles].team_name
  end
end