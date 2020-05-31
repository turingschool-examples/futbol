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
        coach_number_games[game_team.head_coach] += 1.to_f
    end
    coach_n_wins = Hash.new(0)
    @game_team_collection.game_teams_array.count do |game_team|
      if game_team.result == "WIN"
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
        coach_number_games[game_team.head_coach] += 1.to_f
    end
    coach_n_wins = Hash.new(0)
    @game_team_collection.game_teams_array.count do |game_team|
      if game_team.result == "LOSS"
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
end
