require 'rails_helper'
require 'spec_helper'

describe Restaurant, type: :model do
  it { is_expected.to have_many :reviews }

  it 'is not valid with a name less that three characters' do
    resto = Restaurant.create(name: 'kf')
    expect(resto).to have(1).error_on(:name)
    expect(resto).not_to be_valid
  end
end
