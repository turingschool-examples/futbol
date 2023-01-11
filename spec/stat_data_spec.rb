require './lib/stat_data'

describe StatData do
  let (:stat_data) {StatData.new({
    :games => './data/games_spec.csv',
    :teams => './data/teams.csv',
    :game_teams => './data/game_teams_spec.csv'
    })}

  describe '#initialize' do
    it 'exists' do
      expect(stat_data).to be_a(StatData)
    end

    it 'has attributes' do
      expect(stat_data.games).to be_a(CSV::Table)
      expect(stat_data.teams).to be_a(CSV::Table)
      expect(stat_data.game_teams).to be_a(CSV::Table)
    end
  end
end