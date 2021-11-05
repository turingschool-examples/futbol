require './lib/stat_tracker'
require './lib/game'
require './lib/team'
require './lib/game_team'
require './runner'

describe StatTracker do
  before(:each) do

    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_test.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end


    it 'exists' do
      expect(@stat_tracker).to be_instance_of(StatTracker)
    end

# Game Statistics Tests


# League Statistics Tests


# Season Statistics Tests


# Team Statistics Tests
  describe '#team_info' do
    it 'returns team_id, franchise_id, team_name, abbr., and link' do
      expected = {
        :team_id => 27,
        :franchise_id => 28,
        :team_name => "San Jose Earthquakes",
        :abbreviation => "SJ",
        :link => "/api/v1/teams/27"
      }
      expect(@stat_tracker.team_info(27)).to eq(expected)
    end
  end

  describe '#best_season' do
    it 'returns the season with the highest win percentage for a team' do
      expect(@stat_tracker.best_season(3)).to eq("20142015")
    end
  end

  describe '#worst_season' do
    it 'returns the season with the lowest win percentage for a team' do
      expect(@stat_tracker.worst_season(3)).to eq("20152016")
    end
  end

  describe '#average_win_percentage' do
    it 'returns the average win percentage of all games for a team' do
      expect(@stat_tracker.average_win_percentage(3)).to eq(36.11)
    end
  end

  describe '#most_goals_scored' do
    xit 'returns the highest nuber of goals a particular team has scored in a single game' do

    end
  end

  describe '#fewest_goals_scored' do
    it 'returns the lowest numer of goals a particular team has scored in a single game' do

    end
  end

  describe '#favorite_opponent' do
    xit 'returns the name of the opponent that has the lowest win percentage against the given team' do

    end
  end

  describe '#rival' do
    xit 'returns the name of the opponent that has the highest win percentage against the given team' do

    end
  end
end
