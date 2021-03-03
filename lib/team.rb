class Team
  attr_reader :team_id,
              :franchiseid,
              :teamname,
              :abbreviation,
              :stadium,
              :link,
              :count

  def initialize(data)
    @team_id = data[:team_id]
    @franchiseid = data[:franchiseid]
    @teamname = data[:teamname]
    @abbreviation = data[:abbreviation]
    @stadium = data[:stadium]
    @link = data[:link]
    # @count = 0
  end

  # def count_of_teams
  #   @count += 1
  # end
end
