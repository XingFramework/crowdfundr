require "spec_helper"

RSpec.steps "Visitor Creates a New Project", js: :true, vcr: {} do

  it "visits root" do
    visit "/"
  end

  skip do
  it "is on the homepage" do
    expect(page).to have_content("Create a New Project")
  end

  it "clicks link" do
    click_button("Create a New Project")
  end

  it "is on the new-project page" do
    expect(page).to have_content("New Project")
  end

  it "fills in form information" do
  end

  it "submits new project" do
  end

  it "redirects to project detail page" do
  end
  end

end
