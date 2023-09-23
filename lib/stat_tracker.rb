# require_relative './spec_helper'
 require_relative './game'
 require_relative './game_team'
 require_relative './teams'
#  require 'pry-nav'


class StatTracker
  attr_reader :locations, :team_data, :game_data, :game_teams_data
  
  def initialize(locations)
    @game_data = create_games(locations[:games])
    # require 'pry'; binding.pry
    # @teams = create_teams(locations[:teams])
    @game_teams_data = create_game_teams(locations[:game_teams])
    # require 'pry'; binding.pry
    @team_data = create_teams(locations[:teams])
    # require 'pry'; binding.pry
    # @locations = locations 
    # @game_data = CSV.read locations[:games], headers: true, header_converters: :symbol
    #@teams_data = CSV.read locations[:teams], headers: true, header_converters: :symbol
    #@game_team_data = CSV.read locations[:game_teams], headers: true, header_converters: :symbol
  end
  
  def create_games(path)
    Game.reset
    # require 'pry'; binding.pry
    data = CSV.parse(File.read(path), headers: true, header_converters: :symbol)
    # data.map { |row| Game.new(row) }
    data.map do |row|
    Game.new(row)
    end
  end
  
  def create_game_teams(path)
    data = CSV.parse(File.read(path), headers: true, header_converters: :symbol)
    data.map do |row| 
      GameTeam.new(row)
    end
  end

  def create_teams(path)
    data = CSV.parse(File.read(path), headers: true, header_converters: :symbol)
    data.map do |row|
      Team.new(row)
    end
  end
  
  def self.from_csv(locations)
    StatTracker.new(locations)
  end
  
  def percentage_calculator(portion, whole)
    percentage = (portion/whole).round(2)
  end
  
  def count_of_games_by_season 
    # require 'pry'; binding.pry
    games_seasons = Hash.new(0)
    
    @game_data.each do |row|
      season = row.season
      games_seasons[season] += 1
    end 
    games_seasons
  end
  
  def percentage_ties 
    ties = @game_data.count do |game|
      # require 'pry'; binding.pry
      game.away_goals.to_f == game.home_goals.to_f
    end.to_f
    (ties/@game_data.count).round(2)
  end

  def average_goals_by_season
    season_hash =@game_data.group_by{|game| game.season }
    av_goals = {}
    
    season_hash.each do |season,games|
      total_goals = games.map {|game| game.home_goals.to_i + game.away_goals.to_i}
      av_goals[season] = (total_goals.sum.to_f / games.length).round(2)
    end
    av_goals
  end
  
  def percentage_visitor_wins
    away_wins = GameTeam.gameteam.count do |game|
      game.HoA == "away" && game.result == "WIN"
    end 
    (away_wins.to_f / Game.games.count.to_f).round(2)
  end

  def average_goals_per_game
    total_goals = 0
    total_games = []
    @game_teams_data.each do |row|
      total_goals += row.goals.to_i
      total_games << row.game_id
    end
    average = total_goals.to_f / total_games.uniq.count
    average.round(2)
  end

  def highest_total_score

    all_max = @game_data.max_by do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end
    goals_sorted = @game_data.sort do |gm1, gm2|
      gm1.away_goals.to_i + gm1.home_goals.to_i <=> gm2.away_goals.to_i + gm2.home_goals.to_i
    end

    postseason_games = goals_sorted.find_all do |game|
      game.type == "Postseason"
    end

    post_max = postseason_games.max_by do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end
    [all_max, post_max]
  end

  def lowest_total_score

    # helper method to remove any games that do not have lowest home + away score
    def get_lowest_scores(sorted_goals)
      lowest_score = sorted_goals.first.home_goals.to_i + sorted_goals.first.away_goals.to_i
      sorted_goals.find_all do |game|
        game.away_goals.to_i + game.home_goals.to_i == lowest_score
      end
    end

    # ascending sort of every game by sum of home and away goals
    sorted_goals = @game_data.sort do |gm1, gm2|
      gm1.away_goals.to_i + gm1.home_goals.to_i <=> gm2.away_goals.to_i + gm2.home_goals.to_i
    end

    # remove regular season games from ascending sorted_goals
    playoff_goals_sorted = sorted_goals.find_all do |game|
      game.type == "Postseason"
    end

    # lowest score among all games - regular and postseason
    lowest_scoring_games = get_lowest_scores(sorted_goals)

    # lowest score among postseason games
    lowest_scoring_postseason = get_lowest_scores(playoff_goals_sorted)

    # returned array with lowest scoring games among all games -> position 0; lowest scoring playoff game -> position 1 
    [lowest_scoring_games, lowest_scoring_postseason]

  end
    
  # def highest_scoring_visitor
  #   team_information = {}
  #   season_goals = 0
  #   @game_teams_data.find_all do |row|
  #     season_goals += row[:goals].to_i
  #     team_information[row[:team_id]] = season_goals + 
  #     # require 'pry'; binding.pry
  #   # require 'pry'; binding.pry
  #   # row[:goals]
  #   # row[:team_id]
  #   # row[:game_id]
  #   # row[:hoa]

  def team_goals(home_or_away)
    teams = @game_teams_data.group_by { |row| row.team_id}
    team_home_goals = Hash.new
    team_away_goals = Hash.new
    teams.each do |team, data_array|
      away_goals = 0
      home_goals = 0
      data_array.each do |data|
        if data.hoa == "home"
          home_goals += data.goals.to_i
        elsif data.hoa == "away"
          away_goals += data.goals.to_i
        end
      end
      team_away_goals[team] = away_goals
      team_home_goals[team] = home_goals
    end
    if home_or_away == "away"
      team_away_goals
    else 
      team_home_goals
    end
    # require 'pry'; binding.pry
  end
  
  def games_by_team(home_or_away)
    teams = @game_teams_data.group_by { |row| row.team_id }
    games = Hash.new
    teams.each do |team, data_array|
      game_location = data_array.select { |data| data.hoa == home_or_away }
      games[team] = game_location.count
    end
    games
  end

  # def highest_scoring_visitor
  #   team_goals("away")
  #   require 'pry'; binding.pry

  end
end


# combine both of these into one for the games_by_team
# def home_games_by_team
#   teams = @game_teams_data.group_by { |row| row.team_id}
#   games_at_home = Hash.new(0)
#   teams.each do |team, data_array|
#     home_games = []
#     data_array.each do |data|
#       if data.hoa == "home"
#       home_games << data.game_id
#       end
#     end
#     games_at_home[team] = home_games.count
#   end
#   games_at_home
# end

# def away_games_by_team
#   teams = @game_teams_data.group_by { |row| row.team_id}
#   games_not_at_home = Hash.new(0)
#   teams.each do |team, data_array|
#     away_games = []
#     data_array.each do |data|
#       if data.hoa == "away"
#       away_games << data.game_id
#       end
#     end
#     games_not_at_home[team] = away_games.count
#   end
#   games_not_at_home
# end


