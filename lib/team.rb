class Team

  attr_reader :id,
              :franchise_id,
              :name,
              :abbreviation,
              :stadium,
              :link,
              :games

  def initialize(team_hash)
    @id = team_hash[:team_id]
    @franchise_id = team_hash[:franchiseId]
    @name = team_hash[:teamName]
    @abbreviation = team_hash[:abbreviation]
    @stadium = team_hash[:Stadium]
    @link = team_hash[:link]
    @games = team_hash[:games]
  end

  def total_goals
    @games.values.sum { |game| game.total_goals }
  end

end
