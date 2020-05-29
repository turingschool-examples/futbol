require 'csv'

class Team
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :link

  def initialize(team_params)
    @team_id = team_params[:team_id].to_i
    @franchise_id = team_params[:franchiseid].to_i
    @team_name = team_params[:teamname]
    @abbreviation = team_params[:abbreviation]
    @link = team_params[:link]
  end

  def self.all(teams_path)
    rows = CSV.read(teams_path, headers: true, header_converters: :symbol)
    rows.reduce([]) do |teams, row|
      teams << Team.new(row)
      teams
    end
  end

  def info
    {
      team_id: @team_id,
      franchise_id: @franchise_id,
      team_name: @team_name,
      abbreviation: @abbreviation,
      link: @link
    }
  end
end
