require './spec/spec_helper'

RSpec.describe GameStatistics do
    before(:each) do
        @fake_game_data = [
      {
      game_id: '2012030221', team_id: 3, HoA: 'away', result: 'LOSS', settled_in: 'OT', head_coach: 'John Tortorella', goals: 2, shots: 8, tackles: 44, pim: 8, powerPlayOpportunities: 3, powerPlayGoals: 0, faceOffWinPercentage: 44.8, giveaways: 17, takeaways: 7,
      game_id: '2012030221', team_id: 6, HoA: 'home', result: 'WIN', settled_in: 'OT', head_coach: 'Claude Julien', goals: 3, shots: 12, tackles: 51, pim: 6, powerPlayOpportunities: 4, powerPlayGoals: 1, faceOffWinPercentage: 55.2, giveaways: 4, takeaways: 5,
      game_id: '2012030222', team_id: 3, HoA: 'away', result: 'LOSS', settled_in: 'REG', head_coach: 'John Tortorella', goals: 2, shots: 9, tackles: 33, pim: 11, powerPlayOpportunities: 5, powerPlayGoals: 0, faceOffWinPercentage: 51.7, giveaways: 1, takeaways: 4,
      game_id: '2012030222', team_id: 6, HoA: 'home', result: 'WIN', settled_in: 'REG', head_coach: 'Claude Julien', goals: 3, shots: 8, tackles: 36, pim: 19, powerPlayOpportunities: 1, powerPlayGoals: 0, faceOffWinPercentage: 48.3, giveaways: 16, takeaways: 6,
      game_id: '2012030223', team_id: 6, HoA: 'away', result: 'WIN', settled_in: 'REG', head_coach: 'Claude Julien', goals: 2, shots: 8, tackles: 28, pim: 6, powerPlayOpportunities: 0, powerPlayGoals: 0, faceOffWinPercentage: 61.8, giveaways: 10, takeaways: 7,
      game_id: '2012030223', team_id: 3, HoA: 'home', result: 'LOSS', settled_in: 'REG', head_coach: 'John Tortorella', goals: 1, shots: 6, tackles: 37, pim: 2, powerPlayOpportunities: 2, powerPlayGoals: 0, faceOffWinPercentage: 38.2, giveaways: 7, takeaways: 9,
      game_id: '2012030224', team_id: 6, HoA: 'away', result: 'WIN', settled_in: 'OT', head_coach: 'Claude Julien', goals: 3, shots: 10, tackles: 24, pim: 8, powerPlayOpportunities: 4, powerPlayGoals: 2, faceOffWinPercentage: 53.7, giveaways: 8, takeaways: 6,
      game_id: '2012030224', team_id: 3, HoA: 'home', result: 'LOSS', settled_in: 'OT', head_coach: 'John Tortorella', goals: 2, shots: 8, tackles: 40, pim: 8 powerPlayOpportunities: 4, powerPlayGoals: 1, faceOffWinPercentage: 46.3, giveaways: 9, takeaways: 7
      }
    ]

    @fake_season_data = [
        {
          game_id: '2012030325', season: 20122013, type: 'Postseason', date_time: 6/9/13, away_team_id: 26, home_team_id: 16, away_goals: 3, home_goals: 2, venue: 'Gillette Stadium', venue_link: '/api/v1/venues/null',
          game_id: '2016030172', season: 20162017, type: 'Postseason', date_time: 4/16/17, away_team_id: 20, home_team_id: 24, away_goals: 2, home_goals: 3, venue: 'Rio Tinto Stadium', venue_link: '/api/v1/venues/null',
          game_id: '2016030173', season: 20162017, type: 'Postseason', date_time: 4/18/17, away_team_id: 24, home_team_id: 20, away_goals: 3, home_goals: 2, venue: 'BMO Field', venue_link: '/api/v1/venues/null',
          game_id: '2016030174', season: 20162017, type: 'Postseason', date_time: 4/20/17, away_team_id: 24, home_team_id: 20, away_goals: 3, home_goals: 1, venue: 'BMO Field', venue_link: '/api/v1/venues/null',
          game_id: '2014030411', season: 20142015, type: 'Postseason', date_time: 6/4/15, away_team_id: 16, home_team_id: 14, away_goals: 2, home_goals: 1, venue: 'Audi Field', venue_link: '/api/v1/venues/null',
          game_id: '2014030412', season: 20142015, type: 'Postseason', date_time: 6/6/15, away_team_id: 16, home_team_id: 14, away_goals: 3, home_goals: 2, venue: 'Audi Field', venue_link: '/api/v1/venues/null',
          game_id: '2016030171', season: 20162017, type: 'Postseason', date_time: 4/14/17, away_team_id: 20, home_team_id: 24, away_goals: 2, home_goals: 3, venue: 'Rio Tinto Stadium', venue_link: '/api/v1/venue/null',
          game_id: '2014030413', season: 20142015, type: 'Postseason', date_time: 6/9/15, away_team_id: 14, home_team_id: 16, away_goals: 3, home_goals: 2, venue: 'Gillette Stadium', venue_link: '/api/v1/venues/null'
        }
      ]

    @game_stats = SeasonStatistics.new(@fake_game_data, @fake_team_data, @fake_season_data)
    end

    describe '#total score stats' do
        it 'knows the highest total score' do
        allow(@game_stats).to receive(:highest_total_score).and_return(11)
        expect(@game_stats.highest_total_score).to eq(11)
        end

        it 'knows the lowest total score' do
        allow(@game_stats).to receive(:lowest_total_score).and_return(7)
        expect(@game_stats.lowest_total_score).to eq(7)
        end
    end

    describe '#win, loss, and tie percentages' do
        it 'knows the percentage of home wins' do
        allow(@game_stats).to receive(:percentage_home_wins).and_return(.50)
        expect(@game_stats.percentage_home_wins).to eq(.50)
        end

        it 'knows the percentage of visitor wins' do
        allow(@game_stats).to receive(:percentage_visitor_wins).and_return(.50)
        expect(@game_stats.percentage_visitor_wins).to eq(.50)
        end

        it 'knows the percentage of ties' do
            allow(@game_stats).to receive(:percentage_ties).and_return(0.0)
            expect(@game_stats.percentage_ties).to eq(0.0)
        end
    end

    describe '#knows the number of games in a season' do
        it 'counts the games in a season' do
        allow(@game_stats).to receive(:count_of_games_by_season).and_return({season: 20122013, games: 1}, {season: 20162017, games: 4}, {season: 20142015, games: 3})
        expect(@game_stats.count_of_games_by_season).to eq({season: 20122013, games: 1}, {season: 20162017, games: 4}, {season: 20142015, games: 3})
        end
    end

    describe '#calculates average goals ' do
        it 'can average the goals scored per game by both teams in every season combined' do
        allow(@game_stats).to receive(:average_goals_per_game).and_return(4.62)
        expect(@game_stats.average_goals_per_game).to eq(4.62)
        end

        it 'can average the goals scored per game by both teams in a single season' do
            allow(@game_stats).to receive(:average_goals_by_season).and_return({season: 20122013, goals: 5}, {season: 20162017, goals: 4.75}, {season: 20142015, goals: 4.33})
            expect(@game_stats.average_goals_by_season).to eq({season: 20122013, goals: 5}, {season: 20162017, goals: 4.75}, {season: 20142015, goals: 4.33})
        end
    end
end