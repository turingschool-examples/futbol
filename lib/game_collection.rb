require_relative './game'
require 'csv'

class GameCollection < Collection
  # attr_accessor :games

  def initialize(csv_file_path)
    # @games = create_games(csv_file_path)
    super(csv_file_path, Game)
  end

  # def from_csv(csv_file_path)
  #   CSV.read(csv_file_path, headers: true, header_converters: :symbol)
  # end

  # def create_games(csv_file_path)
  #   from_csv(csv_file_path).map do |row|
  #     Game.new(row)
  #   end
  # end
end
