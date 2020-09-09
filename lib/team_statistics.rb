class TeamStatistics

  def initialize(stat_tracker, team_id)
    @stat_tracker = stat_tracker
    @team_id      = team_id["team_id"]
    @franchise_id = team_id["franchiseId"]
    @team_name    = team_id["teamName"]
    @abbreviation = team_id["abbreviation"]
    @link         = team_id["link"]
  end

  def team_data_set
    @stat_tracker[:teams]["team_id"].zip(@stat_tracker[:teams]["franchiseId"], @stat_tracker[:teams]["teamName"], @stat_tracker[:teams]["abbreviation"], @stat_tracker[:teams]["link"])
  end

  def match_team_id(team_id)
  end
  def team_info(team_id)
    team_data = {team_id[]}
binding.pry
    name_matches = rows.find_all do |rows|
      row["Child's First Name"].downcase == name.downcase
    end
    name_matches.each do |match|
      results << Name.new(match)

      # team_data_set.each do |teams|
      #   teams.each do |team_id|
      #     if team_id ==  @stat_tracker[:teams]["team_id"]
      #     team_data[team_id] = team_information
      #   end
  binding.pry
      # team_id[0][0] == team_id
      # binding.pry
     #  team_information.map do |team_id|
     #    team_data =[*([key, team_information].transpose.flatten)]
     # # team_information.collect {|team_id| [team_id, "team_id"]}
     #    team_data["team_id"] = @stat_tracker[:teams]["team_id"],
     #    team_data["franchiseId"] = @stat_tracker[:teams]["franchiseId"],
     #    team_data["teamName"] = @stat_tracker[:teams]["teamName"]
     #    team_data["abbreviation"] = @stat_tracker[:teams]["abbreviation"],
#      #    team_data["link"] = @stat_tracker[:teams]["link"]
#       end
#   end
 end

  # def best_season(team_id)
  #   # if team_id == away_team_id || home_team_id
  #   #


end
