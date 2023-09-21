class Team
  @@teams = []
  attr_reader :game_id,
              :franchiseId,
              :teamName,
              :abbreviation,
              :Stadium,
              :link

  def initialize(attributes)
    @game_id = attributes[:game_id]
    @franchiseId = attributes[:franchiseId]
    @teamName = attributes[:teamName]
    @abbreviation = attributes[:abbreviation]
    @Stadium = attributes[:Stadium]
    @link = attributes[:link]
    @@teams << self
  end

def self.teams
  @@teams
end