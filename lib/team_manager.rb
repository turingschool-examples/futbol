require_relative '../lib/team'

class TeamManager
  attr_reader :teams_array

  def initialize(team_path)
    @teams_array = []
    CSV.foreach(team_path, headers: true) do |row|
        @teams_array << Team.new(row)
    end
end

  def size
    @teams_array.size
  end

  def find_by_id(team_id)
      @teams_array.find do |team|
        team.team_id == team_id
   end
  end

  def team_info(id)
    hash = {}
    team = @teams_array.select do |team| team.team_id == "#{id}"
    end
    team.each do |team|
      hash["team_id"] = team.team_id
      hash["franchise_id"] = team.franchise_id
      hash["team_name"] = team.team_name
      hash["abbreviation"] = team.abbreviation
      hash["link"] = team.link
    end
    hash
  end
end
