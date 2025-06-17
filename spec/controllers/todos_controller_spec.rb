require 'rails_helper'

RSpec.describe TodosController, type: :controller do
  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end

    it "assigns todos ordered by recent" do
      Todo.delete_all  # Clear any existing todos
      old_todo = create_todo(title: "Old Todo")
      old_todo.update!(created_at: 1.day.ago)
      new_todo = create_todo(title: "New Todo")

      get :index
      expect(assigns(:todos).to_a).to eq([ new_todo, old_todo ])
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:valid_attributes) { { title: "New Todo", description: "Test description" } }

      it "creates a new Todo" do
        expect {
          post :create, params: { todo: valid_attributes }
        }.to change(Todo, :count).by(1)
      end

      it "responds with turbo stream" do
        post :create, params: { todo: valid_attributes }, format: :turbo_stream
        expect(response.content_type).to include("text/vnd.turbo-stream.html")
        expect(response.body).to include('action="prepend"')
        expect(response.body).to include('target="todos"')
      end
    end

    context "with invalid params" do
      let(:invalid_attributes) { { title: "" } }

      it "does not create a new Todo" do
        expect {
          post :create, params: { todo: invalid_attributes }
        }.not_to change(Todo, :count)
      end

      it "responds with unprocessable entity" do
        post :create, params: { todo: invalid_attributes }, format: :turbo_stream
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH #update" do
    let(:todo) { create_todo(completed: false) }

    context "with valid params" do
      it "updates the todo" do
        patch :update, params: { id: todo.id, todo: { completed: true } }
        todo.reload
        expect(todo.completed).to be true
      end

      it "responds with turbo stream" do
        patch :update, params: { id: todo.id, todo: { completed: true } }, format: :turbo_stream
        expect(response.content_type).to include("text/vnd.turbo-stream.html")
        expect(response.body).to include('action="replace"')
        expect(response.body).to include("todo_#{todo.id}")
      end
    end

    context "with invalid params" do
      it "does not update the todo" do
        patch :update, params: { id: todo.id, todo: { title: "" } }
        todo.reload
        expect(todo.title).not_to eq("")
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:todo) { create_todo }

    it "destroys the requested todo" do
      expect {
        delete :destroy, params: { id: todo.id }
      }.to change(Todo, :count).by(-1)
    end

    it "responds with turbo stream" do
      delete :destroy, params: { id: todo.id }, format: :turbo_stream
      expect(response.content_type).to include("text/vnd.turbo-stream.html")
      expect(response.body).to include('action="remove"')
      expect(response.body).to include("todo_#{todo.id}")
    end
  end
end
