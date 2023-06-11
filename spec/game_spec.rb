require 'spec_helper'

describe Game do
  describe '#initialize' do
    it 'exists' do
      info = {
        game_id: '1',
        season: '374',
        type: 'postseason',
        date_time: '5/16/13',
        away_team_id: '5',
        home_team_id: '6',
        away_goals: '2',
        home_goals: '3',
        venue: 'Toyota Stadium',
        venue_link: '/api/v1/venues/null'
      }

      game = Game.new(info)

      expect(game).to be_a Game
    end

    it 'has attributes' do
      info = {
        game_id: '1',
        season: '374',
        type: 'postseason',
        date_time: '5/16/13',
        away_team_id: '5',
        home_team_id: '6',
        away_goals: '2',
        home_goals: '3',
        venue: 'Toyota Stadium',
        venue_link: '/api/v1/venues/null'
      }

      game = Game.new(info)

      expect(game.game_id).to eq('1')
      expect(game.season_id).to eq('374')
      expect(game.season_type).to eq('postseason')
      expect(game.game_date).to eq('5/16/13')
      expect(game.away_team_id).to eq(5)
      expect(game.home_team_id).to eq(6)
      expect(game.away_goals).to eq(2)
      expect(game.home_goals).to eq(3)
      expect(game.venue_name).to eq('Toyota Stadium')
      expect(game.venue_link).to eq('/api/v1/venues/null')
    end

    it 'can have different attributes' do
      info = {
        game_id: '2',
        season: '375',
        type: 'regular season',
        date_time: '5/16/14',
        away_team_id: '7',
        home_team_id: '8',
        away_goals: '4',
        home_goals: '5',
        venue: 'Toyota Stadium',
        venue_link: '/api/v1/venues/null'
      }

      game = Game.new(info)

      expect(game.game_id).to eq('2')
      expect(game.season_id).to eq('375')
      expect(game.season_type).to eq('regular season')
      expect(game.game_date).to eq('5/16/14')
      expect(game.away_team_id).to eq(7)
      expect(game.home_team_id).to eq(8)
      expect(game.away_goals).to eq(4)
      expect(game.home_goals).to eq(5)
      expect(game.venue_name).to eq('Toyota Stadium')
      expect(game.venue_link).to eq('/api/v1/venues/null')
    end
  end
end
