require 'csv'

class StatTracker

  attr_reader :games, :teams, :game_teams
  def initialize (games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    games = CSV.table(locations[:games])
    teams = CSV.table(locations[:teams])
    game_teams = CSV.table(locations[:game_teams])
    StatTracker.new(games, teams, game_teams)
  end


 # Game Statistics

  def total_scores_by_game #helper for issue #2, #3, #6
    @games.values_at(:away_goals, :home_goals).map do |game|
      game[0] + game[1]
    end
  end

  def highest_total_score #issue #2
    total_scores_by_game.max
  end

  def lowest_total_score #issue #3
    total_scores_by_game.min
  end

  def home_wins #helper for issue #4
    home_win = 0.0
    @game_teams.values_at(:result, :hoa).flat_map {|row| home_win += 1 if row == ["WIN", "home"]}; home_win
  end

  def home_games #helper for issue #4
    home = 0.0
    @game_teams[:hoa].map {|row| home += 1 if row == "home"}; home
  end

  def percentage_home_wins #issue #4
    percentage = (home_wins/home_games) * 100
  end

  def percentage_visitor_wins #issue #5
        #sum of visitor wins / total games played

    away_wins = []
    game_results = game_teams.values_at(:hoa, :result)
    total_games_played = game_results.count.to_f

    game_results.each do |game|
    away_wins << game if game == ["away", "WIN"]

    end
    ((away_wins.count / total_games_played)*100).round(2)
  end

  def percentage_ties #issue #6
    ties = 0.0
    total_games = total_scores_by_game.count

    @games.values_at(:away_goals, :home_goals).each do |game|
      ties += 1 if game[0] == game[1]
    end
    ((ties/total_games)*100).round(1)
  end

  def count_of_games_by_season #issue 7
    counts = {}
    games.each do |game|
        season = game[:season]
        if counts[season].nil?
             counts[season] = 0
        end
        counts[season] += 1
    end
    counts
    # games.reduce({}) do |counts, game|
    #     season = game[:season]
    #     counts[season] = 0 if counts[season].nil?
    #     counts[season] += 1
    #     counts
    # end
  end

  def average_goals_per_game #issue #8
    total_scores_by_game.sum/@games.size
  end

  def average_goals_by_season #issue #9

  end



  def game_wins #Helper method not yet used
    win = 0.0
    @game_teams[:result].map {|row| win += 1 if row == "WIN"}; win
  end

  def game_losses #Helper method not yet used
    loss = 0.0
    @game_teams[:result].map {|row| loss += 1 if row == "LOSS"}; loss
  end

  def away_games #Helper method not yet used
    away = 0.0
    @game_teams[:hoa].map {|row| away += 1  if row == "away"}; away
  end


  # League Statistics

  def count_of_teams #issue # 10
    @teams[:teamname].count
  end

  def best_offense #issue # 11
    #need: average number of goals per team (array:key of team name value of average?)
    #get max of the listed averages
    #return name of that team



  end

  def worst_offense #issue # 12



  end

  def highest_scoring_visitor #issue # 13



  end

  def home_scores_by_team_id #helper method for issue #14
    scores_by_team_id = {}
    home_scores = game_teams.values_at(:team_id, :hoa, :goals).find_all do |game|
      game[1] == 'home'
    end

    @game_teams[:team_id].each do |id|
      scores_by_team_id[id] = []
    end

    home_scores.each do |game|
      scores_by_team_id[game[0]] << game[2].to_f
    end
    scores_by_team_id
  end

  def team_by_id #helper method for issue #14
    @teams.values_at(:team_id, :teamname).to_h
  end

  def average_home_scores_by_team_id #helper method for issue #14
    average_scores= {}
    home_scores_by_team_id.each do |team, scores|
      average = scores.sum/scores.count
      average_scores[team] = average.round(1)
    end
    average_scores
  end

  def highest_scoring_home_team #issue # 14

    max_average = average_home_scores_by_team_id.values.max

    team_by_id[average_home_scores_by_team_id.key(max_average)]
  end

  def lowest_scoring_visitor #issue # 15



  end

  def lowest_scoring_home_team #issue # 16



  end


  # Season Statistics

  def winningest_coach #issue # 17



  end

  def worst_coach #issue # 18



  end

  def most_accurate_team #issue # 19



  end

  def least_accurate_team #issue # 20



  end

  def most_tackles #issue # 21



  end

  def fewest_tackles #issue # 22



  end

  def team_info #issue # 23



  end

  def best_season #issue # 24



  end

  def worst_season #issue # 25



  end

  def average_win_percentage #issue # 26



  end

  def most_goals_scored #issue # 27



  end

  def fewest_goals_scored #issue # 28



  end

  def favorite_opponent #issue # 29



  end

  def rival #issue # 30



  end

end
