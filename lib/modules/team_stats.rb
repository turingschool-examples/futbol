require_relative './calculateable'
require_relative './gatherable'

module TeamStats
  include Calculateable
  include Gatherable

  def team_info(team_id)
    team = @teams.collection[team_id]
    team_info_hash(team)
  end

  def team_info_hash(team)
    {
      'team_id' => team.team_id,
      'franchise_id' => team.franchise_id,
      'team_name' => team.team_name,
      'abbreviation' => team.abbreviation,
      'link' => team.link
    }
  end

  def average_win_percentage
    
  end
end
