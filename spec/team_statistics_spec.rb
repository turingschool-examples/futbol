require 'spec_helper'

RSpec.describe TeamStatistics do
    context 'when a team statistics tracker is created' do
      mock_games_data = './data/mock_games.csv'
      team_data = './data/teams.csv'
      mock_game_teams_data = './data/mock_game_teams.csv'

      let!(:mock_locations) {{games: mock_games_data, teams: team_data, game_teams: mock_game_teams_data}}

      let!(:stat_tracker) { StatTracker.from_csv(mock_locations) }

      let!(:team_statistics) { TeamStatistics.new }

      it 'is an instance of team stats tracker' do
        expect(team_statistics).to be_a(TeamStatistics)
      end

      it 'can return info on teams' do
        expect(team_statistics.team_info(28)).to eq({:abbreviation=>"LFC", :franchiseid=>"29", :link=>"/api/v1/teams/28", :stadium=>"Banc of California Stadium", :team_id=>"28", :teamname=>"Los Angeles FC"})
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

      it 'can '

    end

end


