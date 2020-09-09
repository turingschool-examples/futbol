class TeamStatistics

  def initialize(stat_tracker)
    @stat_tracker = stat_tracker
  end

  def team_info(team_id)
    team_data = {}
    team_info = @stat_tracker[:teams]["team_id"].zip(@stat_tracker[:teams]["franchiseId"], @stat_tracker[:teams]["teamName"], @stat_tracker[:teams]["abbreviation"], @stat_tracker[:teams]["link"])
      team_id[0][0] == team_id
      # binding.pry
        team_data["team_id"] = @stat_tracker[:teams]["team_id"],
        team_data["franchiseId"] = @stat_tracker[:teams]["franchiseId"],
        team_data["teamName"] = @stat_tracker[:teams]["teamName"]
        team_data["abbreviation"] = @stat_tracker[:teams]["abbreviation"],
        team_data["link"] = @stat_tracker[:teams]["link"]
    end
  end
