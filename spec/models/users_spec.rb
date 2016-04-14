require 'rails_helper'

describe User do
  it { is_expected.to have_many :restaurants }
  it { is_expected.to have_many :reviews}
  it { is_expected.to have_many :reviewed_restaurants }

  let!(:user) do
    User.create(email: 'test@test.com',
                password: '123456789',
                password_confirmation: '123456789')
  end

  let(:restaurant) { double(:restaurant, user_id: 20 )}

  describe '#has_created?' do
    it 'should return true if the user created a restaurant' do
      expect(user.has_created?(restaurant)).to eq true
    end
  end
end
