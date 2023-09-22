require './spec/spec_helper'

class AllSeasonData
  attr_reader :stat_tracker, :games_by_season
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

  def single_seasons_creator
    @seasons ||= begin
      seasons_hash = Hash.new
      games_by_season.keys.each do |season|
        seasons_hash[season] = SingleSeasonData.new(@stat_tracker)
      end
     @seasons = seasons_hash
    end
  end
end