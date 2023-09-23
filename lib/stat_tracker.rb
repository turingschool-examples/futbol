# require_relative './spec_helper'
  require_relative './game'
  require_relative './game_team'
  require_relative './teams'
#  require 'pry-nav'


class StatTracker
  attr_reader :locations, :team_data, :game_data, :game_teams_data

  def initialize(locations)
    @game_data = create_games(locations[:games])
    @game_teams_data = create_game_teams(locations[:game_teams])
    @team_data = create_teams(locations[:teams])
  end

  # CREATOR METHODS

  def create_games(path)
    Game.reset
    Game.reset
    data = CSV.parse(File.read(path), headers: true, header_converters: :symbol)
    data.map do |row|
      Game.new(row)
    end
  end

  def create_game_teams(path)
    GameTeam.reset
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


  # GAME STATISTICS

  def highest_total_score
    most_goals_game = @game_data.reduce(0) do |goals, game|
      game_goals = game.home_goals.to_i + game.away_goals.to_i
      if game_goals > goals
        goals = game_goals
      end
      goals
    end
    most_goals_game
  end

  def lowest_total_score
    fewest_goals_game = @game_data.reduce(0) do |goals, game|
      game_goals = game.home_goals.to_i + game.away_goals.to_i
      if game_goals < goals
        goals = game_goals
      end
      goals
    end
    fewest_goals_game
  end

  def percentage_home_wins
    home_wins = GameTeam.gameteam.count do |game|
      game.hoa == "home" && game.result == "WIN"
    end 
    (home_wins.to_f / Game.games.count.to_f).round(2)
  end

  def percentage_visitor_wins
    away_wins = GameTeam.gameteam.count do |game|
      game.hoa == "away" && game.result == "WIN"
    end 
    (away_wins.to_f / Game.games.count.to_f).round(2)
  end

  def percentage_ties 
    ties = @game_data.count do |game|
      # require 'pry'; binding.pry
      game.away_goals.to_f == game.home_goals.to_f
    end.to_f
    (ties/@game_data.count).round(2)
  end

  def count_of_games_by_season 
    games_seasons = Hash.new(0)
    @game_data.each do |row|
      season = row.season
      games_seasons[season] += 1
    end 
    games_seasons
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

  def average_goals_by_season
    season_hash =@game_data.group_by{|game| game.season }
    av_goals = {}
  
    season_hash.each do |season,games|
      total_goals = games.map {|game| game.home_goals.to_i + game.away_goals.to_i}
      av_goals[season] = (total_goals.sum.to_f / games.length).round(2)
    end
    av_goals
  end


  # LEAGUE STATISTICS

  def count_of_teams
    @team_data.count
  end

  def best_offense
   total_team_goals_hash = {}
    team_goals("home").each do |team_id, home_goals|
      total_team_goals_hash[team_id] = [
        home_goals + team_goals("away")[team_id],
        @game_teams_data.find_all do |game|
          game.team_id == team_id
        end.count
    ]
    end 
    team_name_avg_goals = []
    total_team_goals_hash.each do |team, gls_gms_arr|
      team_name_avg_goals << [get_team_info(team)['team_name'], ((gls_gms_arr.first.to_f/gls_gms_arr.last.to_f)*100/100).round(3)]
    end
    team_name_avg_goals.max_by do |team_arr|
      team_arr.last
    end.first
  end

  def worst_offense
    total_team_goals_hash = {}
    team_goals("home").each do |team_id, home_goals|
      total_team_goals_hash[team_id] = [
        home_goals + team_goals("away")[team_id],
        @game_teams_data.find_all do |game|
          game.team_id == team_id
        end.count
    ]
    end 
    team_name_avg_goals = []
    total_team_goals_hash.each do |team, gls_gms_arr|
      team_name_avg_goals << [get_team_info(team)['team_name'], ((gls_gms_arr.first.to_f/gls_gms_arr.last.to_f)*100/100).round(3)]
    end
    team_name_avg_goals.min_by do |team_arr|
      team_arr.last
    end.first
  end

  def highest_scoring_visitor
    team = average_goals_per_team("away")
    most_avg = average_goals_per_team("away").values.max
    team_id = team.reduce("") do |team_id, el|
      if el.last == most_avg
        team_id = el.first
      end
      team_id
    end
    team_name = get_team_info(team_id)["team_name"]
  end

  def highest_scoring_home_team
    team = average_goals_per_team("home")
    highest_avg = average_goals_per_team("home").values.max
    team_id = team.reduce("") do |team_id, el|
      if el.last == highest_avg
        team_id = el.first
      end
      team_id
    end
    team_name = get_team_info(team_id)["team_name"]
  end

  def lowest_scoring_visitor
    team = average_goals_per_team("away")
    lowest_avg = average_goals_per_team("away").values.min
    team_id = team.reduce("") do |team_id, el|
      if el.last == lowest_avg
        team_id = el.first
      end
      team_id
    end
    team_name = get_team_info(team_id)["team_name"]
  end

  def lowest_scoring_home_team
    team = average_goals_per_team("home")
    most_avg = average_goals_per_team("home").values.min
    team_id = team.reduce("") do |team_id, el|
      if el.last == most_avg
        team_id = el.first
      end
      team_id
    end
    team_name = get_team_info(team_id)["team_name"]
  end


  # SEASON STATISTICS

  def winningest_coach

  end

  def worst_coach

  end

  def most_accurate_team

  end

  def least_accurate_team

  end

  def most_tackles(season)
    #returns array of all games for specific season
    games_by_season = @game_data.find_all do |game|
      game if game.season == season
    end
    #returns array of all game_teams for specific season, game_teams track tackles
    game_teams_by_season = []
    games_by_season.each do |game|
      @game_teams_data.each do |game_team|
        game_teams_by_season.push(game_team) if game.game_id == game_team.game_id
      end
    end
    #creats empty acumulator hash, sort teams by id as key, add all tackles for each team as value
    tackles_by_team = Hash.new(0)
    game_teams_by_season.each do |game_team|
      tackles_by_team[game_team.team_id] += game_team.tackles.to_i
    end
    #find team id with most tackles 
    team_id_most_tackles = tackles_by_team.max_by {|team_id, tackles| tackles}.first
    #find team object by id found above
    team_with_most_tackles = @team_data.find do |team|
      team_id_most_tackles == team.franchise_id
    end
    #call on team name attribute of team object
    team_with_most_tackles.team_name
  end  
  

  def fewest_tackles(season)
    #returns array of all games for specific season
    games_by_season = @game_data.find_all do |game|
      return game if game.season == season
    end
    #returns array of all game_teams for specific season, game_teams track tackles
    game_teams_by_season = []
    games_by_season.each do |game|
      @game_teams_data.each do |game_team|
        return game_teams_by_season.push(game_team) if game.game_id == game_team.game_id
      end
    end
    #creats empty acumulator hash, sort teams by id as key, add all tackles for each team as value
    tackles_by_team = Hash.new(0)
    game_teams_by_season.each do |game_team|
      tackles_by_team[game_team.team_id] = game_team.tackles.to_i
    end
    #find team id with most tackles
    team_id_fewest_tackles = tackles_by_team.min_by {|team_id, tackles| tackles}.first
    #find team object by id found above
    team_with_fewest_tackles = @team_data.find do |team|
      team_id_fewest_tackles == team.franchise_id
    end
    #call on team name attribute of team object
    team_with_fewest_tackles.team_name
  end


  # HELPER METHODS

  def team_goals(home_or_away)
    teams = @game_teams_data.group_by { |row| row.team_id}
    # require 'pry'; binding.pry
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
  end
  
  def games_by_team(team_side)
    teams = @game_teams_data.group_by { |row| row.team_id }
    games = Hash.new
    teams.each do |team, data_array|
      game_location = data_array.select { |data| data.hoa == team_side}
      games[team] = game_location.count
    end
    games
  end

  def average_goals_per_team(team_side)
    team_goals(team_side)
    games_by_team(team_side)
    average_goals = Hash.new
    team_goals(team_side).each do |key, value|
      if games_by_team(team_side)[key]
        average_goals[key] = ((value/ games_by_team(team_side)[key].to_f)*100/100).round(3)
      end
    end
    average_goals
  end

  #TODO duplicate method names => seasons_sorted 

  def seasons_sorted
    season_sorted = Game.games.group_by {|game| game.season}
    game_ids = []
    season_game_ids = Hash.new
    season_sorted.each do |season|
      season.last.each do |data|
        game_ids << data.game_id
      end
      season_game_ids[season.first] = game_ids
    end
    season_game_ids
  end

  def percentage_calculator(portion, whole)
    percentage = (portion/whole).round(2)
  end

  def get_team_info(team_id)
    team = @team_data.find do |team|
      team.team_id == team_id
    end
    {
      "team_id" => team.team_id,
      "franchise_id" => team.franchise_id,
      "team_name" => team.team_name,
      "abbreviation" => team.abbreviation,
      "link" => team.link
    }
  end

  def seasons_sorted
    season_sorted = Game.games.group_by {|game| game.season}
  end

end

