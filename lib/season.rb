class Season
  attr_reader :games

  def initialize
    @games = {}# rename to game data per game_id
  end

  def add_game(game_id, game, game_team_home, game_team_away)
    @games[game_id] = {
      game: game,
      home: game_team_home,
      away: game_team_away
    }
  end

  def goals_and_shots
    {total_goals: 0, total_shots: 0}
  end

  def add_goals_data(accurate_hash, game_data)
    accurate_hash[game_data[:home].team_id][:total_goals] += game_data[:home].goals.to_i
    accurate_hash[game_data[:away].team_id][:total_goals] += game_data[:away].goals.to_i
    accurate_hash[game_data[:home].team_id][:total_shots] += game_data[:home].shots.to_i
    accurate_hash[game_data[:away].team_id][:total_shots] += game_data[:away].shots.to_i
  end

  def most_accurate_team
    most_accurate = Hash.new { |hash, key| hash[key] = goals_and_shots }
    @games.each do |game_id, game_data|
      add_goals_data(most_accurate, game_data)
    end
    most_accurate
  end

  def least_accurate_team
    least_accurate = Hash.new { |hash, key| hash[key] = goals_and_shots }
    @games.each do |game_id, game_data|
      add_goals_data(least_accurate, game_data)
    end
    least_accurate
  end

end
