

class SeasonTracker < Statistics

  def winningest_coach(season_id)
    seasons = @games.find_all {|game| game.season == season_id}
    seasons.each do |game|
      @game_teams.find_all do |game_2|
        game.game_id == game_2.game_id
      end
    end
    coaches = @game_teams.group_by do |game|
      game.head_coach
    end
    hash = Hash.new
    coaches.each_pair do |coach, games|
      result = games.count do |game|
        game.result == "WIN"
      end
      hash[coach] = result.to_f / coaches[coach].length
    end
    hash.key(hash.values.max)
  end

  def worst_coach(season_id) # IF TEST HARNESS FAILS, CHANGE line 42
    seasons = @games.find_all {|game| game.season == season_id}
    seasons.each do |game|
      @game_teams.find_all do |game_2|
        game.game_id == game_2.game_id
      end
    end
    coaches = @game_teams.group_by do |game|
      game.head_coach
    end
    hash = Hash.new
    coaches.each_pair do |coach, games|
      result = games.count do |game|
        game.result == "WIN"
      end
      hash[coach] = result.to_f / coaches[coach].length
    end
    hash.key(hash.values.min)
  end

  def most_accurate_team(season_id)
    seasons = @games.find_all {|game| game.season == season_id}
    seasons.each do |game|
      @game_teams.find_all do |game_2|
        game.game_id == game_2.game_id
      end
    end
    teams = @game_teams.group_by do |game|
      game.team_id
    end
    hash = Hash.new
    teams.each_pair do |team, games|
      shots = games.reduce(0) do |sum, game|
        sum + game.shots
      end
      goals = games.reduce(0) do |sum, game|
        sum + game.goals
      end
      hash[team] = goals.to_f / shots
    end
    find_name_by_ID(hash.key(hash.values.max))[0].teamname
  end


end
