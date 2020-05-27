require "csv"

class GameTeamCollection
  def initialize(gt_csv)
    @gt_csv = gt_csv
  end

  def all
    rows = CSV.read(@gt_csv, headers: true, header_converters: :symbol)
    rows.reduce([]) do |game_teams, row|
      game_teams << GameTeam.new(row)
      game_teams
    end
  end

end
