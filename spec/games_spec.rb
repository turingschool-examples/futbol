require './lib/games'
require 'pry'

RSpec.describe Games do
  describe 'initializes' do
    before do
      @games_info = {game_id: 2012030221, season: 20122013, type: "Postseason", date_time: "5/16/13", away_team_id: 3, home_team_id: 6, away_goals: 2, home_goals: 3, venue: "Toyota Stadium", venue_link: "/api/v1/venues/null"}
      @games = Games.new(@games_info)
    end

    it 'exists' do
      expect(@games).to be_a(Games)
    end

    it 'has a game_id' do
      expect(@games.game_id).to eq(2012030221)
    end

    it 'has a season' do
      expect(@games.season).to eq(20122013)
    end

    it 'has a type' do
      expect(@games.type).to eq("Postseason")
    end

    it 'has a date_time' do
      expect(@games.date_time).to eq("5/16/13")
    end

    it 'has a away_team_id' do
      expect(@games.away_team_id).to eq(3)
    end

    it 'has a home_team_id' do
    expect(@games.home_team_id).to eq(6)
    end

    it 'has a away_goals' do
      expect(@games.away_goals).to eq(2)
    end

    it 'has a home_goals' do
      expect(@games.home_goals).to eq(3)
    end

    it 'has a venue' do
      expect(@games.venue).to eq("Toyota Stadium")
    end

    it 'has a venue_link' do
      expect(@games.venue_link).to eq("/api/v1/venues/null")
    end
  end
end