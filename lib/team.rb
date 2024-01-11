class Team
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium

  def initialize(attributes)
    @team_id = attributes[:team_id]
    @franchise_id = attributes[:franchise_id]
    @team_name = attributes[:team_name]
    @abbreviation = attributes[:abbreviation]
    @stadium = attributes[:stadium]
  end
  
=begin
stat tracker is going to be the one to collect all the
class of game shouldn't know anything about the class of teams

end
