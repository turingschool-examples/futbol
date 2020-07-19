class Team

  attr_reader :team_id,
              :franchiseid,
              :teamname,
              :abbreviation,
              :link
  def initialize(args)
    @team_id      = args[:team_id]
    @franchiseid  = args[:franchiseid]
    @teamname     = args[:teamname]
    @abbreviation = args[:abbreviation]
    @link         = args[:link]
  end





end
