require "rails_helper"
require "support/helpers/login_helper.rb"
include LoginHelper

feature "User create events" do
  let!(:user) { create :user_with_one_block_and_one_card }
  before do
    visit root_path
    login user.email, "12345", "Войти"
  end

  scenario "they whant to log user visit" do
    visit cards_path
    expect( Ahoy::Event.where(name: "Processed cards#index").count ).to eq(1)
  end
end
