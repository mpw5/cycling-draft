require 'rails_helper'

RSpec.describe LeaguesController, type: :request do
  let(:user) { create :user }

  describe 'GET /leagues' do
    let!(:leagues) { create_list :league, 3 }
    before do
      login_as user
      get leagues_path
    end

    it 'renders successfully' do
      expect(response).to have_http_status(:ok)
    end

    it 'displays the page heading' do
      expect(response.body).to include('Leagues')
    end

    it 'the displays the name of every league' do
      response_body = CGI.unescapeHTML(response.body)
      expect(response_body).to include(leagues[0].name)
      expect(response_body).to include(leagues[1].name)
      expect(response_body).to include(leagues[2].name)
    end
  end

  describe 'GET /leagues/new' do
    before do
      login_as user
      get new_league_path
    end

    it 'renders successfully' do
      expect(response).to have_http_status(:ok)
    end

    it 'displays the page heading' do
      expect(response.body).to include('Create a new league')
    end
  end

  describe 'POST /league' do
    before { login_as user }
    subject { post leagues_path, params: { league: { name: 'name' } } }

    it 'creates a new league' do
      expect { subject }.to change { League.count }.by 1
    end

    it 'redirects to leagues page' do
      subject
      expect(response).to redirect_to(leagues_path)
    end

    context 'with errors' do
      before { allow_any_instance_of(League).to receive(:save).and_return(false) }
      it 'remains on the Create a League page' do
        subject
        expect(response.body).to include('Create a new league')
      end
    end
  end

  describe 'GET /league/:id' do
    let!(:league) { create :league }
    before do
      login_as user
      get league_path(league)
    end

    it 'renders successfully' do
      expect(response).to have_http_status(:ok)
    end

    it 'displays the league name' do
      response_body = CGI.unescapeHTML(response.body)
      expect(response_body).to include(league.name)
    end
  end

  describe 'DELETE /league/:id' do
    let!(:league) { create :league }
    before do
      login_as user
      delete league_path(league)
    end

    it 'deletes the league' do
      expect(League.count).to eq 0
    end

    it 'displays the league name' do
      expect(response).to redirect_to(leagues_path)
    end
  end

  describe 'PATCH /league/:id' do
    let!(:league) { create :league, aasm_state: :pre_draft }
    let!(:team) { create :team, league: league, draft_position: 1 }
    before do
      login_as user
      patch league_path(league)
    end

    it 'starts the draft' do
      expect(league.reload.aasm_state).to eq 'drafting'
    end

    it 'reloads the page without the start button' do
      response_body = CGI.unescapeHTML(response.body)
      expect(response_body).not_to include('Start')
    end
  end
end
