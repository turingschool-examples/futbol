require 'spec_helper'

RSpec.configure do |config|
    config.formatter = :documentation
    end

RSpec.describe SeasonStats do
    before(:each) do
      game_path       = './data/games.csv'
      team_path       = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
  
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }

      tracker = StatTracker.from_csv(locations)
      @season_stats = tracker.season_stats
     
    end

    describe 'initialize' do
      it 'exists' do
        expect(@season_stats).to be_a(SeasonStats)
      end
    end

    describe 'winningest and worst coach' do
      it 'can determine name of the coach with the best win percentage for the season' do
        expect(@season_stats.winningest_coach("20122013")).to be_a(String)
        expect(@season_stats.winningest_coach("20122013")).to eq("Dan Lacroix")
        expect(@season_stats.winningest_coach("20162017")).to eq("Bruce Cassidy")
        expect(@season_stats.winningest_coach("20142015")).to eq("Alain Vigneault")
      end

      it 'cam determine name of the coach with the worst win percentage for the season' do
        expect(@season_stats.worst_coach("20122013")).to be_a(String)
        expect(@season_stats.worst_coach("20122013")).to eq("Martin Raymond")
        expect(@season_stats.worst_coach("20162017")).to eq("Dave Tippett")
        expect(@season_stats.worst_coach("20142015")).to eq("Ted Nolan")
      end
    end

    describe 'most accurate team' do
      it ' can name the team with the best ratio of shots to goals for the season' do
        expect(@season_stats.most_accurate_team("20122013")).to eq("DC United")
        expect(@season_stats.most_accurate_team("20162017")).to eq("Portland Thorns FC")
        expect(@season_stats.most_accurate_team("20142015")).to eq("Toronto FC")
      end
    end

    describe 'least accurate team' do
      it ' can name the team with the worst ratio of shots to goals for the season' do
        expect(@season_stats.least_accurate_team("20122013")).to eq("New York City FC")
        expect(@season_stats.least_accurate_team("20162017")).to eq("FC Cincinnati")
        expect(@season_stats.least_accurate_team("20142015")).to eq("Columbus Crew SC")
      end
    end
    
    describe 'team with highest tackles' do
      it 'can name the team with the most tackles' do
        expect(@season_stats.most_tackles("20122013")).to eq("FC Cincinnati")
        expect(@season_stats.most_tackles("20142015")).to eq("Seattle Sounders FC")
        expect(@season_stats.most_tackles("20162017")).to eq("Sporting Kansas City")
      end
    end

    describe 'team with least tackles' do
      it 'can name the team with the fewest tackles' do
        expect(@season_stats.fewest_tackles("20162017")).to eq("New England Revolution")
        expect(@season_stats.fewest_tackles("20142015")).to eq("Orlando City SC")
        expect(@season_stats.fewest_tackles("20122013")).to eq("Atlanta United")
      end
    end
end