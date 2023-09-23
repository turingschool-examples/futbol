require './spec/spec_helper'

class AllSeasonData
  attr_reader :stat_tracker, :games_by_season, :home_team_games, :home_team_games_scores
  def initialize(stat_tracker)
    @stat_tracker = stat_tracker
  end

  def team_data_parser(file_location)
    @team_data ||= CSV.foreach( file_location, headers: true, header_converters: :symbol).map do |info| 
      info
    # @team_data ||= begin
    #   contents = CSV.open file_location, headers: true, header_converters: :symbol
    #   contents.readlines
    end
  end

  def game_teams_data_parser(file_location)
    @game_teams_data ||= CSV.foreach( file_location, headers: true, header_converters: :symbol).map do |info| 
      info
      # contents = CSV.open file_location, headers: true, header_converters: :symbol
      # contents.readlines
    end
  end

  def game_data_parser(file_location)
    @game ||= CSV.foreach( file_location, headers: true, header_converters: :symbol).map do |info| 
      info
      # contents = CSV.open file_location, headers: true, header_converters: :symbol
      # contents.readlines
    end
  end


  def games_by_season
    @games_by_season ||= begin
      games_by_season_hash = Hash.new([])
      @stat_tracker.game.each do |one_game|
        games_by_season_hash[one_game[:season]] += [one_game[:game_id]]
      end
      @games_by_season = games_by_season_hash
    end
  end


  # def number_of_visitor_games(team)
  #   @number_away_games ||= begin
  #       number_of_games = 0
  #     game_teams.each do |game|
  #       if game[:team_id] == team && game[:hoa] == "away"
  #         number_of_games += 1
  #       end 
  #     end
  #     number_of_games
  #   end
  # end

  def team_score_game_average
    teams_average = {}
    @stat_tracker.teams.each do |team|
      teams_average[team.team_id] = ((team.seasons.sum { |season| season.last.goals })/(team.seasons.sum { |season| season.last.games}).to_f).round(2)
    end
    teams_average
  end

  def single_seasons_creator
    @seasons ||= begin
      seasons_hash = Hash.new
      games_by_season.keys.each do |season|
        seasons_hash[season] = SingleSeasonData.new(@stat_tracker, season)
      end
     @seasons = seasons_hash
    end
  end

  def home_team_games #all season methods; combine with away team games; hash
    @home_team_games ||= begin
      home_team_games_array = []
      @game_teams_data.each { |game| home_team_games_array << game if game[:hoa] == "home"}
      @home_team_games = home_team_games_array 
    end
  end

  def home_team_games_count(team) #all season methods
    number_of_games = 0
      home_team_games.each do |game|
        number_of_games += 1 if game[:team_id] == team
      end
    number_of_games
  end

  def home_game_total_score(team) 
    total_score = 0
    home_team_games.each { |game| total_score += game[:goals].to_i if game[:team_id] == team }
    total_score
  end

  def home_team_games_scores #all season methods, combine with visitor games and scores
    @home_team_games_scores ||= begin
    games_and_scores = {}
    home_team_games.each { |team| games_and_scores[team[:team_id]] = { average: (home_game_total_score(team[:team_id])/home_team_games_count(team[:team_id]).to_f) }}
    @home_team_games_scores = games_and_scores
    end
  end
end