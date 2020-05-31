require_relative './game'
require_relative './game_collection'
require_relative './team'
require 'csv'
require 'pry'

class TeamCollection
  attr_reader :team_collection

  def initialize(team_collection)
    @team_collection = team_collection
  end

  def all
    all_teams = []
    CSV.read(team_collection, headers: true).each do |team|
        team_hash = {team_id: team["team_id"], franchiseid: team["franchiseId"],
        teamname: team["teamName"],
        abbreviation: team["abbreviation"],
        stadium: team["Stadium"],
        link: team["link"]
      }
      all_teams << Team.new(team_hash)
    end
    all_teams
  end
end
