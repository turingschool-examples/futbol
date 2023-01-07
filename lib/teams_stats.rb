require './lib/modules'

class TeamStats
  include Sort

  attr_reader :teams

  def initialize(teams)
    @teams = teams
  end

  def team_info(team_id)
    team_hash = {
      'team_id' => nil,
      'franchise_id' => nil,
      'team_name' => nil,
      'abbreviation' => nil,
      'stadium' => nil,
      'link' => nil
    }

    find_team_by_id[team_id].each do |team|
      x = 0
      team_hash.each do |info, value|
        team_hash[info] = team.info.values[x]
        x += 1
      end
    end
    team_hash.delete('stadium')
    team_hash
  end
end