require 'rails_helper'

feature 'Reviewing' do

  before { Restaurant.create(name: 'KFC') }

  scenario 'allows users to leave a review using a form' do
    visit restaurants_path
    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'average'
    select '3', from: 'Rating'
    click_button 'Leave a review'

    expect(current_path).to eq restaurants_path
    expect(page).to have_content 'average'
  end
end
