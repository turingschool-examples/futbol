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

  # def count_of_total_wins(team_id)
  #   seasons.find_all do |season|
  #     season[1] == team_id && season[2] == "WIN"
  #   end.count
  # end
#
#   def average_wins_per_season
#     (count_of_total_wins.to_s / stat_tracker[:games]["game_id"].count).round(2)
#   end
  def season_data_set
    @stat_tracker[:games]["season"].zip(@stat_tracker[:games]["away_goals"], @stat_tracker[:games]["home_team_id"], @stat_tracker[:games]["away_goals"], @stat_tracker[:games]["home_goals"])
  end

#   def find_season
#     season_data_set.map do |season
#   end
#
#   def best_season(team_id)
#     season_data = {}
#     titles = ["season", "away_team_id", "home_team_id", "away_goals", "home_goals"]
#
#     titles.each_with_index do |title, index|
# binding.pry
#       season_data[title] = season_data_set[index]
#     end
    # highest_wins_per_season = {}
    #
    # season_data_set.find_all do |season|
    #   # season[0] == season[0]
    #   season[1] == team_id && season[2] == "WIN"
    # end.count
    # # returns [["2012030221", "6", "WIN"], ["2016030222", "6", "WIN"]]
    # season_data_set.map do |season|
    #   if season[0].eql?(season[0])
    #     season.find_all do |team|
    #       team[1] == team_id && team[2] == "WIN"
    #     end
    #   end
    # end
    # binding.pry
  #   seasons.map do |season|
  #     if highest_wins_per_season[season[0]].nil?
  #        highest_wins_per_season[season[0]] = (season[1][0].to_f + season[1][1].to_f)
  #     else
  #        highest_wins_per_season[season[0]] += (season[1][0].to_f + season[1][1].to_f)
  #     end
  #   end
  #   highest_wins_per_season
  
  # def worst_season
  #
  # end

  def season_win_data_set
    @stat_tracker[:game_teams]["game_id"].zip(@stat_tracker[:game_teams]["team_id"], @stat_tracker[:game_teams]["result"])
  end

  def total_games(team_id)
    season_win_data_set.find_all do |team|
      team[1] == team_id
    end.count.to_f
  end

  def winning_games(team_id)
    season_win_data_set.find_all do |team|
      team[1] == team_id && team[2] == "WIN"
    end.count.to_f
  end

  def average_win_percentage(team_id)
    "#{(winning_games(team_id)/total_games(team_id) * 100).round(2)}"
  end

  def score_data_set
    @stat_tracker[:game_teams]["team_id"].zip(@stat_tracker[:game_teams]["goals"])
  end

  def team_per_game(team_id)
    score_data_set.find_all do |team|
      team[0] == team_id
    end
  end

  def most_goals_scored(team_id)
    team_per_game(team_id).max_by do |goal|
      goal[1]
    end[1].to_i
  end

  def team_and_wins_data_set
    @stat_tracker[:teams]["team_id"].zip(@stat_tracker[:game_teams]["team_id"], @stat_tracker[:game_teams]["result"])
  end

  def fewest_goals_scored(team_id)
    team_per_game(team_id).min_by do |goal|
      goal[1]
    end[1].to_i
  end

  def favorite_opponent

  end
end
