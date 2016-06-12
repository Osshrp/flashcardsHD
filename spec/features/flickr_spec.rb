require "rails_helper"
require "support/helpers/login_helper.rb"
include LoginHelper
require 'vcr'

feature "User connects Flickr photos to card" do
  let!(:user) { create :user_with_one_block_and_one_card }
  before do
    visit root_path
    login "test@test.com", "12345", "Войти"
  end
  scenario "they search photos in existing card" do
    visit edit_card_path user.cards.first
    click_link 'Загрузить фото с Flickr'
    fill_in "card_photo_search_string", with: "house"
    VCR.use_cassette 'flickr', match_requests_on: [:host]  do
      click_button "Искать фото"
    end
    expect(page).to have_xpath "//li/a/img"
  end

  before { visit new_card_path }
  
  scenario "they search photos in new card page" do
    click_link 'Загрузить фото с Flickr'
    fill_in "card_photo_search_string", with: "house"
    VCR.use_cassette 'flickr', match_requests_on: [:host] do
      click_button "Искать фото"
    end
    expect(page).to have_xpath "//li/a/img"
  end
end
