class GamesCollection
  attr_reader :games

  def initialize(games_path)
    @games = generate_objects_from_csv(games_path)
  end

  def generate_objects_from_csv(csv_games_path)
    objects = []
    CSV.foreach(csv_games_path, headers: true, header_converters: :symbol) do |row_object|
      objects << Game.new(row_object)
    end
    objects
  end

  def unique_seasons
    @games.map {|game| game.season}.uniq
  end

  def number_of_games_in_each_season
    seasons_of_games = @games.group_by {|game| game.season}
    seasons_of_games.values.map {|value| value.length}
  end

  def count_of_games_by_season
    target_hash = {}
    unique_seasons.each_with_index do |season, index|
      target_hash[season] = number_of_games_in_each_season[index]
    end
    target_hash
  end

  #   num_games_in_season = {}
  #   games_by_season.each do |season_of_game|
  #     num_games_in_season[season_of_game] = number_of_games_in_each_season
  #   end
  #   num_games_in_season
  # end
end
