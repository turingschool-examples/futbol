require 'simplecov'
SimpleCov.start
SimpleCov.command_name 'Unit Tests'
require './lib/tg_stat'
require './lib/creator'
require './lib/stat_tracker'
require './lib/game'
require './lib/team'

RSpec.describe Creator do
  let!(:stat_tracker) do
    game_path = './spec/fixtures/spec_games.csv'
    team_path = './spec/fixtures/spec_teams.csv'
    game_teams_path = './spec/fixtures/spec_game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    StatTracker.from_csv(locations)
  end
  let!(:game_data){stat_tracker.game_data}
  let!(:team_data){stat_tracker.team_data}
  let!(:game_team_data){stat_tracker.game_team_data}
  let!(:creator) { Creator.create_objects(game_data, team_data, game_team_data) }

  describe '#initialize' do
    it "exists" do
      expect(creator).to be_a(Creator)
    end

    it "is an attribute" do
      expect(creator.teams_hash).to be_a(Hash)
      expect(creator.seasons_hash).to be_a(Hash)
      expect(creator.stats_hash).to be_a(Hash)
      expect(creator.games_hash).to be_a(Hash)
    end
  end

  describe '#create_objects' do
    it "creates Creator class instance with game object hashes" do
      expect(creator).to be_a(Creator)
    end
  end
  describe  '#stat_obj_creator' do
    it "creates a hash objects" do
      expect(Creator.stat_obj_creator(game_team_data)).to be_a(Hash)
    end

    it 'creates TGStat objects' do
      stats_hash = Creator.stat_obj_creator(game_team_data)

      expect(stats_hash['2012030221_3']).to be_a(TGStat)
    end
  end

  describe '#game_obj_creator' do
    it 'creates a hash' do
      stats_hash = Creator.stat_obj_creator(game_team_data)

      expect(Creator.game_obj_creator(game_data, stats_hash)).to be_a(Hash)
    end
    it 'creates game objects' do
      stats_hash = Creator.stat_obj_creator(game_team_data)
      games_hash = Creator.game_obj_creator(game_data, stats_hash)

      expect(games_hash['2012030236']).to be_a(Game)
    end
    it 'game object matches its stat objects' do
      stats_hash = Creator.stat_obj_creator(game_team_data)
      games_hash = Creator.game_obj_creator(game_data, stats_hash)

      expect(games_hash['2012030236'].game_id).to eq(stats_hash['2012030236_17'].game_id)
      expect(games_hash['2012030236'].game_id).to eq(stats_hash['2012030236_16'].game_id)
    end
    it 'game object matches home team and away team' do
      stats_hash = Creator.stat_obj_creator(game_team_data)
      games_hash = Creator.game_obj_creator(game_data, stats_hash)

      expect(games_hash['2012030236'].home_team_id).to eq(stats_hash['2012030236_17'].team_id)
      expect(games_hash['2012030236'].away_team_id).to eq(stats_hash['2012030236_16'].team_id)

      expect(games_hash['2012030236'].home_team_stat).to eq(stats_hash['2012030236_17'])
      expect(games_hash['2012030236'].away_team_stat).to eq(stats_hash['2012030236_16'])
    end
  end

  describe '#self.season_obj_creator' do
    it 'returns a hash' do
      stats_hash = Creator.stat_obj_creator(game_team_data)
      games_hash = Creator.game_obj_creator(game_data, stats_hash)

      expect(Creator.season_obj_creator(games_hash)).to be_a(Hash)
    end
    it 'creates a hash of game objects sorted by season' do
      stats_hash = Creator.stat_obj_creator(game_team_data)
      games_hash = Creator.game_obj_creator(game_data, stats_hash)
      seasons_hash = Creator.season_obj_creator(games_hash)

      expect(seasons_hash['20122013'][0]).to be_a(Game)
    end
  end

  describe '#self.team_obj_creator' do
    it 'creates a hash' do
      stats_hash = Creator.stat_obj_creator(game_team_data)
      games_hash = Creator.game_obj_creator(game_data, stats_hash)

      expect(Creator.team_obj_creator(team_data, games_hash)).to be_a(Hash)
    end
    it 'creates team objects' do
      stats_hash = Creator.stat_obj_creator(game_team_data)
      games_hash = Creator.game_obj_creator(game_data, stats_hash)
      teams_hash = Creator.team_obj_creator(team_data, games_hash)

      expect(teams_hash["17"]).to be_a(Team)
    end
    it 'team object matches its game_team object identifier' do
      stats_hash = Creator.stat_obj_creator(game_team_data)
      games_hash = Creator.game_obj_creator(game_data, stats_hash)
      teams_hash = Creator.team_obj_creator(team_data, games_hash)

      expect(teams_hash["6"].team_id).to eq(teams_hash["6"].game_objects[0].home_team_id)
      expect(teams_hash["3"].team_id).to eq(teams_hash["3"].game_objects[0].away_team_id)
    end
  end
end
