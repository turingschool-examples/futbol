require 'pry'
module DataCollector
  def find_name_by_ID(name_id)
    @teams.select do |team|
      team.team_id == name_id
    end
  end

  def home_away_or_tie(game, home_away_tie)
    if home_away_tie == "home"
      game.home_goals > game.away_goals
    elsif home_away_tie == "away"
      game.home_goals < game.away_goals
    else
      game.home_goals == game.away_goals
    end
  end

  def games_by_season_hash
    @games.group_by do |game|
      game.season
    end
  end

  def get_team(team_id)
    @teams.find do |team|
      team.team_id == team_id
    end
  end

  def find_games(results_1, results_2)
    final_games = []
    results_1.each do |game_1|
      results_2.each do |game_2|
        final_games << game_1 if game_1.game_id == game_2.game_id
      end
    end
    final_games
  end

  def count_games_per_team(team_id, data)
    (data.find_all {|game| game.team_id == team_id}).length
  end


  # def best_or_worse
  #   if best_worse == "best"
  #     game.home_goals > game.away_goals
  #   elsif home_away_tie == "away"
  #     game.home_goals < game.away_goals
  #   else
  #     game.home_goals == game.away_goals
  #   end
  # # end
  #
  # end

  def goals_per_game(hash)
    key_hash = {}
    hash.map do |key, sorted|
      goals = sorted.sum {|game| game.goals}
      key_hash[key] = goals.to_f / sorted.count
    end
  end

  def sort_games(data)
    # binding.pry
    data.group_by {|game| game.team_id}
  end

  def best_or_worse(best_worse,hash)
    if best_worse == "best"
      find_name_by_ID(hash.key(hash.values.max))[0].team_name
    else best_worse == "worst"
      find_name_by_ID(hash.key(hash.values.min))[0].team_name
    end

  end
end

#averaged_results = games_by_season.reduce({}) do |hash, season_games|
#   hash[season_games[0]] = season_games[1].length
#   hash
# end
