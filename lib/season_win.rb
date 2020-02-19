require_relative 'team_collection'

class SeasonWin

  def initialize
  end

  def team_info(team_id)
    team_collection = TeamCollection.new('./data/teams.csv')
    team_collection.teams_list.reduce(Hash.new) do |acc, team|
      if team_id == team.team_id.to_s
        acc = {"team_id" => team.team_id.to_s,
               "franchise_id" => team.franchise_id.to_s,
               "team_name" => team.team_name,
               "abbreviation" => team.abbreviation,
               "link" => team.link}
      end
      acc
    end
  end
end