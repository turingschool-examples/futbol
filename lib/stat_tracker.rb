require "csv"

class StatTracker
  attr_reader :games,:teams, :game_teams

  def initialize(locations)
    @games = CSV.read(locations[:games], headers:true, header_converters: :symbol)
    #require 'pry';binding.pry
    @teams = CSV.read(locations[:teams], headers:true, header_converters: :symbol)
    @game_teams = CSV.read(locations[:game_teams], headers:true, header_converters: :symbol)
  end

    def self.from_csv(locations)
      StatTracker.new(locations)
    end
  end
