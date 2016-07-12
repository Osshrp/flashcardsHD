require "rails_helper"
require "support/helpers/login_helper.rb"
include LoginHelper
# require "vcr"

feature "User loads words from remote url" do
  let!(:user) { create :user_with_one_block_and_one_card }
  before do
    visit root_path
    login "test@test.com", "12345", "Войти"
  end

  scenario "they whant to load card" do
    visit remote_cards_path
    fill_in "remote_url", with: "http://wordsteps.com/vocabulary/words/26708"
    fill_in "row_selector", with: ".wrow"
    fill_in "original_selector", with: ".word"
    fill_in "translate_selector", with: ".trans"

    click_button "Загрузить"
    visit cards_path
    expect(page).to have_content "remuneration"
  end
end
