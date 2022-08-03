require 'spec_helper'
require 'csv'

RSpec.describe TeamStatistics do
  team_data = CSV.read './data/teams.csv', headers:true, header_converters: :symbol
  game_teams_data = CSV.read './data/game_teams.csv', headers: true, header_converters: :symbol
  games_data = CSV.read './data/games.csv', headers: true, header_converters: :symbol

      let!(:team_statistics) { TeamStatistics.new(team_data, games_data, game_teams_data) }

      it 'is an instance of team stats tracker' do
        expect(team_statistics).to be_a(TeamStatistics)
      end

      it 'can return info on teams' do
        expect(team_statistics.team_info(28)).to eq({"abbreviation" => "LFC", "franchise_id" => "29", "link" => "/api/v1/teams/28", "stadium" => "Banc of California Stadium", "team_id" => "28", "teamname" => "Los Angeles FC"})
      end

      it 'can return the fewest goals scored in a game by a given team' do
        expect(team_statistics.fewest_goals_scored(17)).to eq(0)
      end

      it 'can return the most goals scored in a game by a given team' do
        expect(team_statistics.most_goals_scored(17)).to eq(6)
      end

      it 'can return the best season for a given team' do
        expect(team_statistics.best_season(9)).to eq '20162017'
      end
      it 'can return the worst season for a given team' do
        expect(team_statistics.worst_season(9)).to eq '20172018'
      end

      it 'knows the average win percentage of a given team' do
        expect(team_statistics.average_win_percentage(17)).to eq 37.83
      end

      it 'can return the rival team of a given team' do
        expect(team_statistics.rival(28)).to eq 'Sporting Kansas City'
      end

      it 'can return the favorite opponent of a team' do
        expect(team_statistics.favorite_opponent(28)).to eq 'Montreal Impact'
      end
end


