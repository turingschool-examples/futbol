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

  def initialize2
    game_object_maker
    seasons_builder
  end

  def seasons_builder
    @game_objects.each do |game|
      curr_season = game.season
      #Send the game row to the proper TeamSeason object
      team = @seasons[curr_season] 
      #Populate that object with game_team data       
      team_season_populator(team, game) 
      #Also send that object to it's appropriate season
      @stat_tracker.seasons[curr_season].game_objects << game
    end
  end

  def team_season_populator(team, game)
    team.games += 1
    team.goals += game.goals
    team.shots += game.shots
    team.tackles += game.tackles

    team.home_games += 1 if game.hoa == "home"
    team.home_goals += game.goals if game.hoa == "home"
    team.away_games += 1 if game.hoa == "away"
    team.away_goals += game.goals if game.hoa == "away"
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