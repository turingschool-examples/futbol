require_relative "./teams"
require_relative "./game"
require_relative "./game_teams"

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    games = Game.create_multiple_games(locations[:games])
    teams = Teams.create_multiple_teams(locations[:teams])
    game_teams = GameTeams.create_multiple_game_teams(locations[:game_teams])
    StatTracker.new(games, teams, game_teams)
  end

  def highest_total_score
    @games.map { |game| [game.home_goals.to_i, game.away_goals.to_i].sum }.max
  end

  def lowest_total_score
    @games.map { |game| [game.home_goals.to_i, game.away_goals.to_i].sum }.min
  end

  def percentage_home_wins
    ((@games.find_all { |game| game.home_goals.to_i > game.away_goals.to_i }.size)/(games.size).to_f).round(2)
  end

  def percentage_visitor_wins
    ((@games.find_all { |game| game.home_goals.to_i < game.away_goals.to_i }.size.to_f)/(games.size)).round(2)
  end

  def percentage_ties
    ((@games.find_all { |game| game.home_goals.to_i == game.away_goals.to_i }.size.to_f)/(games.size)).round(2)
  end

  def count_of_games_by_season
    hash = Hash.new(0)
    @games.each { |game| hash[game.season] += 1}
    hash
  end

  def average_goals_per_game
    total_goals_per_game = []
    @games.map { |game| total_goals_per_game << [game.home_goals.to_i, game.away_goals.to_i].sum }
    ((total_goals_per_game.sum.to_f) / (@games.size)).round(2)
  end

  def average_goals_by_season
    twelve_season = @games.find_all do |game|
      game.season == "20122013"
    end
    sixteen_season = @games.find_all do |game|
      game.season == "20162017"
    end
    fourteen_season = @games.find_all do |game|
      game.season == "20142015"
    end
    fifteen_season = @games.find_all do |game|
      game.season == "20152016"
    end
    thirteen_season = @games.find_all do |game|
      game.season == "20132014"
    end
    seventeen_season = @games.find_all do |game|
      game.season == "20172018"
    end
    hash = Hash.new(0)
    @games.each do |game|
      hash[game.season] += ((game.home_goals.to_i + game.away_goals.to_i))
    end

    hash.map do |season, total|
      if season == "20122013"
        # require 'pry' ; binding.pry
        hash[season] = (total / (twelve_season.count).to_f).round(2)
      elsif season == "20162017"
        hash[season] = (total / (sixteen_season.count).to_f).round(2)
      elsif season == "20142015"
        hash[season] = (total / (fourteen_season.count).to_f).round(2)
      elsif season == "20152016"
        hash[season] = (total / (fifteen_season.count).to_f).round(2)
      elsif season == "20132014"
        hash[season] = (total / (thirteen_season.count).to_f).round(2)
      elsif season == "20172018"
        hash[season] = (total / (seventeen_season.count).to_f).round(2)
      end
    end
    hash
  end

  # def most_goals_scored(team_id)  #use game_teams, iterate thru game_teams and find the max
  #   @game_teams.map do |game|
  #     if team_id == game.team_id

  #       game.goals.to_i
  #       require 'pry';binding.pry
  #       end
  #     end
  #   end

  def most_goals_scored(team_id)
    goals_by_game = []
    @game_teams.each do |game|
      if team_id == game.team_id
        goals_by_game << game.goals.to_i
      end
    end
    goals_by_game.max
  end

  def fewest_goals_scored(team_id)
    goals_by_game = []
    @game_teams.each do |game|
      if team_id == game.team_id
        goals_by_game << game.goals.to_i
      end
    end
    goals_by_game.min
  end

  def team_isolator(team_id) #game_teams helper, returns all of a team's games
    team_games = []
    @game_teams.each do |game|
      if team_id == game.team_id
        team_games << game
      end
    end
    team_games
  end

  def win_isolator(team_id) #game_teams helper, returns all of a team's wins in an array
    @game_teams.find_all do |game|
      team_id == game.team_id && game.result == "WIN"
    end
  end

  def season_grouper #games helper, returns a hash with the season as the key and array of all games for the season as the value
    @games.group_by do |game|
      game.season
    end
  end

  def average_win_percentage(team_id)
    total_games = team_isolator(team_id).count
    total_wins = win_isolator(team_id).count
    (total_wins.to_f / total_games).round(2)
  end

  def season(team_id, season) #games helper, returns array of all of a team's games for one season
    games_by_season = []
    @games.each do |game|
      if (game.home_team_id == team_id || game.away_team_id == team_id) && game.season == season
        games_by_season << game
      end
    end
    games_by_season
  end

  def all_team_games(team_id) #games helper, returns all of a team's games in an array
    all_games = []
    @games.each do |game|
      if game.home_team_id == team_id || game.away_team_id == team_id
        all_games << game
      end
    end
    all_games
  end

  def team_season_grouper(team_id) #groups all of a team's games by season in a hash: the key is the season and the values are the team's games for that season
    all_games = all_team_games(team_id)
    all_games.group_by do |game|
      game.season
    end
  end

  def team_season_game_counter(team_id) #incomplete helper
    games_by_season_hash = team_season_grouper(team_id)
  end

  def team_info(team_id)
    team_hash = Hash.new(0)
    @teams.each do |team|
      if team_id == team.team_id
        team_hash["team_id"] = team.team_id
        team_hash["franchise_id"] = team.franchise_id
        team_hash["team_name"] = team.team_name
        team_hash["abbreviation"] = team.abbreviation
        team_hash["link"] = team.link
      end
    end
    team_hash
  end

  def best_season(team_id) #this is not done and the one below needs to be refactored or tossed out and become a helper. this groups a team's seasons into arrays
    # max of total number of wins (home wins and away wins) in a season/total number of games in a season
    #by using season_grouper, we get a hash with 6 keys(the seasons). the values of each key are the games in that season
    #we can use all_team_games to create an array of all of a team's games. how do we split this by season?
    all_games = all_team_games(team_id)
    seasons_hash = season_grouper
    season_1 = []
    season_2 = []
    season_3 = []
    season_4 = []
    season_5 = []
    season_6 = []
    all_games.each do |game|
      if game.season == "20122013"
        season_1 << game
      elsif game.season == "20132014"
        season_2 << game
      elsif game.season == "20142015"
        season_3 << game
      elsif game.season == "20152016"
        season_4 << game
      elsif game.season == "20162017"
        season_5 << game
      elsif game.season == "20172018"
        season_6 << game
      end
    end
    season_1
    season_2
    season_3
    season_4
    season_5
    season_6
  end

  def count_of_teams
    @teams.count { |team| team.team_id }
  end

  def best_offense
    team_scores = Hash.new { |h, k| h[k] = [] }
    @game_teams.each { |game_team| team_scores[game_team.team_id] << game_team.goals.to_f }

    team_scores_average =
      team_scores.map do |id, scores|
        average = ((scores.sum) / (scores.length)).round(2)
        [id, average]
      end.max { |team_avg_1, team_avg_2| team_avg_1[1] <=> team_avg_2[1] }
    team_id_to_name[team_scores_average[0]]
  end

  def worst_offense
    team_scores = Hash.new { |h, k| h[k] = [] }
    @game_teams.each { |game_team| team_scores[game_team.team_id] << game_team.goals.to_f }

    team_scores_average =
      team_scores.map do |id, scores|
        average = ((scores.sum) / (scores.length)).round(2)
        [id, average]
      end.min { |team_avg_1, team_avg_2| team_avg_1[1] <=> team_avg_2[1] }
    team_id_to_name[team_scores_average[0]]
  end

  def highest_scoring_visitor
    away_team_scores = Hash.new { |h, k| h[k] = [] }
    @games.each { |game| away_team_scores[game.away_team_id] << game.away_goals.to_f }

    visitor_scores_average =
      away_team_scores.map do |id, scores|
        average = ((scores.sum) / (scores.length)).round(2)
        [id, average]
      end.max { |visitor_avg_1, visitor_avg_2| visitor_avg_1[1] <=> visitor_avg_2[1] }
    team_id_to_name[visitor_scores_average[0]]
  end

  def highest_scoring_home_team
    home_team_scores = Hash.new { |h, k| h[k] = [] }
    @games.each { |game| home_team_scores[game.home_team_id] << game.home_goals.to_f }

    home_scores_average =
      home_team_scores.map do |id, scores|
        average = ((scores.sum) / (scores.length)).round(2)
        [id, average]
      end.max { |home_avg_1, home_avg_2| home_avg_1[1] <=> home_avg_2[1] }
    team_id_to_name[home_scores_average[0]]
  end


  def winningest_coach(season_id)
    coaches = {}
    game_id_list = []
    @games.each do |game|
      if game.season == season_id
          game_id_list << game.game_id
        end
    end
    coaches = Hash.new(0)

    @game_teams.each do |game_team|
      game_id = game_team.game_id
      coach = game_team.head_coach
      if !game_id_list.include?game_id
        next
      end

        if game_team.result == "WIN"
            coaches[coach]+=1
          end
        end

      coach_percentage_won =
      coaches.map do |coach_name, game_win|
        percentage_won = (game_win.to_f/game_id_list.length) * 100
        [coach_name, percentage_won]
      end.to_h

      winningest_coach= coach_percentage_won.max {|coach_average_1, coach_average_2| coach_average_1[1]<=>coach_average_2[1]}
      winningest_coach[0]
    end


  def worst_coach(season_id)

    coaches = {}
    game_id_list = []
    @games.each do |game|
      if game.season == season_id
          game_id_list << game.game_id

      end
    end
    coaches = Hash.new(0)

    @game_teams.each do |game_team|
      game_id = game_team.game_id
      coach = game_team.head_coach
      if !game_id_list.include?game_id
        next
      end

        if game_team.result == "LOSS"
            coaches[coach]+=1
        end
      end

      coach_percentage_lost = coaches.map do |coach_name, game_loss|

        percentage_lost = (game_loss.to_f/game_id_list.length) * 100
        [coach_name, percentage_lost]
      end.to_h
      worst1_coach= coach_percentage_lost.min {|coach_average_1, coach_average_2| coach_average_1[1]<=>coach_average_2[1]}
      worst1_coach[0]
    end #there needs to be an end here or you're gonna have trouble

  def lowest_scoring_visitor
    away_team_scores = Hash.new { |h, k| h[k] = [] }
    @games.each { |game| away_team_scores[game.away_team_id] << game.away_goals.to_f }

    visitor_scores_average =
      away_team_scores.map do |id, scores|
        average = ((scores.sum) / (scores.length)).round(2)
        [id, average]
      end.min { |visitor_avg_1, visitor_avg_2| visitor_avg_1[1] <=> visitor_avg_2[1] }
    team_id_to_name[visitor_scores_average[0]]
  end

  def lowest_scoring_home_team
    home_team_scores = Hash.new { |h, k| h[k] = [] }
    @games.each { |game| home_team_scores[game.home_team_id] << game.home_goals.to_f }

    home_scores_average =
      home_team_scores.map do |id, scores|
        average = ((scores.sum) / (scores.length)).round(2)
        [id, average]
      end.min { |home_avg_1, home_avg_2| home_avg_1[1] <=> home_avg_2[1] }
    team_id_to_name[home_scores_average[0]]
  end

  def team_id_to_name
    @teams.map { |team| [team.team_id, team.team_name] }.to_h
  end

  def favorite_opponent(team_id)
    #{game=>{teams => [team1, team2], winning_team = team1}}
    game_hash = Hash.new { |h, k| h[k] = { is_our_team: false, other_team_id: nil, winning_team_id: nil } }

    @game_teams.each do |game|
      game_id = game.game_id
      winner = nil
      if game.result == "WIN"
        winner = game.team_id
      end
      if game.team_id == team_id
        game_hash[game_id][:is_our_team] = true
      else
        game_hash[game_id][:other_team_id] = game.team_id
      end
      if winner
        game_hash[game_id][:winning_team_id] = winner
      end
    end
    game_hash = game_hash
      .find_all { |game_id, teams_hash| teams_hash[:is_our_team] }
      .to_h

    team_scores = Hash.new { |h, k| h[k] = { wins: 0.0, losses: 0.0, ties: 0.0 } }
    game_hash.each do |game_id, teams_hash|
      other_team_id = teams_hash[:other_team_id]
      if teams_hash[:winning_team_id] == team_id
        team_scores[other_team_id][:losses] += 1
      elsif teams_hash[:winning_team_id] == other_team_id
        team_scores[other_team_id][:wins] += 1
      else
        team_scores[other_team_id][:ties] += 1
      end
    end

    min_win_percent =
      team_scores.min do |team_win_1, team_win_2|
        win_percentage_1 = (team_win_1[1][:wins] / (team_win_1[1][:losses] + team_win_1[1][:ties] + team_win_1[1][:wins])) * 100
        win_percentage_2 = (team_win_2[1][:wins] / (team_win_2[1][:losses] + team_win_2[1][:ties] + team_win_2[1][:wins])) * 100
        win_percentage_1 <=> win_percentage_2
      end
    min_win_team_id = min_win_percent[0]
    team_id_to_name[min_win_team_id]
  end

  def rival(team_id)
    game_hash = Hash.new { |h, k| h[k] = { is_our_team: false, other_team_id: nil, winning_team_id: nil } }

    @game_teams.each do |game|
      game_id = game.game_id
      winner = nil
      if game.result == "WIN"
        winner = game.team_id
      end
      if game.team_id == team_id
        game_hash[game_id][:is_our_team] = true
      else
        game_hash[game_id][:other_team_id] = game.team_id
      end
      if winner
        game_hash[game_id][:winning_team_id] = winner
      end
    end
    game_hash = game_hash
      .find_all { |game_id, teams_hash| teams_hash[:is_our_team] }
      .to_h

    team_scores = Hash.new { |h, k| h[k] = { wins: 0.0, losses: 0.0, ties: 0.0 } }
    game_hash.each do |game_id, teams_hash|
      other_team_id = teams_hash[:other_team_id]
      if teams_hash[:winning_team_id] == team_id
        team_scores[other_team_id][:losses] += 1
      elsif teams_hash[:winning_team_id] == other_team_id
        team_scores[other_team_id][:wins] += 1
      else
        team_scores[other_team_id][:ties] += 1
      end
    end

    max_win_percent =
      team_scores.max do |team_win_1, team_win_2|
        win_percentage_1 = (team_win_1[1][:wins] / (team_win_1[1][:losses] + team_win_1[1][:ties] + team_win_1[1][:wins])) * 100
        win_percentage_2 = (team_win_2[1][:wins] / (team_win_2[1][:losses] + team_win_2[1][:ties] + team_win_2[1][:wins])) * 100
        win_percentage_1 <=> win_percentage_2
      end
    max_win_team_id = max_win_percent[0]
    team_id_to_name[max_win_team_id]
  end


end
