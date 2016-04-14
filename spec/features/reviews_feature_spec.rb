require 'rails_helper'

feature 'reviewing' do

  before do
    sign_up
    create_kfc
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
      expect(Review.all).to be_empty
    end

    scenario 'user can delete review they wrote' do
      visit '/restaurants'
      click_link 'Review KFC'
      fill_in 'Thoughts', with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'
      click_link 'Delete Review'
      expect(Review.all).to be_empty
      expect(page).to have_content 'Review deleted successfully'
    end

    scenario 'other users cant delete review' do
      visit '/restaurants'
      click_link 'Review KFC'
      fill_in 'Thoughts', with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'
      click_link 'Sign out'
      sign_up_2
      visit '/restaurants'
      expect(page).not_to have_content 'Delete Review'
    end
  end

  context 'display averge rating only' do
    scenario 'it should only display the average rating' do
      leave_review("So SO", '3')
      click_link 'Sign out'
      sign_up_2
      leave_review("tada", '5')
      expect(page).to have_content('Average rating: 4')
    end
  end

end
