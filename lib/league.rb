class League
  attr_reader :all_games, :all_teams, :all_game_teams

  def initialize(all_games, all_teams, all_game_teams)
    @all_games = all_games
    @all_teams = all_teams
    @all_game_teams = all_game_teams
  end

  def total_goals_array
    @all_games.map do |game|
      game.home_goals.to_i + game.away_goals.to_i
    end
  end

  def games_by_season
    games_by_season = Hash.new(0)
    @all_games.each do |game|
      games_by_season[game.season] += 1
    end
    games_by_season
  end
end
