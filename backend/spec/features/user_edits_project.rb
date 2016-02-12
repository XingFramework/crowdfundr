require "spec_helper"

RSpec.steps "Visitor Creates a New Project", js: :true, vcr: {} do
  before :all do
    @user = FactoryGirl.create(:user)
    @project = FactoryGirl.create(:project,
                                 :name => "Xing Framework",
                                 :description => "Cool",
                                 :user => @user)
  end

  it "visits root" do
    visit "/"
  end

  it "shows a list of projects" do
    expect(page).to have_content("Xing Framework")
  end

  it "clicks on a project" do
    click_link("View")
  end

  it "shows the experience page" do
    expect(page).to have_content("Cool")
  end

  it "does not display the edit button" do
    expect(page).not_to have_content("Edit Project")
  end

  perform_steps "sign in with"

  it "visits root" do
    visit "/"
  end

  it "shows a list of projects" do
    expect(page).to have_content("Xing Framework")
  end

  it "clicks on a project" do
    click_link("View")
  end

  it "shows the experience page" do
    expect(page).to have_content("Cool")
  end

  it "clicks to edit the project" do
    click_button("Edit Project")
  end

  it "should be on the edit page" do
    expect(page).to have_content("Edit Project")
  end

  it "should change the name" do
    fill_in "Name", :with => "Brand New Name"
  end

  it "should save the new name" do
    click_button("Save")
  end

  it "should persist the data" do
    expect(page).to have_content("Brand New Name")
  end

  it "should be on the project show page" do
    expect(URI(current_url).path).to eq("/inner/project/1")
  end
end
