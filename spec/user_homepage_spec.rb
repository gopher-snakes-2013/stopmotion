require 'spec_helper'

feature "User visits home page" do
  scenario "User sees name of site" do
    visit "/"
    expect(page).to have_content "StopMotion"
  end

  scenario "User can fill in form" do
    visit "/"
    fill_in('email', :with => "aleksharma12@gmail.com")
    fill_in('password', :with => "1234")
  end
end