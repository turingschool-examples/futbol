require './lib/stat_tracker'

describe StatTracker do
  let(:stat_tracker) {StatTracker.new({
                        :games => './data/games.csv', 
                        :teams => './data/teams.csv', 
                        :game_teams => './data/game_teams.csv'
                        })}
  
  describe '#initialize' do
    it 'exists' do
      expect(stat_tracker).to be_a(StatTracker)
    end

    it 'has attributes' do
      expect(stat_tracker.games).to be_a(CSV::Table)
      expect(stat_tracker.teams).to be_a(CSV::Table)
      expect(stat_tracker.game_teams).to be_a(CSV::Table)
    end
  end
# end


















































































































































































  describe '#count_of_teams' do
    it "counts all teams" do
      stat_tracker.count_of_teams
      expect(stat_tracker.count_of_teams).to eq 32
    end
  end

  describe '#best_offense' do
    it 'names a team with the highest avg of goals for the season' do
      expect(stat_tracker.best_offense).to eq "Reign FC"
    end

    # it 'names a team with the highest avg of goals for the season' do
    #   stat_tracker.season_goals(away, home)
    #   expect(stat_tracker.season_goals).to eq "Reign FC"
    # end
  end
end