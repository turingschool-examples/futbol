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
    #returns ["1", "23", "Atlanta United", "ATL", "/api/v1/teams/1"]
    team_data_set.map do |info|
      return info if info[0] == team_id
    end
  end

  def team_info(team_id)
    team_data = {}
    # returns {"team_id"=>"1", "franchiseId"=>"23", "teamName"=>"Atlanta United", "abbreviation"=>"ATL", "link"=>"/api/v1/teams/1"}
    headers = ["team_id", "franchiseId", "teamName", "abbreviation", "link"]

    headers.each_with_index do |header, index|
      team_data[header] = match_team_id(team_id)[index]
    end
    team_data
  end

#[x] 2/3 Best and Worst Season
  def season_win_data_set
    @stat_tracker[:game_teams]["game_id"].zip(@stat_tracker[:game_teams]["team_id"], @stat_tracker[:game_teams]["result"])
  end


  def total_games_by_season(team_id)
    total_season_games = {}
    # returns for team_id '3' {:total_2012=>2, :total_2016=>0, :total_2014=>1}
    total_2012 = season_win_data_set.find_all do |game|
      game[0].start_with?("2012") && game[1] == team_id
    end.count
    season_win_data_set.map do |game|
      if game[0].start_with?("2012")
        total_season_games["20122013"] = total_2012
      end
    end
    total_2013 = season_win_data_set.find_all do |game|
      game[0].start_with?("2013") && game[1] == team_id
    end.count
    season_win_data_set.map do |game|
      if game[0].start_with?("2013")
        total_season_games["20132014"] = total_2013
      end
    end
    total_2014 = season_win_data_set.find_all do |game|
      game[0].start_with?("2014") && game[1] == team_id
    end.count
    season_win_data_set.map do |game|
      if game[0].start_with?("2014")
        total_season_games["20142015"] = total_2014
      end
    end
    total_2015 = season_win_data_set.find_all do |game|
      game[0].start_with?("2015") && game[1] == team_id
    end.count
    season_win_data_set.map do |game|
      if game[0].start_with?("2015")
        total_season_games["20152016"] = total_2015
      end
    end
    total_2016 = season_win_data_set.find_all do |game|
      game[0].start_with?("2016") && game[1] == team_id
    end.count
    season_win_data_set.map do |game|
      if game[0].start_with?("2016")
        total_season_games["20162017"] = total_2016
      end
    end
    total_season_games
  end

  def total_wins_by_season(team_id)
    winning_games_by_season = {}
    # returns for team_id '3' {"20122013"=>0, "20142015"=>0, "20162017"=>0}
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
    winning_games_by_season
  end

  def total_loss_by_season(team_id)
    losing_games_by_season = {}
    # returns for team_id '3' {"20122013"=>0, "20142015"=>0, "20162017"=>0}
    loss_results_2012 = season_win_data_set.find_all do |game|
      game[0].start_with?("2012") && game[1] == team_id && game[2] == "LOSS"
      end.count
      season_win_data_set.map do |game|
        if game[0].start_with?("2012")
            losing_games_by_season["20122013"] = loss_results_2012
        end
      end
    loss_results_2013 = season_win_data_set.find_all do |game|
      game[0].start_with?("2013") && game[1] == team_id && game[2] == "LOSS"
      end.count
    season_win_data_set.map do |game|
      if game[0].start_with?("2013")
          losing_games_by_season["20132014"] = loss_results_2013
      end
    end
    loss_results_2014 = season_win_data_set.find_all do |game|
      game[0].start_with?("2014") && game[1] == team_id && game[2] == "LOSS"
      end.count
    season_win_data_set.map do |game|
      if game[0].start_with?("2014")
          losing_games_by_season["20142015"] = loss_results_2014
      end
    end
    loss_results_2015 = season_win_data_set.find_all do |game|
      game[0].start_with?("2015") && game[1] == team_id && game[2] == "LOSS"
      end.count
    season_win_data_set.map do |game|
      if game[0].start_with?("2015")
          losing_games_by_season["20152016"] = loss_results_2015
      end
    end
    loss_results_2016 = season_win_data_set.find_all do |game|
      game[0].start_with?("2016") && game[1] == team_id && game[2] == "LOSS"
      end.count
    season_win_data_set.map do |game|
      if game[0].start_with?("2016")
          losing_games_by_season["20162017"] = loss_results_2016
      end
    end
    losing_games_by_season
  end

  def best_season(team_id)
    best = {}
    total_wins_by_season(team_id).each do |season_id, wins|
      best[season_id] = ((wins.to_f/total_games_by_season(team_id)[season_id]) * 100)
    end
    best.max_by {|season_id, win_percentage| win_percentage}.to_a[0]
  end

  def worst_season(team_id)
    worst = {}
    total_loss_by_season(team_id).each do |season_id, loss|
      worst[season_id] = ((loss.to_f/total_games_by_season(team_id)[season_id]) * 100)
    end
    worst.max_by {|season_id, loss_percentage| loss_percentage}.to_a[0]
  end

# [x] 4. Average Win Percentage
  def total_games(team_id)
    #returns for team_id '6' = 7.0
    season_win_data_set.find_all do |team|
      team[1] == team_id
    end.count.to_f
  end

  def winning_games(team_id)
    #returns for team_id '6' = 4.0
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
    #returns for team_id '6' [["6", "3"], ["6", "3"], ["6", "1"], ["6", "3"], ["6", "4"], ["6", "2"], ["6", "3"]]
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

# [ ] 7/8 Favorite and Rival Opponent **change name of 'season_win_data_set'
  def favorite_opponent(team_id)
    #evaluate all teams that given team has played and won
    games_won = season_win_data_set.find_all do |game_id|
      team_id == game_id[1] && game_id[2] == "WIN"
    end
    winning_game_ids = games_won.map do |set|
      set.first
    end
    opposing_teams = winning_game_ids.map do |game_id|
       season_win_data_set.find_all do |array|
         game_id == array[0] unless array[1] == team_id
       end
     end
  binding.pry
  end

  # def rival(team_id)
  #   find_winner(team_id)
  #   average_win_percentage(team_id) #of the opponent
  #   team_info(team_id).teamName
  # end
   # end
end
