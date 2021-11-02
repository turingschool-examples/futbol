require 'csv'
require_relative './team'

class StatTracker
  # attr_reader

  def initialize()

  end

  def self.from_csv(locations)
    rows = CSV.read(locations[:teams], headers: true)
    rows.each do |row|
      require 'pry'; binding.pry
      team_id = row["team_id"]
      franchise_id = row["franchiseId"]
      team_name = row["teamName"]
      abbreviation = row["abbreviation"]
      stadium = row["Stadium"]
      link = row["link"]
      team = Team.new(team_id, franchise_id, team_name, abbreviation, stadium, link)
    end

    # rows = CSV.read(locations[:games], headers: true)
    # rows.each do |team|
    #
    #   require 'pry'; binding.pry
    # end
    #
    # rows = CSV.read(locations[:game_teams], headers: true)
    # rows.each do |team|
    #
    #   require 'pry'; binding.pry
    # end
  end
end
