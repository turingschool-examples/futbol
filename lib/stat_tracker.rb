require_relative './teams'
require_relative './game'
require_relative './game_teams'


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
      [game.home_goals.to_i,game.away_goals.to_i].sum
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
      [game.home_goals.to_i,game.away_goals.to_i].sum
    end
    high_low_added.min
  end

  def percentage_home_wins
    numerator = @games.find_all {|game| game.home_goals.to_i > game.away_goals.to_i }.size
    denominator = games.size
    (numerator.to_f/denominator).round(2)
  end

  def percentage_visitor_wins
    numerator = @games.find_all {|game| game.home_goals.to_i < game.away_goals.to_i }.size
    denominator = games.size
    (numerator.to_f/denominator).round(2)
  end

  def percentage_ties
    numerator = @games.find_all {|game| game.home_goals.to_i == game.away_goals.to_i }.size
    denominator = games.size
    (numerator.to_f/denominator).round(2)
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
        total_goals_per_game << [game.home_goals.to_i,game.away_goals.to_i].sum
    end
    ((total_goals_per_game.sum.to_f)/(@games.size)).round(2)
  end

  def best_offense
    team_id_to_name
    team_scores = Hash.new { |h, k| h[k] = [] }
    @game_teams.each do |game_team|
      team_scores[game_team.team_id] << game_team.goals.to_i
    end
  
    team_scores.map do |id, scores|
      length = scores.length
      team_scores[id] = scores.reduce(0) { |sum, num| sum + num } / length
      #this works but puts out an array, how do I get it back to the original hash form?
    end
      #team_scores =
      # {"3"=>[2, 2, 1, 2, 1],
      #   "6"=>[3, 3, 2, 3, 3, 3, 4, 2, 1],
      #   "5"=>[0, 1, 1, 0],
      #   "17"=>[1, 2, 3, 2, 1, 3, 1],
      #   "16"=>[2, 1, 1, 0, 2, 2, 2].....}
    
    #best_offense = {:team_id => [array of all their scores]}
    #it should be a hash with key of team name and value of an array of their scores!!!!
    #14882 arrays of team_id, goals inside an array
  end

end
