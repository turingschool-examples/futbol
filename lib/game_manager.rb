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
end
