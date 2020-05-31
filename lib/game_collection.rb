require_relative 'loadable'
require_relative 'game'

class GameCollection
  include Loadable

  attr_reader :games_array

  def initialize(file_path)
    @games_array = create_games_array(file_path)
  end

  def create_games_array(file_path)
    load_from_csv(file_path, Game)
  end

end
