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
    high_low_added = @games.map do |game|
      [game.home_goals.to_i, game.away_goals.to_i].sum
    end
    high_low_added.max
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

  def lowest_total_score
    high_low_added = @games.map do |game|
      [game.home_goals.to_i, game.away_goals.to_i].sum
    end
    high_low_added.min
  end

  def percentage_home_wins
    numerator = @games.find_all { |game| game.home_goals.to_i > game.away_goals.to_i }.size
    denominator = games.size
    (numerator.to_f / denominator).round(2)
  end

  def percentage_visitor_wins
    numerator = @games.find_all { |game| game.home_goals.to_i < game.away_goals.to_i }.size
    denominator = games.size
    (numerator.to_f / denominator).round(2)
  end

  def percentage_ties
    numerator = @games.find_all { |game| game.home_goals.to_i == game.away_goals.to_i }.size
    denominator = games.size
    (numerator.to_f / denominator).round(2)
  end

  def count_of_games_by_season
    hash = Hash.new(0)
    @games.each do |game|
      hash[game.season] += 1
    end
    hash
  end

  def average_goals_per_game
    total_goals_per_game = []
    @games.map do |game|
      total_goals_per_game << [game.home_goals.to_i, game.away_goals.to_i].sum
    end
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
          hash[season] = total/(twelve_season.count).to_f.round(2)
        elsif  season == "20162017"
            hash[season] = total/(sixteen_season.count).to_f.round(2)
        elsif  season == "20142015"
            hash[season] = total/(fourteen_season.count).to_f.round(2)
        elsif  season == "20152016"
            hash[season] = total/(fifteen_season.count).to_f.round(2)
        elsif  season == "20132014"
            hash[season] = total/(thirteen_season.count).to_f.round(2)
        elsif  season == "20172018"
            hash[season] = total/(seventeen_season.count).to_f.round(2)
        end
      end
      hash
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
end
