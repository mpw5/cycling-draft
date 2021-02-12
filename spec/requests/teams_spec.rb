require 'rails_helper'

RSpec.describe TeamsController, type: :request do
  describe 'GET /leagues/:id/teams/new' do
    let!(:league) { create :league }
    before do
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

    before { get league_team_path(league, team) }

    it 'renders successfully' do
      expect(response).to have_http_status(:ok)
    end

    it 'displays the team name' do
      response_body = CGI.unescapeHTML(response.body)
      expect(response_body).to include(team.name)
    end
  end

  describe 'DELETE /league/:id' do
    let!(:league) { create :league }
    let!(:team) { create :team, league: league }

    before { delete league_team_path(league, team) }

    it 'deletes the team' do
      expect(Team.count).to eq 0
    end

    it 'displays the league name' do
      expect(response).to redirect_to(league_path(league))
    end
  end
end
