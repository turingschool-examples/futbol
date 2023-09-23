class Team

  def initialize(stat_tracker, team_id)
    @stat_tracker = stat_tracker
    @team_id = team_id
    @seasons = {}
  end

  def team_object_builder
    @stat_tracker.game_teams.each do |game|
      if game[:team_id] == @team_id
        season_builder(game[:season_id], game)
      end 
    end
  end

  def season_builder(season_id, game)
    @seasons[:season_id] = {
      goals: 
      shots:
      tackles:
      game_count: 
      require 'pry'; binding.pry
    }
    
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

end