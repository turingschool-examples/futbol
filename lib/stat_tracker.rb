require 'csv'
require_relative 'game'
require_relative 'team'

class StatTracker 
  #include modules

  def self.from_csv(locations)
    new(locations)
  end

  attr_reader :game_data, :team_data, :game_teams_data

  def initialize(locations)
    @game_data = CSV.read locations[:games], headers: true, header_converters: :symbol
    @team_data = CSV.read locations[:teams], headers: true, header_converters: :symbol
    @game_teams_data = CSV.read locations[:game_teams], headers: true, header_converters: :symbol
  end

  def all_games
    @game_data.map do |row|
      Game.new(row)
    end
  end

  def all_teams
    @team_data.map do |row|
      team = Team.new(row)
      team.games = all_games.select { |game| game.home_id == team.team_id || game.away_id == team.team_id }
      team
    end
  end

  def all_game_teams
    @game_teams_data.map do |row|
      GameTeam.new(row)
    end
  end

  def games_by_season
    seasons = Hash.new([])
    all_games.each do |game|
      seasons[game.season] = []
    end
    seasons.each do |season, games_array|
      all_games.each do |game|
        games_array << game if game.season == season
      end
    end
    seasons
  end
  
  #=====================================================================================================

  def highest_total_score
    all_games.map do |game|
      game.total_score
    end.max
  end

  def lowest_total_score
    all_games.map do |game|
      game.total_score
    end.min
  end

  def count_of_games_by_season
    game_count = {}
    data = games_by_season.map do |season, games|
      game_count[season] = games.count
    end
    game_count
  end

  def best_offense
    goals_by_game = Hash.new({})

    #name of the team with the highest 
    #average number of goals scored per game across all seasons (string)
    #All the games
    all_games.each do |game|
      total = game.home_goals + game.away_goals
      home_id = game.home_id.to_s
      away_id = game.away_id.to_s
      if total == 0 
        goals_by_game[game.id] = { away_id => 0, home_id => 0 }
      else
        goals_by_game[game.id] = {
          away_id => (game.away_goals/total.to_f * 100).round(2),
          home_id => (game.home_goals/total.to_f * 100).round(2) 
        }
        #create helper method for this hash that contains keys => game_id
        #points to another hash that keys => team_id and values => avg goals/game
        # 2014030225=>{"15"=>33.33, "3"=>66.67},
         #2014020427=>{"2"=>42.86, "19"=>57.14},
         #Create helper method for total?
      end
    end  
   goals_by_game
   goals_by_game.each do |game_id, hash|
    require 'pry'; binding.pry
    #create a new hash and set to 0  iterate through and add up 
    #avgs and divide by total times played and return team_id
    #likely need to search teamscsv to retrieve name
   end
  end
end
  def average_goals_by_season
    games_by_season.transform_values do |games_array|
      scores_array = games_array.map(&:total_score)
      (scores_array.sum.to_f / scores_array.length).round(2)
    end
  end
  
  def count_of_teams
    @team_data.count
  end

  def percentage_home_wins
    team_wins = all_game_teams.select do |team|
      team.result == "WIN" && team.home_or_away == "home"
    end
    home_games = all_game_teams.select do |game|
      game.home_or_away == "home"
    end
    (team_wins.count / home_games.count.to_f).round(2)
  end
end
