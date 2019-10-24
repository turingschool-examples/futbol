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

  def highest_total_score
    @games.map do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end.max
  end

  def lowest_total_score
    @games.map do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end.min
  end
end
