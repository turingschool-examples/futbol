require 'csv'
require 'pry'
class GameManager
  attr_accessor :data

  def initialize(path)
    @data = load_file(path)
  end

  def load_file(path)
    CSV.read(path)[1..-1].collect do |row|
      Game.new(row)
    end
  end
end
