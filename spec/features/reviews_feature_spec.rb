require 'rails_helper'

feature 'reviewing' do
  let!(:kfc) { Restaurant.create name: 'KFC' }

  before do
    visit '/'
    click_link 'Sign up'
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
  end

  context 'writing a review' do
    scenario 'allows users to leave a review using a form' do
      visit '/restaurants'
      click_link 'Review KFC'
      fill_in 'Thoughts', with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'

      expect(current_path).to eq '/restaurants'
      expect(page).to have_content('so so')
    end
  end

  context 'review destruction' do
    scenario 'deleting a restaurant deletes its reviews' do
      visit '/restaurants'
      click_link 'Review KFC'
      fill_in 'Thoughts', with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'
      click_link 'Delete KFC'
      expect(kfc.reviews.empty?).to eq true
    end

  end

end
