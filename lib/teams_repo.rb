class TeamsRepo
  attr_reader :parent
  def initialize(locations, parent)
    @parent = parent 
  end
end
