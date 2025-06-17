require 'rails_helper'

RSpec.describe "Todo Management", type: :system do
  describe "viewing todos" do
    before { Todo.delete_all }
    
    it "displays all todos" do
      todo1 = create_todo(title: "First Todo", description: "First description")
      todo2 = create_todo(title: "Second Todo", completed: true)
      
      visit todos_path
      
      expect(page).to have_content("My Todos")
      expect(page).to have_content("First Todo")
      expect(page).to have_content("First description")
      expect(page).to have_content("Second Todo")
      
      # Check completed todo has strikethrough
      within "#todo_#{todo2.id}" do
        expect(page).to have_css(".line-through")
      end
    end
    
    it "shows empty state when no todos exist" do
      visit todos_path
      
      expect(page).to have_content("No todos yet")
      expect(page).to have_content("Get started by creating a new todo")
    end
  end
  
  describe "creating todos" do
    before { Todo.delete_all }
    
    it "creates a todo without JavaScript" do
      visit todos_path
      
      fill_in "What needs to be done?", with: "New Todo Item"
      fill_in "Add a description (optional)", with: "Todo description"
      click_button "Add Todo"
      
      expect(page).to have_content("New Todo Item")
      expect(page).to have_content("Todo description")
      expect(Todo.last.title).to eq("New Todo Item")
    end
    
    it "validates required fields" do
      visit todos_path
      
      # Try to submit empty form
      click_button "Add Todo"
      
      # HTML5 validation should prevent submission
      expect(Todo.count).to eq(0)
    end
  end
  
  describe "creating todos with JavaScript", js: true do
    it "adds todo without page refresh" do
      visit todos_path
      
      fill_in "What needs to be done?", with: "AJAX Todo"
      fill_in "Add a description (optional)", with: "Created via Turbo"
      
      expect {
        click_button "Add Todo"
        sleep(0.5)  # Wait for Turbo to process
        expect(page).to have_content("AJAX Todo")
      }.to change(Todo, :count).by(1)
    end
  end
end