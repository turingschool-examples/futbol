require './lib/stat_tracker'


RSpec.describe StatTracker do
  before :each do
    @game_path = './data/dummy_games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/dummy_game_teams.csv'

    @locations = {
        games: @game_path,
        teams: @team_path,
        game_teams: @game_teams_path
      }
    @stat_tracker = StatTracker.from_csv(@locations)

  end

    it 'exists and has attributes' do
        expect(@stat_tracker).to be_an_instance_of(StatTracker)
    end

    it 'can call #from_csv on self' do
        expect(@stat_tracker.games.count).to eq(20)
        expect(@stat_tracker.teams.count).to eq(32)
        expect(@stat_tracker.game_teams.count).to eq(40)
    end

    # xit 'can load collections' do
    #
    #   expect(stat_tracker.load_collections(locations)).to eq({
    #     games => CSV.read(locations[:games], headers:true,
    #        header_converters: :symbol),
    #     teams =>,
    #     game_teams =>
    #     })
    #   collections is the key with the data as the value so that
    # end
    describe 'League Statistics' do
      it '#count_of_teams can count teams' do
      expect(@stat_tracker.count_of_teams).to eq(32)
      end

      it '#best_offense finds team with the best offense' do
        expect(@stat_tracker.best_offense).to eq(["Atlanta United",
           "Orlando City SC", "Portland Timbers", "San Jose Earthquakes"])
      end

      it '#team_name_helper finds team name via team_id' do
        expect(@stat_tracker.team_name_helper("3")).to eq("Houston Dynamo")
      end



    end


end
