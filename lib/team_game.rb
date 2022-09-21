class TeamGame < Game
  attr_accessor :opponent,
                :goals,
                :result

  def initialize(season)
    # require "pry"; binding.pry
    @opponent = nil
    @goals = nil
    @result = nil
    super(season)
    # require "pry"; binding.pry
  end


end
