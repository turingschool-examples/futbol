require 'CSV'
require 'pry'
require './lib/team'

class TeamData
  def initialize(data)
    @all_team_data = []

    CSV.foreach('./data/teams.csv', headers: true, header_converters: :symbol) do |row|
      @all_team_data << Team.new(row)
    end

  end

end



























# require 'CSV'
# require 'pry'
# # require './data/teams.csv'
#
# class TeamData
#
#   def initialize
#     @all_teams_data = Array.new
#   end
#
#   CSV.foreach('./data/teams.csv', headers: true, header_converters: :symbol) do |row|
#     @all_teams_data << row.to_h
#     # team_id = row[:team_id].to_i
#     # id = row[:id]
#     # franchiseId = row[:franchiseId].to_i
#     # teamName = row[:teamName]
#     # abbreviation = row[:abbreviation]
#     # stadium = row[:stadium]
#     # link = row[:link]
#
#     # @all_teams_data << convert_to_team_data(row)
#   end
#   p @all_teams_data
#   binding.pry
# end

  # def convert_to_team_data(row)
  #   row = Team.new({
  #     team_id: row[:team_id].to_i,
  #     id: row[:id],
  #     franchiseId: row[:franchiseId].to_i,
  #     teamName: row[:teamName],
  #     abbreviation: row[:abbreviation],
  #     stadium: row[:stadium],
  #     link: row[:link]
  #     })
  #     binding.pry
  #
  # end
