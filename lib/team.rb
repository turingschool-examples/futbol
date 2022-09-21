class Team
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium,
              :link
  attr_accessor :team_games
  def initialize(team_data)
    @team_id = team_data[0]
    @franchise_id = team_data[1]
    @team_name = team_data[2]
    @abbreviation = team_data[3]
    @stadium = team_data[4]
    @link = team_data[5]
    @team_games = Hash.new(0)
  end

  def team_labels
    {"team_id" => @team_id,
     "franchise_id" => @franchise_id,
     "team_name" => @team_name,
     "abbreviation" => @abbreviation,
     "link" => @link
    }
  end

end
