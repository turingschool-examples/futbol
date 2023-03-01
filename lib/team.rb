require_relative 'classes'

class Team

  attr_reader :team_id,
              :franchiseid,
              :teamname,
              :abbreviation,
              :stadium,
              :link

  def initialize(info)
    @team_id = info["team_id"]
    @franchiseid = info["franchiseId"]
    @teamname = info["teamName"]
    @abbreviation = info["abbreviation"]
    @stadium = info["stadium"]
    @link = info["link"]
  end
end