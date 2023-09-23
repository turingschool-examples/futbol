require './spec/spec_helper'


class Team
  attr_reader :seasons, :team_id, :game_objects
  attr_accessor :games, :tgames
  def initialize(stat_tracker, team_id)
    @stat_tracker = stat_tracker
    @team_id = team_id
    @tgames = []
    @games = []
    @game_objects = []
    @seasons = {}
    @stat_tracker.seasons.keys.each do |season|
      @seasons[season] = TeamSeason.new(season, @team_id)
    end
  end

  def seasons_builder
    @games.each do |game|
    #Figure out what season the game is in
      curr_season = @stat_tracker.games_by_season.keys.find do |season|
        @stat_tracker.games_by_season[season].include?(game[:game_id])
      end
      #Find corresponding games in other data set
      single_game = @tgames.find do |one_game|
        game[:game_id] == one_game[:game_id]
      end
      #Send the game row to the proper TeamSeason object
      team = @seasons[curr_season] 
      #Populate that object with game_team data       
      team_season_populator(team, single_game) 
    end
  end

  def team_season_populator(team, game)
      team.games += 1
      team.goals += game[:goals].to_i
      team.shots += game[:shots].to_i
      team.tackles += game[:tackles].to_i
      team.home_games += 1 if game[:hoa] == "home"
      team.away_games += 1 if game[:hoa] == "away"
      home_scores
      away_scores
  end


  def total_score_for_teams #all season methods
    total_score = 0
    game_teams.each do |game|
      if game[:team_id] == @team_id
        total_score += game[:goals].to_i
      end 
    end
    total_score
  end

  def game_object_maker
    hash = {}
    games.each do |one_game|
      hash[one_game] = (@tgames.find { |game_team| game_team[:game_id] == one_game[:game_id] })
    end
    hash.each do |game, half_game|
      game_object = Game.new(game, half_game)
      @game_objects << game_object
    end
  end
end