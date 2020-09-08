module LeagueStats
  def count_of_teams
    team_ids = @game_teams.map(&:team_id)
    team_ids.uniq.count
  end

  def best_offence
    away_team_ids = @games.map(&:away_team_id)
    home_team_ids = @games.map(&:home_team_id)
    teams_array = (away_team_ids + home_team_ids).uniq
    away_goals = @games.map(&:away_goals)
    home_goals = @games.map(&:home_goals)
    score_array = (away_team_ids.zip away_goals) + (home_team_ids.zip home_goals)
    teamnum = @teams.map(&:team_id)
    team_names = @teams.map(&:team_name)
    avghash ={}
    teams_array.each do |team|
      sum = 0
       score_array.each do |pair|
        if pair[0]==team
          sum += pair[1]
        end
      end
      avghash[team] = sum.to_f/(away_team_ids.count(team)+home_team_ids.count(team))
    end
    hash2 = Hash[teamnum.zip team_names]
    hash2[avghash.key(avghash.values.max).to_i]
  end

  def worst_offence
    away_team_ids = @games.map(&:away_team_id)
    home_team_ids = @games.map(&:home_team_id)
    teams_array = (away_team_ids + home_team_ids).uniq
    away_goals = @games.map(&:away_goals)
    home_goals = @games.map(&:home_goals)
    score_array = (away_team_ids.zip away_goals) + (home_team_ids.zip home_goals)
    teamnum = @teams.map(&:team_id)
    team_names = @teams.map(&:team_name)
    avghash ={}
    teams_array.each do |team|
      sum = 0
       score_array.each do |pair|
        if pair[0]==team
          sum += pair[1]
        end
      end
      avghash[team] = sum.to_f/(away_team_ids.count(team)+home_team_ids.count(team))
    end
    hash2 = Hash[teamnum.zip team_names]
    hash2[avghash.key(avghash.values.min).to_i]
  end

  def highest_scoring_visitor
    away_team_ids = @games.map(&:away_team_id)
    teams_array = away_team_ids.uniq
    away_goals = @games.map(&:away_goals)
    score_array = (away_team_ids.zip away_goals)
    teamnum = @teams.map(&:team_id)
    team_names = @teams.map(&:team_name)
    avghash ={}
    teams_array.each do |team|
      sum = 0
       score_array.each do |pair|
        if pair[0]==team
          sum += pair[1]
        end
      end
      avghash[team] = sum.to_f/(away_team_ids.count(team))
    end
    hash2 = Hash[teamnum.zip team_names]
    hash2[avghash.key(avghash.values.max).to_i]
  end
end
