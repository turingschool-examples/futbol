require 'csv'
require_relative 'collection'

class GameCollection < Collection
  attr_reader :games_list, :pct_data

  def initialize(file_path)
    @games_list = create_objects(file_path, Game)
    @pct_data = Hash.new { |hash, key| hash[key] = 0 }
  end
end
