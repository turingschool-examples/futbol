require_relative 'game'
require 'csv'

class GameCollection < Collection
  def initialize(csv_file_path)
    super(csv_file_path, Game)
  end
end
