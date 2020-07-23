require './lib/team'

class TeamManager
  attr_reader :teams_array

  def initialize(team_path)
    @teams_array = []
    CSV.foreach(team_path, headers: true) do |row|
        @teams_array << Team.new(row)
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

  def best_season(id)
    self.season_games(id)
    freq = @seasons.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    @seasons.max_by { |v| freq[v] }
  end





end
