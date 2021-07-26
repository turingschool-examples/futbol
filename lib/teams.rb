class Team
  attr_reader :data

  def initialize(stats)
    @data = {
      :team_id => stats[0].to_i,
      :franchise_id => stats[1].to_i,
      :team_name => stats[2],
      :abbreviation => stats[3],
      :stadium => stats[4],
      :link => stats[5]
    }
  end
end
