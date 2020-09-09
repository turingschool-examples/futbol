class TeamStatistics

  def initialize(stat_tracker)
    @stat_tracker = stat_tracker
    # @team_id      = team_id["team_id"]
    # @franchise_id = team_id["franchiseId"]
    # @team_name    = team_id["teamName"]
    # @abbreviation = team_id["abbreviation"]
    # @link         = team_id["link"]
  end

  def team_data_set
    @stat_tracker[:teams]["team_id"].zip(@stat_tracker[:teams]["franchiseId"], @stat_tracker[:teams]["teamName"], @stat_tracker[:teams]["abbreviation"], @stat_tracker[:teams]["link"])
  end

  def match_team_id(team_id)
    team_data_set.map do |info| #represents the nested array
      return info if info[0] == team_id
    end
    #returns ["1", "23", "Atlanta United", "ATL", "/api/v1/teams/1"]
  end

  def team_info(team_id)
    team_data = {}
    headers = ["team_id", "franchiseId", "teamName", "abbreviation", "link"]

    headers.each_with_index do |header, index|
      team_data[header] = match_team_id(team_id)[index]
    end
    team_data
    # returns {"team_id"=>"1", "franchiseId"=>"23", "teamName"=>"Atlanta United", "abbreviation"=>"ATL", "link"=>"/api/v1/teams/1"}
 end
end
