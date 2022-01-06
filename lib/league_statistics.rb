require 'csv'
require 'pry'

class LeagueStatistics
  attr_reader :files

  def initialize(files)
    @files = files
    @teams_file = CSV.read files[:teams], headers: true, header_converters: :symbol
    @games_file = CSV.read files[:games], headers: true, header_converters: :symbol
  end

  end
