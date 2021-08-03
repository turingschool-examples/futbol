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

  # def add_goals_data(accurate_hash, game_data)
  #   accurate_hash[game_data[:home].team_id][:total_goals] += game_data[:home].goals.to_i
  #   accurate_hash[game_data[:away].team_id][:total_goals] += game_data[:away].goals.to_i
  #   accurate_hash[game_data[:home].team_id][:total_shots] += game_data[:home].shots.to_i
  #   accurate_hash[game_data[:away].team_id][:total_shots] += game_data[:away].shots.to_i
  # end
  #
  # def accuracy
  #   accuracy = Hash.new {|h, k| h[k] = {total_goals: 0, total_shots: 0}}
  #   @games.each do |game_id, game_data|
  #     add_goals_data(accuracy, game_data)
  #   end
  #   accuracy
  # end

  # def add_coach_data(coach_wins, game_data)
  #   if game_data[:away].result == 'WIN'
  #     coach_wins[game_data[:away].head_coach][:total_wins] += 1
  #   elsif game_data[:away].result == 'LOSS'
  #     coach_wins[game_data[:home].head_coach][:total_wins] += 1
  #   end
  #   coach_wins[game_data[:home].head_coach][:total_games] += 1
  #   coach_wins[game_data[:away].head_coach][:total_games] += 1
  # end
  #
  # def coach_wins
  #   coach_wins = Hash.new {|h, k| h[k] = {total_games: 0, total_wins: 0}}
  #   @games.each do |game_id, game_data|
  #     add_coach_data(coach_wins, game_data)
  #   end
  #   coach_wins
  # end

  def add_tackle_data(tackles, game_data)
      tackles[game_data[:home].team_id] += game_data[:home].tackles.to_i
      tackles[game_data[:away].team_id] += game_data[:away].tackles.to_i
  end

  def tackles_by_team
    tackles_by_team = Hash.new(0)
    @games.each do |game_id, game_data|
      add_tackle_data(tackles_by_team, game_data)
    end
    tackles_by_team
  end

  def process_away_win(games_and_wins, game_data, season_id)
    if game_data[:game].away_goals > game_data[:game].home_goals
      games_and_wins[:total_wins] += 1
    end
    games_and_wins[:total_games] += 1
  end

  def process_home_win(games_and_wins, game_data, season_id)
    if game_data[:game].away_goals < game_data[:game].home_goals
      games_and_wins[:total_wins] += 1
    end
    games_and_wins[:total_games] += 1
  end

  def games_and_wins_by_team(team_id)
    games_and_wins = {total_games: 0, total_wins: 0}
    @games.each do |game_id, game_data|
      home_team_id = game_data[:game].home_team_id
      away_team_id = game_data[:game].away_team_id

      if away_team_id == team_id
        process_away_win(games_and_wins, game_data, game_data[:game].season)
      elsif home_team_id == team_id
        process_home_win(games_and_wins, game_data, game_data[:game].season)
      end
    end
    games_and_wins
  end
end
