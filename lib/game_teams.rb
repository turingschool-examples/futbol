class GameTeam
  attr_reader :game_id,
              :team_id,
              :hoa,
              :result,
              :head_coach,
              :goals,
              :shots,
              :tackles

  def initialize(data)
    @game_id = data[:game_id].to_i
    @team_id = data[:team_id]
    @hoa = data[:hoa]
    @result = data[:result]
    @head_coach = data[:head_coach]
    @goals = data[:goals].to_i
    @shots = data[:shots].to_i
    @tackles = data[:tackles].to_i
  end

  def home?
    hoa == 'home'
  end

  def away?
    hoa == 'away'
  end

  def match?(id)
    team_id == id
  end

  def check(home_or_away = nil)
    if home_or_away == 'home'
      home?
    elsif home_or_away == 'away'
      away?
    else
      self
    end
  end
end
