class Games
  def initialize(path)
    @csv = CSV.read path
  end
end
