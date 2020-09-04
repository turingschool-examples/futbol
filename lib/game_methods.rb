# frozen_string_literal: true

require 'CSV'

# Holds methods that get data out of a CSV file
class GameMethods
  attr_reader :file_loc, :table

  def initialize(file_loc)
    @file_loc = file_loc
    @table = create_table
  end

  def create_table
    CSV.parse(File.read(@file_loc), headers: true)
  end
end
