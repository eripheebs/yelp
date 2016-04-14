require 'rails_helper'

feature 'Restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant'do
      visit restaurants_path
      expect(page).to have_content 'No restaurant yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'KFC')
    end

    scenario 'display restaurants' do
      visit restaurants_path
      expect(page).to have_content 'KFC'
      expect(page).not_to have_content 'No restaurant yet'
    end
  end

  context 'creating restaurants' do
    scenario 'prompts a user to fill out a form, then displays the new restaurant' do
      sign_up_one
      add_kfc
      expect(page).to have_content 'KFC'
      expect(current_path).to eq restaurants_path
    end

    scenario 'users must be signed in to create a restaurant' do
      visit restaurants_path
      click_link 'Add a restaurant'
      expect(page).not_to have_field 'Name'
    end

    context 'an invalid restaurant' do
      scenario 'does not allow a user to submit a name that is too short' do
        sign_up_one
        add_invalid_restaurant
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end
    end
  end

  context 'viewing restaurants' do
    let!(:kfc){ Restaurant.create(name: 'KFC') }

    scenario 'lets a user view a restaurant' do
      visit restaurants_path
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq restaurant_path(kfc)
    end
  end

  context 'editing restautarants' do

    before do
      sign_up_one
      add_kfc
    end

    scenario 'lets a user to edit a restaurant' do
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      click_button 'Update'
      expect(page).to have_content('Kentucky Fried Chicken')
      expect(current_path).to eq restaurants_path
    end

    scenario 'does not allow a user to edit restaurants others have created' do
      click_link 'Sign out'
      sign_up_two
      click_link 'Edit KFC'
      expect(current_path).to eq restaurants_path
      expect(page).to have_content 'You cannot edit this restaurant'
    end
  end

  context 'deleting restaurants' do

    before do
      sign_up_one
      add_kfc
    end

    scenario 'removes a restaurant when a user clicks a delete link' do
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end

    scenario 'does not allow a user to edit restaurants others have created' do
      click_link 'Sign out'
      sign_up_two
      click_link 'Delete KFC'
      expect(current_path).to eq restaurants_path
      expect(page).to have_content 'You cannot delete this restaurant'
    end
  end

  context 'deleting restaurants that have associated reviews' do
    before do
      kfc = Restaurant.create(name: 'KFC')
      kfc.reviews.create(thoughts: 'okay-ish', rating: 2)
    end

    scenario 'removes a restaurant and reviews when a delete link is clicked' do
      visit restaurants_path
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).not_to have_content 'okay-ish'
    end
  end
end
