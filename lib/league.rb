require_relative 'stat_holder'

class League < StatHolder
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium,
              :link,
              :goal
  
  def initialize(locations)
    super
    team_file = CSV.read locations[:teams], headers: true, header_converters: :symbol
    game_team_file = CSV.read locations[:game_teams], headers: true, header_converters: :symbol
    @team_id = team_file[:team_id]
    @franchise_id = team_file[:franchise_id]
    @team_name = team_file[:teamname]
    @abbreviation = team_file[:abbreviation]
    @stadium = team_file[:Stadium]
    @link = team_file[:link]  
    @goals = game_team_file[:goals]
  end

  def count_of_teams
    @team_id.count
  end
end