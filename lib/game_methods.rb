# frozen_string_literal: true

require 'CSV'

# Holds methods that get data out of a CSV file
class GameMethods
  attr_reader :file_loc

  def initialize(file_loc)
    @file_loc = file_loc
  end
end
