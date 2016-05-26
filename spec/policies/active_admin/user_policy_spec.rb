require 'rails_helper'
require 'pundit/rspec'

RSpec.describe UserPolicy do
  subject { described_class }

  before do
    @admin_user = User.new(email: "admin@test.ru",
                           password: "123",
                           password_confirmation: "123")
    @admin_user.add_role :admin

    @user = User.new(email: "test@test.ru",
                     password: '123',
                     password_confirmation: '123')
  end

  # permissions ".scope" do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end

  permissions :create? do
    it "denies create user if user is not admin" do
      expect(subject).not_to permit(User.new, @user)
    end
  end

  permissions :create? do
    it "allow create user if user is admin" do
      expect(subject).to permit(@admin_user, @user)
    end
  end  

  permissions :update?, :edit? do
    it "denies access if user is not admin" do
      expect(subject).not_to permit(User.new, @user)
    end
  end

  permissions :update?, :edit? do
    it "allow access if user is admin" do
      expect(subject).to permit(@admin_user, @user)
    end
  end

  permissions :destroy? do
    it "denies access if user is not admin" do
      expect(subject).not_to permit(User.new, @user)
    end
  end

  permissions :destroy? do
    it "allow access if user is admin" do
      expect(subject).to permit(@admin_user, @user)
    end
  end
end
