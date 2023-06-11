require 'spec_helper'

describe GameTeam do
  describe '#initialize' do
    it 'exists' do
      info = {
        game_id: '1',
        team_id: '5',
        hoa: 'away',
        result: 'WIN',
        settled_in: 'OT',
        head_coach: 'John Tortorella',
        goals: '2',
        shots: '8',
        tackles: '44',
        pim: '8',
        powerPlayOpportunities: '3',
        powerPlayGoals: '0',
        faceOffWinPercentage: '8',
        giveaways: '17',
        takeaways: '7'
      }

      game_team = GameTeam.new(info)

      expect(game_team).to be_a GameTeam
    end

    it 'has attributes' do
      info = {
        game_id: '1',
        team_id: '5',
        HoA: 'away',
        result: 'WIN',
        settled_in: 'OT',
        head_coach: 'John Tortorella',
        goals: '2',
        shots: '8',
        tackles: '44',
        pim: '8',
        powerPlayOpportunities: '3',
        powerPlayGoals: '0',
        faceOffWinPercentage: '8',
        giveaways: '17',
        takeaways: '7'
      }

      game_team = GameTeam.new(info)
      expect(game_team.game_id).to eq('1')
      expect(game_team.team_id).to eq('5')
      expect(game_team.home_or_away).to eq('away')
      expect(game_team.game_result).to eq('WIN')
      expect(game_team.reg_or_ot).to eq('OT')
      expect(game_team.coach).to eq('John Tortorella')
      expect(game_team.goals).to eq('2')
      expect(game_team.shots).to eq('8')
      expect(game_team.tackles).to eq('44')
      expect(game_team.pim).to eq('8')
      expect(game_team.power_play_opp).to eq('3')
      expect(game_team.power_play_goals).to eq('0')
      expect(game_team.face_off_win_percentage).to eq('8')
      expect(game_team.giveaways).to eq('17')
      expect(game_team.takeaways).to eq('7')
    end

    it 'can have different attributes' do
      info = {
        game_id: '1234',
        team_id: '9',
        HoA: 'home',
        result: 'LOSS',
        settled_in: 'REG',
        head_coach: 'Jane Smith',
        goals: '4',
        shots: '10',
        tackles: '40',
        pim: '10',
        powerPlayOpportunities: '4',
        powerPlayGoals: '1',
        faceOffWinPercentage: '10',
        giveaways: '20',
        takeaways: '10'
      }

      game_team = GameTeam.new(info)

      expect(game_team.game_id).to eq('1234')
      expect(game_team.team_id).to eq('9')
      expect(game_team.home_or_away).to eq('home')
      expect(game_team.game_result).to eq('LOSS')
      expect(game_team.reg_or_ot).to eq('REG')
      expect(game_team.coach).to eq('Jane Smith')
      expect(game_team.goals).to eq('4')
      expect(game_team.shots).to eq('10')
      expect(game_team.tackles).to eq('40')
      expect(game_team.pim).to eq('10')
      expect(game_team.power_play_opp).to eq('4')
      expect(game_team.power_play_goals).to eq('1')
      expect(game_team.face_off_win_percentage).to eq('10')
      expect(game_team.giveaways).to eq('20')
      expect(game_team.takeaways).to eq('10')
    end
  end
end
