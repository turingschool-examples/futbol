class Team

  attr_reader :id,
              :franchise_id,
              :name,
              :abbreviation,
              :stadium,
              :link

  def initialize(info)
    @id           = info[:team_id]
    @franchise_id = info[:franchiseid]
    @name         = info[:teamname]
    @abbreviation = info[:abbreviation]
    @stadium      = info[:stadium]
    @link         = info[:link]
  end
end

#   all_teams = TeamCollection.new(@teams)
#   found_team = all_teams.all.find do |team|
#     team.id.to_i == id
#   end
#     {
#       :team_id => found_team.id,
#       :franchise_id => found_team.franchise_id,
#       :teamname => found_team.name,
#       :abbreviation => found_team.abbreviation,
#       :stadium => found_team.stadium,
#       :link => found_team.link
#     }
# end
