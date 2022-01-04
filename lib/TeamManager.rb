require 'csv'

class TeamManager
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium,
              :link
  def initialize
    CSV.foreach("data/teams.csv", headers: true, header_converters: :symbol) do |row|
      @team_id = row[:team_id]
      @franchise_id = row[:franchiseid]
      @team_name = row[:teamname]
      @abbreviation = row[:abbreviation]
      @stadium = row[:stadium]
      @link = row[:link]
    end
  end
end


team = TeamManager.new
require "pry"; binding.pry
p team.data
# contents = CSV.read("./data/teams.csv")
# p contents

# @data = CSV.foreach("./data/teams.csv") do |row|
#   @team_id = row[:team_id]
#   @franchise_id = row[:franchiseid]
#   @team_name = row[:teamname]
#   @abbreviation = row[:abbreviation]
#   @stadium = row[:stadium]
#   @link = row[:link]
# end
