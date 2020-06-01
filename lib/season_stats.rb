class SeasonStats
  attr_reader :game_collection,
              :game_team_collection,
              :team_collection

  def initialize(game_collection, game_team_collection, team_collection)
    @game_collection = game_collection
    @game_team_collection = game_team_collection
    @team_collection = team_collection
  end

  def winningest_coach(season_id)
    coach_number_games = Hash.new(0)
    @game_team_collection.game_teams_array.count do |game_team|
      if game_team.game_id.slice(0..3) == season_id.slice(0..3)
        coach_number_games[game_team.head_coach] += 1.to_f
      end
    end
    coach_n_wins = Hash.new(0)
    @game_team_collection.game_teams_array.count do |game_team|
      if game_team.result == "WIN" && game_team.game_id.slice(0..3) == season_id.slice(0..3)
        coach_n_wins[game_team.head_coach] += 1.to_f
      end
    coach_n_wins
    end
    coach_n_wins.merge!(coach_number_games) { |k, o, n| o / n }
    coach_n_wins.delete_if do |k,v|
      v > 1
    end
    coach_n_wins.key(coach_n_wins.values.max)
  end

  def worst_coach(season_id)
    coach_number_games = Hash.new(0)
    @game_team_collection.game_teams_array.count do |game_team|
      if game_team.game_id.slice(0..3) == season_id.slice(0..3)
        coach_number_games[game_team.head_coach] += 1.to_f
      end
    end
    coach_n_wins = Hash.new(0)
    @game_team_collection.game_teams_array.count do |game_team|
      if game_team.result == "LOSS" && game_team.game_id.slice(0..3) == season_id.slice(0..3)
        coach_n_wins[game_team.head_coach] += 1.to_f
      end
    coach_n_wins
    end
    coach_n_wins.merge!(coach_number_games) { |k, o, n| o / n }
    coach_n_wins.delete_if do |k,v|
      v > 1
    end
    coach_n_wins.key(coach_n_wins.values.max)
  end

  def most_accurate_team(season_id)
    team_id = @game_team_collection.game_teams_array.max_by do |game|
      if season_id.slice(0..3) == game.game_id.slice(0..3)
        game.goals.to_f / game.shots.to_f
      end
    end.team_id.to_i
    @team_collection.team_name_by_id(team_id)
  end

  def least_accurate_team(season_id)
    team_id = @game_team_collection.game_teams_array.min_by do |game|
      if season_id.slice(0..3) == game.game_id.slice(0..3)
        game.goals.to_f / game.shots.to_f
      end
    end.team_id.to_i
    @team_collection.team_name_by_id(team_id)
  end

  def most_tackles(season_id)
    coach_tackles = Hash.new(0)
    @game_team_collection.game_teams_array.sum do |game_team|
      if game_team.game_id.slice(0..3) == season_id.slice(0..3)
        coach_tackles[game_team.team_id] += game_team.tackles.to_i
      end
    end
    id_number = coach_tackles.key(coach_tackles.values.max)
    @team_collection.team_name_by_id(id_number.to_i)
  end

  def least_taclkles(season_id)
    coach_tackles = Hash.new(0)
    @game_team_collection.game_teams_array.sum do |game_team|
      if game_team.game_id.slice(0..3) == season_id.slice(0..3)
        coach_tackles[game_team.team_id] += game_team.tackles.to_i
      end
    end
    id_number = coach_tackles.key(coach_tackles.values.min)
    @team_collection.team_name_by_id(id_number.to_i)
  end
end
