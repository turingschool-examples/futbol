class GameTeamsRepo
  attr_reader :parent
  def initialize(location, parent)
    @parent = parent
  end
end
