require './spec/spec_helper'

class SingleSeasonData < AllSeasonData

  def initialize(stat_tracker, name)
    super(stat_tracker)
    @name = name
  end

end