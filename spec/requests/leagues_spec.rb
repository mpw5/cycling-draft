require 'rails_helper'

RSpec.describe LeaguesController, type: :request do
  describe 'GET /leagues' do
    let!(:leagues) { create_list :league, 3 }
    before { get leagues_path }

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
    before { get new_league_path }

    it 'renders successfully' do
      expect(response).to have_http_status(:ok)
    end

    it 'displays the page heading' do
      expect(response.body).to include('Create a new league')
    end
  end

  describe 'POST /league' do
    subject { post leagues_path, params: { league: { name: 'name' } } }

    it 'creates a new league' do
      expect { subject }.to change { League.count }.by(1)
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

    before { get league_path(league) }

    it 'renders successfully' do
      expect(response).to have_http_status(:ok)
    end

    it 'displays the league name' do
      response_body = CGI.unescapeHTML(response.body)
      expect(response_body).to include(league.name)
    end
  end
end
