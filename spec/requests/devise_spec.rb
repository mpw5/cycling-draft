require 'rails_helper'

RSpec.describe 'devise', type: :request do
  describe 'POST /leagues/:id/team' do
    subject { post user_registration_path, params: { user: { username: 'name', email: 'email@example.com', password: 'password' } } }

    it 'creates a new user' do
      expect { subject }.to change { User.count }.by(1)
    end
  end
end
