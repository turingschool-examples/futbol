class Game
  attr_reader :game_id,
              :season,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals

  def initialize(hash)
    @game_id      = hash[:game_id]
    @season       = hash[:season]
    @away_team_id = hash[:away_team_id]
    @home_team_id = hash[:home_team_id]
    @away_goals   = hash[:away_goals]
    @home_goals   = hash[:home_goals]
  end

  def played?(team_id)
    @away_team_id == team_id || @home_team_id == team_id
  end

  def home?(team_id)
    team_id == @home_team_id
  end

  def away?(team_id)
    team_id == @away_team_id
  end

  def won?(team_id)
    if home?(team_id)
      return true if @home_goals.to_i > @away_goals.to_i
      return false if @away_goals.to_i > @home_goals.to_i
    elsif away?(team_id)
      return false if @home_goals.to_i > @away_goals.to_i
      return true if @away_goals.to_i > @home_goals.to_i
    else false
    end
  end
end
