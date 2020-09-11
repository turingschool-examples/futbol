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

  def total_games_by_season(team_id)
    total_season_games = {}
    season_win_data_set.find_all do |game|
      if game[0].start_with?("2012") && game[1] == team_id
        total_season_games[total_2012] = game
      elsif game[0].start_with?("2013") && game[1] == team_id
          total_season_games[total_2013] = game
      elsif game[0].start_with?("2014") && game[1] == team_id
            total_season_games[total_2014] = game
      elsif game[0].start_with?("2015") && game[1] == team_id
        total_season_games[total_2015] = game
      elsif game[0].start_with?("2016") && game[1] == team_id
          total_season_games[total_2016] = game
        end
    end.count
    # total_2013 = season_win_data_set.find_all do |game|
    # elsif game[0].start_with?("2013") && game[1] == team_id
    #     total_2013 = game
    #   end
    # end.count
    # total_2014 = season_win_data_set.find_all do |game|
    #   if game[0].start_with?("2014") && game[1] == team_id
    #     total_2014 = game
    #   end
    # end.count
    # total_2015 = season_win_data_set.find_all do |game|
    #   if game[0].start_with?("2015") && game[1] == team_id
    #     total_2015 = game
    #   end
    # end.count
    # total_2016 = season_win_data_set.find_all do |game|
    #   if game[0].start_with?("2016") && game[1] == team_id
    #     total_2016 = game
    #   end
    # end.count
  end

  def win_results(team_id)
    winning_games_by_season = {}

    win_results_2012 = season_win_data_set.find_all do |game|
      game[0].start_with?("2012") && game[1] == team_id && game[2] == "WIN"
      end.count
      season_win_data_set.map do |game|
        if game[0].start_with?("2012")
            winning_games_by_season["20122013"] = win_results_2012
        end
      end
    win_results_2013 = season_win_data_set.find_all do |game|
      game[0].start_with?("2013") && game[1] == team_id && game[2] == "WIN"
      end.count
    season_win_data_set.map do |game|
      if game[0].start_with?("2013")
          winning_games_by_season["20132014"] = win_results_2013
      end
    end
    win_results_2014 = season_win_data_set.find_all do |game|
      game[0].start_with?("2014") && game[1] == team_id && game[2] == "WIN"
      end.count
    season_win_data_set.map do |game|
      if game[0].start_with?("2014")
          winning_games_by_season["20142015"] = win_results_2014
      end
    end
    win_results_2015 = season_win_data_set.find_all do |game|
      game[0].start_with?("2015") && game[1] == team_id && game[2] == "WIN"
      end.count
    season_win_data_set.map do |game|
      if game[0].start_with?("2015")
          winning_games_by_season["20152016"] = win_results_2015
      end
    end
    win_results_2016 = season_win_data_set.find_all do |game|
      game[0].start_with?("2016") && game[1] == team_id && game[2] == "WIN"
      end.count
    season_win_data_set.map do |game|
      if game[0].start_with?("2016")
          winning_games_by_season["20162017"] = win_results_2016
      end
    end
  end

  def best_season(team_id)
    binding.pry
  end

  # def loss_results(team_id)
  #   season_win_data_set.find_all do |game|
  #     game[1] == team_id && game[2] == "LOSS"
  #   end
  # end
  # def worst_season(team_id)
  #   season_win_data_set.find_all do |info|
  #   info[2] == "LOSS" && info[1] == team_id
  #    return info[0]
  # end

# [x] 4. Average Win Percentage
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
  # def favorite_opponent(team_id)
  #   !find_winner(team_id)
  #   average_win_percentage(team_id)
  #   team_info(team_id).teamName
  # end
  #
  # def rival(team_id)
  #   find_winner(team_id)
  #   average_win_percentage(team_id) #of the opponent
  #   team_info(team_id).teamName
  # end
   # end
end
