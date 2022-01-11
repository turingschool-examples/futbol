

class SeasonTracker < Statistics

  def winningest_coach(season_id)
    seasons = @games.find_all {|game| game.season == season_id}
    season_coaches = []
    seasons.each do |game|
      @game_teams.find_all do |game_2|
        season_coaches << game_2 if game.game_id == game_2.game_id
      end
    end
    coaches = season_coaches.group_by do |game|
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
    season_coaches = []
    seasons.each do |game|
      @game_teams.find_all do |game_2|
        season_coaches << game_2 if game.game_id == game_2.game_id
      end
    end
    coaches = season_coaches.group_by do |game|
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
    season_accuracy = []
    seasons.each do |game|
      @game_teams.find_all do |game_2|
        season_accuracy << game_2 if game.game_id == game_2.game_id
      end
    end
    teams = season_accuracy.group_by do |game|
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
    find_name_by_ID(hash.key(hash.values.max))[0].team_name
  end

  def least_accurate_team(season_id)
    seasons = @games.find_all {|game| game.season == season_id}
    season_accuracy = []
    seasons.each do |game|
      @game_teams.find_all do |game_2|
        season_accuracy << game_2 if game.game_id == game_2.game_id
      end
    end
    teams = season_accuracy.group_by do |game|
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
    find_name_by_ID(hash.key(hash.values.min))[0].team_name
  end

  def most_tackles(season_id)
    seasons = @games.find_all {|game| game.season == season_id}
    season_tackles = []
    seasons.each do |game|
      @game_teams.find_all do |game_2|
        season_tackles << game_2 if game.game_id == game_2.game_id
      end
    end
    teams = season_tackles.group_by do |game|
      game.team_id
    end
    hash = Hash.new
    teams.each_pair do |team, games|
      tackles = games.reduce(0) do |sum, game|
        sum + game.tackles
      end
      hash[team] = tackles
    end
    find_name_by_ID(hash.key(hash.values.max))[0].team_name
  end

  def fewest_tackles(season_id)
    seasons = @games.find_all {|game| game.season == season_id}
    season_tackles = []
    seasons.each do |game|
      @game_teams.find_all do |game_2|
        season_tackles << game_2 if game.game_id == game_2.game_id
      end
    end
    teams = season_tackles.group_by do |game|
      game.team_id
    end
    hash = Hash.new
    teams.each_pair do |team, games|
      tackles = games.reduce(0) do |sum, game|
        sum + game.tackles
      end
      hash[team] = tackles
    end
    find_name_by_ID(hash.key(hash.values.min))[0].team_name
  end
end
