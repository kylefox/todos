require 'rails_helper'

RSpec.describe "Todos", type: :request do
  describe "GET /todos" do
    it "returns success" do
      get todos_path
      expect(response).to have_http_status(200)
    end

    it "displays todos" do
      todo = create_todo(title: "Test Todo")
      get todos_path
      expect(response.body).to include("Test Todo")
    end
  end

  describe "POST /todos" do
    context "with turbo stream format" do
      let(:valid_params) { { todo: { title: "New Todo", description: "Description" } } }

      it "creates todo and returns turbo stream" do
        expect {
          post todos_path, params: valid_params, headers: turbo_stream_headers
        }.to change(Todo, :count).by(1)

        expect_turbo_stream_response
        expect(turbo_stream_actions).to include("prepend")
      end

      it "returns unprocessable entity for invalid todo" do
        post todos_path, params: { todo: { title: "" } }, headers: turbo_stream_headers

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "with HTML format" do
      it "redirects after creating todo" do
        post todos_path, params: { todo: { title: "New Todo" } }
        expect(response).to redirect_to(todos_path)
      end
    end
  end

  describe "PATCH /todos/:id" do
    let(:todo) { create_todo(completed: false) }

    context "with turbo stream format" do
      it "updates todo and returns turbo stream" do
        patch todo_path(todo),
              params: { todo: { completed: true } },
              headers: turbo_stream_headers

        expect(todo.reload.completed).to be true
        expect_turbo_stream_response
        expect(turbo_stream_actions).to include("replace")
      end
    end

    context "with HTML format" do
      it "redirects after updating todo" do
        patch todo_path(todo), params: { todo: { completed: true } }
        expect(response).to redirect_to(todos_path)
      end
    end
  end

  describe "DELETE /todos/:id" do
    let!(:todo) { create_todo }

    context "with turbo stream format" do
      it "destroys todo and returns turbo stream" do
        expect {
          delete todo_path(todo), headers: turbo_stream_headers
        }.to change(Todo, :count).by(-1)

        expect_turbo_stream_response
        expect(turbo_stream_actions).to include("remove")
      end
    end

    context "with HTML format" do
      it "redirects after destroying todo" do
        delete todo_path(todo)
        expect(response).to redirect_to(todos_path)
      end
    end
  end
end
