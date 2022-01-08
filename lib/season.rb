class Season
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def winningest_coach(season)
    games_in_season = @games.select do |game|
      game if game[:season].to_i == season
    end
    game_ids = games_in_season.map do |game|
      game[:game_id]
    end
    games = @game_teams.select do |game|
     game if game_ids.include?(game[:game_id])
    end
    wins = games.select do |game|
      game if game[:result] == "WIN"
    end
    coach_wins_hash = Hash.new(0.0)
    wins.each do |game|
      coach_wins_hash[game[:head_coach]] += 1.0
    end
    games_coached = Hash.new(0.0)
    games.each do |game|
      games_coached[game[:head_coach]] += 1.0
    end
    coach_wins_hash.each_key do |key|
      coach_wins_hash[key] = coach_wins_hash[key] / games_coached[key]
    end
    coach_wins_hash.key(coach_wins_hash.values.max)
  end

  def worst_coach(season)
    games_in_season = @games.select do |game|
      game if game[:season].to_i == season
    end
    game_ids = games_in_season.map do |game|
      game[:game_id]
    end
    games = @game_teams.select do |game|
     game if game_ids.include?(game[:game_id])
    end
    loss = games.select do |game|
      game if game[:result] == "LOSS"
    end
    coach_loss_hash = Hash.new(0.0)
    loss.each do |game|
      coach_loss_hash[game[:head_coach]] += 1.0
    end
    games_coached = Hash.new(0.0)
    games.each do |game|
      games_coached[game[:head_coach]] += 1.0
    end
    coach_loss_hash.each_key do |key|
      coach_loss_hash[key] = coach_loss_hash[key] / games_coached[key]
    end
    coach_loss_hash.key(coach_loss_hash.values.max)
  end
end
