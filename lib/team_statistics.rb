class TeamStatistics
  attr_reader :stat_tracker

  def initialize(stat_tracker)
    @stat_tracker = stat_tracker
  end
# [x] 1. Team Info
  def team_data_set
    @stat_tracker[:teams]["team_id"].zip(@stat_tracker[:teams]["franchiseId"], @stat_tracker[:teams]["teamName"], @stat_tracker[:teams]["abbreviation"], @stat_tracker[:teams]["link"])
  end

  def match_team_id(team_id)
    team_data_set.map do |info|
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

#[ ] 2/3 Best and Worst Season
  # def season_data_set
  #   @stat_tracker[:games]["season"].zip(@stat_tracker[:games]["away_team_id"], @stat_tracker[:games]["home_team_id"], @stat_tracker[:games]["away_goals"], @stat_tracker[:games]["home_goals"])
  # require "pry"; binding.pry
  # end
  # def season_data_set
  #   @stat_tracker[:game_teams]["game_id"].zip(@stat_tracker[:game_teams]["team_id"], @stat_tracker[:game_teams]["result"])
  # end
  #
  # def game_id_to_season_id
  #   games_teams_data("game_id").map do |game_id|
  #     last_year = game_id[0..3]
  #     (last_year.to_i - 1).to_s.concat(last_year)
  #   end
  # end

  # def find_team_id_away_or_home(team_id)
  #   @season_data_set.find_all |id|
  #     id.away_team_id == team_id || id.home_team_id == team_id
  #   end
  # end
  #
  # def find_winner(team_id)
  #   winner = @season_data_set.map do |season|
  #     if season.away_goals - season.home_goals > 0
  #       winner = "away"
  #     elsif season.away_goals - season.home_goals < 0
  #       winner = "home"
  #     end
  #   end

  # def best_season(team_id)
  #   @season_data_set
  # end

  # def worst_season(team_id)
  #   @season_data_set
  # end

# [x] 4. Average Win Percentage
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

# [x] 5/6 Most and Fewest Goals Scored
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

  def fewest_goals_scored(team_id)
    team_per_game(team_id).min_by do |goal|
      goal[1]
    end[1].to_i
  end

# [ ] 7/8 Favorite and Rival Opponent
  def favorite_opponent(team_id)
    !find_winner(team_id)
    average_win_percentage(team_id)
    team_info(team_id).teamName
  end
  #
  # def rival(team_id)
  #   find_winner(team_id)
  #   average_win_percentage(team_id) #of the opponent
  #   team_info(team_id).teamName
  # end
end
