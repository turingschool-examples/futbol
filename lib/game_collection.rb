class GameCollection
  attr_reader :total_games

  def initialize(game_path)
    @total_games = create_games(game_path)
  end

# created class method in Game to find all_games
  def create_games(game_path)
    csv = CSV.read("#{game_path}", headers: true, header_converters: :symbol)

    csv.map do |row|
      Game.new(row)
    end
  end

  # def all_games(game_path)
  #   @total_games
  # end

  # start w/ this
  # def highest_total_score
  #   max_game = 0
  #   @stats[:games].each do |game|
  #     if (game.home_goals + game.away_goals) > max_game
  #       max_game = (game.home_goals + game.away_goals)
  #     end
  #   end
  #   max_game
  # end

end
