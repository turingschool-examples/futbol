class GameManager
  attr_reader :games, :tracker #do we need attr_reader?

  def initialize(path, tracker)
    @games = []
    @tracker = tracker
    create_games(path)
  end

  def create_games(path)
    games_data = CSV.read(path, headers:true) #may need to change .read to .load

    @games = games_data.map do |data|
      Game.new(data, self)
    end
  end

  #------------SeasonStats

  def games_of_season(season)
    @games.find_all {|game| game.season == season}
  end

  def find_game_ids_for_season(season)
    games_of_season(season).map {|game| game.game_id }
  end

  def games_by_team(team_id)
    @games.select do |game|
      game.home_team_id == team_id || game.away_team_id == team_id
    end
  end
end
