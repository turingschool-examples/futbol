require 'csv'
require_relative 'game'
require_relative 'csvloadable'

class GamesCollection
  include CsvLoadable
  attr_reader :games

  def initialize(csv_file_path)
    @games = create_games(csv_file_path)
  end

  def create_games(csv_file_path)
    create_instances(csv_file_path, Game)
  end
end
