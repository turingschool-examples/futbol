require_relative '../tables/team_table'

class Team
  attr_reader :team_id,
              :franchiseid,
              :teamname,
              :abbreviation,
              :stadium,
              :link
  def initialize(data)
    @team_id= data[:team_id]
    @franchiseId =data[:franchiseid]
    @teamname = data[:teamname]
    @abbreviation = data[:abbreviation]
    @stadium = data[:stadium]
    @link = data[:link]
  end
end
