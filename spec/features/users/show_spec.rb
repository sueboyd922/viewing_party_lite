require 'rails_helper'

RSpec.describe "User Dashboard/Show Page", type: :feature do
  it 'has the users info' do
    user1 = User.create!(name: "Amy", email: 'amy@mail.com', password: "test", password_confirmation: "test")
    user2 = User.create!(name: "James", email: 'james@mail.com', password: "test", password_confirmation: "test")

    visit "/users/#{user1.id}"

    expect(page).to have_content("Amy's Dashboard")
    expect(page).not_to  have_content("James's Dashboard")

    expect(page).to have_content("Viewing Parties")
  end

  it 'has a button to discover movies' do
    user1 = User.create!(name: "Amy", email: 'amy@mail.com', password: "test", password_confirmation: "test")
    user2 = User.create!(name: "James", email: 'james@mail.com', password: "test", password_confirmation: "test")

    visit "/users/#{user1.id}"

    click_on "Discover Movies"
    expect(current_path).to eq("/users/#{user1.id}/discover")
  end

  it 'shows the viewing parties they were invited to', :vcr do
    user_1 = User.create!(name: "Joe", email: "joe@mail.com", password: "test", password_confirmation: "test")
    user_2 = User.create!(name: "Amy", email: "amy@mail.com", password: "test", password_confirmation: "test")

    date = Date.today
    time = Time.now
    party_1 = Party.create!(date: date, time: time, duration: 97, movie_id: 278, host: user_2.id)
    party_2 = Party.create!(date: date, time: time, duration: 120, movie_id: 238, host: user_1.id)
    party_3 = Party.create!(date: date, time: time, duration: 100, movie_id: 424, host: user_2.id)

    party_user_1 = PartyUser.create!(party: party_1, user: user_2, host: true)
    party_user_2 = PartyUser.create!(party: party_1, user: user_1, host: false)
    party_user_3 = PartyUser.create!(party: party_2, user: user_1, host: true)
    party_user_4 = PartyUser.create!(party: party_2, user: user_2, host: false)
    party_user_5 = PartyUser.create!(party: party_3, user: user_2, host: true)
    party_user_6 = PartyUser.create!(party: party_3, user: user_1, host: false)

    visit "/users/#{user_1.id}"

    within ".invited_to" do
      expect(page).to have_link("Shawshank Redemption")
      expect(page).to have_link("Schindler's List")
      expect(page).not_to have_link("The Godfather")
    end

    within ".hosting" do
      expect(page).to have_link("The Godfather")
      expect(page).not_to have_link("Shawshank Redemption")
      expect(page).not_to have_link("Schindler's List")
    end

    visit "/users/#{user_2.id}"
    within ".invited_to" do
      expect(page).to have_link("The Godfather")
      expect(page).not_to have_link("Shawshank Redemption")
      expect(page).not_to have_link("Schindler's List")
    end

    within ".hosting" do
      expect(page).to have_link("Shawshank Redemption")
      expect(page).to have_link("Schindler's List")
      expect(page).not_to have_link("The Godfather")
    end
  end
end
