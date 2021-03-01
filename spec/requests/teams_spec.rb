require 'rails_helper'

RSpec.describe TeamsController, type: :request do
  let(:user) { create :user }

  describe 'GET /leagues/:id/teams/new' do
    let!(:league) { create :league }
    before do
      login_as user
      get new_league_team_path(league)
    end

    it 'renders successfully' do
      expect(response).to have_http_status(:ok)
    end

    it 'displays the page heading' do
      expect(response.body).to include('Create a new team')
    end
  end

  describe 'POST /leagues/:id/team' do
    let!(:league) { create :league }
    before { login_as user }
    subject { post league_teams_path(league), params: { team: { name: 'name' } } }

    it 'creates a new team' do
      expect { subject }.to change { Team.count }.by(1)
    end

    it 'redirects to the league page' do
      subject
      expect(response).to redirect_to(league_path(league))
    end

    context 'with errors' do
      before { allow_any_instance_of(Team).to receive(:save).and_return(false) }
      it 'remains on the Create a Team page' do
        subject
        expect(response.body).to include('Create a new team')
      end
    end
  end

  describe 'GET /league/:id/team/:id' do
    let!(:league) { create :league }
    let!(:team) { create :team, league: league }
    before do
      login_as user
      get league_team_path(league, team)
    end

    it 'renders successfully' do
      expect(response).to have_http_status(:ok)
    end

    it 'displays the team name' do
      response_body = CGI.unescapeHTML(response.body)
      expect(response_body).to include(team.name)
    end
  end

  describe 'DELETE /league/:id/team/:id' do
    let!(:league) { create :league }
    let!(:team) { create :team, league: league }
    before do
      login_as user
      delete league_team_path(league, team)
    end

    it 'deletes the team' do
      expect(Team.count).to eq 0
    end

    it 'displays the league name' do
      expect(response).to redirect_to(league_path(league))
    end
  end

  describe 'PATCH /league/:id/team/:id' do
    let!(:league) { create :league, aasm_state: :drafting }
    let!(:team) { create :team, league: league }
    let!(:riders) { create_list :rider, 3 }
    let(:subject) { patch league_team_path(league, team), params: { rider_id: riders.first.id } }
    before { login_as user }

    it 'drafts the rider for the team' do
      expect { subject }.to change { RiderTeamLeague.count }.by 1
    end

    it 'allocates the rider to the team' do
      expect { subject }.to change { team.riders.count }.by 1
    end

    it 'prevents the rider being drafted again' do
      expect { subject }.to change { league.reload.available_riders.count }.by(-1)
    end
  end
end
