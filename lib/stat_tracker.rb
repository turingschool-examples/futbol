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

  def team_season_grouper(team_id)  #groups all of a team's games by season in a hash: the key is the season and the values are the team's games for that season
    all_games = all_team_games(team_id)
    all_games.group_by do |game|
      game.season
    end
  end

  def team_season_game_counter(team_id)  #incomplete helper
    games_by_season_hash = team_season_grouper(team_id)
  end

  def best_season(team_id)  #this is not done and the one below needs to be refactored or tossed out and become a helper. this groups a team's seasons into arrays
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


end
