require 'rails_helper'

describe Review, type: :model do
  it { is_expected.to belong_to :restaurant }
  it { is_expected.to belong_to :user}

  it 'cannot be rated above 5' do
    review = Review.create(thoughts: 'super good', rating: 10)
    expect(review).to have(1).error_on(:rating)
  end
end
