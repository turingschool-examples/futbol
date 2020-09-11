class GameManager
  attr_reader :games, :tracker #do we need attr_reader?

  def initialize(file_path, tracker)
    @games = []
    @tracker = tracker
    create_games(file_path)
  end

  def create_games(file_path)
    games_data = CSV.read(file_path, headers:true) #may need to change .read to .load

    games_data.each do |data|
      games << Game.new()
    end
  end
end
