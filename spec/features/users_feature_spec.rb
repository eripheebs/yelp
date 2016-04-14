require 'rails_helper'

feature 'User can sign in and out' do
  context 'User not signed in and on homepage' do
    it 'should see a sign-in and a sign-up link' do
      visit('/')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    it 'should not see a sign-out link' do
      visit '/'
      expect(page).not_to have_link('Sign out')
    end
  end

  context 'User signed in and on homepage' do
    before do
      sign_up_one
    end

    it 'should see a sign-out link' do
      visit '/'
      expect(page).to have_link('Sign out')
    end

    it 'should not see a sign-in and a sign-up link' do
      visit '/'
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end
  end
end
