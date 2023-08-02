#./lib/teams_factory.rb

class TeamsFactory
  attr_reader :teams

  def initialize
    @teams = []
  end

  def create_teams
    contents = CSV.open "./data/teams.csv", headers: true, header_converters: :symbol
require 'pry';binding.pry
    contents.each do |team|
      team_id = team[:team_id]
      franchise_id = team[:franc]
    end
  end
end