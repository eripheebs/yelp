require 'rails_helper'

feature 'Reviewing' do

  before do
    sign_up_one
    add_kfc
  end

  scenario 'does not allow users to leave a review unless signed in' do
    click_link 'Sign out'
    click_link 'Review KFC'
    expect(page).not_to have_field 'Thoughts'
  end

  scenario 'allows users to leave a review using a form' do
    leave_review
    expect(current_path).to eq restaurants_path
    expect(page).to have_content 'average'
  end
end
