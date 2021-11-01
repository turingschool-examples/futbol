class StatTracker

  def initialize(games)

    @game_id = :games["game_id"]
  end

  def self.from_csv(data)
    rows = CSV.read(files, headers: true)
  end

end
