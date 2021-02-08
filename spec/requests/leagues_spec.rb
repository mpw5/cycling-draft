require 'rails_helper'

RSpec.describe LeaguesController, type: :request do
  describe 'GET leagues' do
    let!(:leagues) { create_list :league, 3 }
    before { get leagues_path }

    it 'renders successfully' do
      expect(response).to have_http_status(:ok)
    end

    it 'displays page heading' do
      expect(response.body).to include('Leagues')
    end

    it 'the displays the name of every league' do
      response_body = CGI.unescapeHTML(response.body)
      expect(response_body).to include(leagues[0].name)
      expect(response_body).to include(leagues[1].name)
      expect(response_body).to include(leagues[2].name)
    end
  end
end
