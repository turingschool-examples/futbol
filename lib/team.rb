require 'pry'

class Team

attr_reader :team_id, :franchise_id, :team_name, :abbreviation,
            :stadium, :link

  def initialize(data)
    @team_id = data[:team_id]
    @franchise_id = data[:franchiseid]
    @team_name = data[:teamname]
    @abbreviation = data[:abbreviation]
    @stadium = data[:stadium]
    @link = data[:link]
  end

  # to_hash is used in the team_info method within stat_tracker - garrett
  def to_hash
    {"team_id" => @team_id, "franchise_id" => @franchise_id, "team_name" => @team_name,
     "abbreviation" => @abbreviation, "link" => @link}
  end

end
