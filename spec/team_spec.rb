require 'spec_helper' 

RSpec.describe Team do
    before(:all) do
        game_path = './data/games.csv'
        team_path = './data/teams.csv'
        game_teams_path = './data/game_teams.csv'
    
        locations = {
          games: game_path,
          teams: team_path,
          game_teams: game_teams_path
        }
        @teams_data = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
        @game_teams_data = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
        @season = Season.new(@teams_data,@game_teams_data)
      end
    describe 'team statistics' do
        it 'can make a hash with key/value pairs for the following attributes' do
        expected = {
            'team_id' => '18',
            'franchise_id' => '34',
            'team_name' => 'Minnesota United FC',
            'abbreviation' => 'MIN',
            'link' => '/api/v1/teams/18'
        }
        expect(@stat_tracker.team_info('18')).to eq(expected)
        end
    end
    
    describe '#average_win_percentage' do
        it 'can tell the average win rate of a given team' do
        expect(@stat_tracker.average_win_percentage("6")).to eq 0.49
        end
    end
    
    describe '#most_goals_scored' do
        it "can show what game a team scored the most goals" do
        expect(@stat_tracker.most_goals_scored("18")).to eq 7
        end
    end
    
    describe '#fewest_goals_scored' do
        it "#fewest_goals_scored" do
        expect(@stat_tracker.fewest_goals_scored("18")).to eq 0
        end
    end
    
    describe '#favorite_opponent' do
        it "#favorite_opponent" do
        expect(@stat_tracker.favorite_opponent("18")).to eq "DC United"
        end
    end
    
    describe '#rival' do
        it "#rival" do
        expect(@stat_tracker.rival("18")).to eq("Houston Dash").or(eq("LA Galaxy"))
        end
    end


    describe 'Team statistics-best & worse season methods'do
        it "#best_season" do
        expect(@stat_tracker.best_season("6")).to eq "20132014"
        end

        it "#worst_season" do
        expect(@stat_tracker.worst_season("6")).to eq "20142015"
        end
    end
    end