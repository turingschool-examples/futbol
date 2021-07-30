require 'spec_helper'

RSpec.describe StatTracker do
  context 'initialize' do
    game_path = './data/mini_games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/mini_game_teams.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)

    it "exists" do
      expect(stat_tracker).to be_a(StatTracker)
    end

    it 'has best and worst seasons' do
      expect(stat_tracker.best_season("15")).to eq("20162017")
      expect(stat_tracker.worst_season("15")).to eq("20142015")
    end

    it 'has an average win percentage' do
      expect(stat_tracker.average_win_percentage("15")).to eq(0.63)
    end

    it "can get most and fewest number of goals" do
      expect(stat_tracker.most_goals_scored("3")).to eq(5)
      expect(stat_tracker.fewest_goals_scored("3")).to eq(0)
    end

    it "can give percentage of home wins, away wins, and ties" do
      expect(stat_tracker.percentage_home_wins).to eq(0.67)
      expect(stat_tracker.percentage_visitor_wins).to eq(0.31)
      expect(stat_tracker.percentage_ties).to eq(0.02)
    end

    it 'has a favourite opponent' do
      expect(stat_tracker.favorite_opponent("15")).to eq("North Carolina Courage")
    end

    it 'has a rival' do
      expect(stat_tracker.rival("15")).to eq("Seattle Sounders FC")
    end

    it 'has best offense' do
      expect(stat_tracker.best_offense).to eq("Sporting Kansas City")
    end

    it 'has worst offense' do
      expect(stat_tracker.worst_offense).to eq("Houston Dash")
    end

  end
