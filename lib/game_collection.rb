require_relative 'game'
require_relative 'collection'
require_relative './modules/calculateable'
require 'csv'

class GameCollection < Collection
  include Calculateable

  def initialize(csv_file_path)
    super(csv_file_path, Game)
  end
end
