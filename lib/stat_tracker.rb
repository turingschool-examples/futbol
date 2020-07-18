class StatTracker
  attr_reader :games, :teams, :game_team

  def initialize(data)
    @games = data[:games]
    @teams = data[:teams]
    @game_team = data[:game_team]
  end

  def self.from_csv(data)
    #add code here
    StatTracker.new(data)
  end

# game stats

#league stats

#team stats

#season stats


end
