require 'csv'
require 'pry'

class StatTracker
  def initialize(data)
    @games      = data[:games]
    @teams      = data[:teams]
    @game_teams = data[:game_teams]
  end

  def self.from_csv(locations)
    # This method will create an
    # instance of StatTracker, and
    # return that instance.
    ted_lasso = StatTracker(data)
    return ted_lasso
  end
end
