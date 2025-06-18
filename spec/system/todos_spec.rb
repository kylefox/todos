require 'rails_helper'

RSpec.describe "Todo Management", type: :system do
  describe "viewing todos" do
    before { Todo.delete_all }

    context "when todos exist" do
      let!(:todo1) { create_todo(title: "First Todo", description: "First description") }
      let!(:todo2) { create_todo(title: "Second Todo", completed: true) }

      before { visit todos_path }

      it "displays the page title" do
        expect(page).to have_content("My Todos")
      end

      it "displays the first todo title" do
        expect(page).to have_content("First Todo")
      end

      it "displays the first todo description" do
        expect(page).to have_content("First description")
      end

      it "displays the second todo title" do
        expect(page).to have_content("Second Todo")
      end

      it "shows completed todo with strikethrough" do
        within "#todo_#{todo2.id}" do
          expect(page).to have_css(".line-through")
        end
      end
    end

    context "when no todos exist" do
      before { visit todos_path }

      it "shows empty state message" do
        expect(page).to have_content("No todos yet")
      end

      it "shows getting started message" do
        expect(page).to have_content("Get started by creating a new todo")
      end
    end
  end

  describe "creating todos" do
    before do
      Todo.delete_all
      visit todos_path
    end

    context "with valid data" do
      before do
        fill_in "What needs to be done?", with: "New Todo Item"
        fill_in "Add a description (optional)", with: "Todo description"
        click_button "Add Todo"
      end

      it "displays the new todo title" do
        expect(page).to have_content("New Todo Item")
      end

      it "displays the new todo description" do
        expect(page).to have_content("Todo description")
      end

      it "creates the todo in the database" do
        expect(Todo.last.title).to eq("New Todo Item")
      end
    end

    context "with empty form" do
      it "does not create a todo" do
        expect {
          click_button "Add Todo"
        }.not_to change(Todo, :count)
      end
    end
  end

  describe "creating todos with JavaScript", js: true do
    before do
      Todo.delete_all
      visit todos_path
    end

    it "adds todo without page refresh" do
      fill_in "What needs to be done?", with: "AJAX Todo"
      fill_in "Add a description (optional)", with: "Created via Turbo"

      expect {
        click_button "Add Todo"
        expect(page).to have_content("AJAX Todo", wait: 2)
      }.to change(Todo, :count).by(1)
    end
  end
end
