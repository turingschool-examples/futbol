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


#-------------GameStatistics

  def highest_total_score
    result = @games.max_by do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end
    result.away_goals.to_i + result.home_goals.to_i
  end

  def lowest_total_score
    result = @games.min_by do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end
      result.away_goals.to_i + result.home_goals.to_i
    end
  end

  def count_of_games_by_season
    games_by_season_index = {}
    games_by_season.each do |season, games|
      games_by_season_index[season] = games.length
    end
    games_by_season_index
  end

  def games_by_season
    result = {}
    games.each do |game|
      if result[game.season] == nil
        result[game.season] = [game]
      else
        result[game.season] << game
      end
    end
    result
  end
