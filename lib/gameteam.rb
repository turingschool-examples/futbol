class GameTeam
  attr_reader :game_id,
    :team_id,
    :hoa,
    :result,
    :settled_in,
    :head_coach

  def initialize(game_team_info)
    game_team_info.each do |key, value|
      instance_variable_set("@#{key}".downcase, value) unless value.nil?
    end
  end

  def goals
    @goals.to_i
  end

  def shots
    @shots.to_i
  end

  def tackles
    @tackles.to_i
  end

  def pim
    @pim.to_i
  end

  def power_play_opportunities
    @powerplayopportunities.to_i
  end

  def power_play_goals
    @powerplaygoals.to_i
  end

  def face_off_win_percentage
    @faceoffwinpercentage.to_f
  end

  def giveaways
    @giveaways.to_i
  end

  def takeaways
    @takeaways.to_i
  end

  def win?
    result == "WIN"
  end

  def loss?
    result == "LOSS"
  end

  def tie?
    result == "TIE"
  end
end
