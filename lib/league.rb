require_relative 'stat_book'
class League < StatBook
  attr_reader :team_id,
              :teamname
  
  def initialize(locations)
    file = locations[:teams]
    super(file)
  end

  def count_of_teams
    @team_id.count
  end
end