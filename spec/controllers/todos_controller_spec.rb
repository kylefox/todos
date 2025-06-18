require 'rails_helper'

RSpec.describe TodosController, type: :controller do
  describe "GET #index" do
    subject(:request) { get :index }

    before do
      Todo.delete_all
      @old_todo = create_todo(title: "Old Todo").tap { |t| t.update!(created_at: 1.day.ago) }
      @new_todo = create_todo(title: "New Todo")
    end

    it { is_expected.to be_successful }

    it "assigns todos ordered by recent" do
      request
      expect(assigns(:todos).to_a).to eq([ @new_todo, @old_todo ])
    end
  end

  describe "POST #create" do
    subject(:request) { post :create, params: params, format: format }

    let(:format) { :html }

    context "with valid params" do
      let(:params) { { todo: { title: "New Todo", description: "Test description" } } }

      it { expect { request }.to change(Todo, :count).by(1) }

      context "when format is turbo_stream" do
        let(:format) { :turbo_stream }

        before { request }

        its(:content_type) { is_expected.to include("text/vnd.turbo-stream.html") }
        its(:body) { is_expected.to include('action="prepend"') }
        its(:body) { is_expected.to include('target="todos"') }
      end
    end

    context "with invalid params" do
      let(:params) { { todo: { title: "" } } }

      it { expect { request }.not_to change(Todo, :count) }

      context "when format is turbo_stream" do
        let(:format) { :turbo_stream }

        it { is_expected.to have_http_status(:unprocessable_entity) }
      end
    end
  end

  describe "PATCH #update" do
    subject(:request) { patch :update, params: params, format: format }

    let(:todo) { create_todo(title: "Make coffee", completed: false) }
    let(:format) { :html }

    context "with valid params" do
      let(:params) { { id: todo.id, todo: { completed: true } } }

      it "updates the todo" do
        expect { request }.to change { todo.reload.completed }.from(false).to(true)
      end

      context "when format is turbo_stream" do
        let(:format) { :turbo_stream }

        before { request }

        its(:content_type) { is_expected.to include("text/vnd.turbo-stream.html") }
        its(:body) { is_expected.to include('action="replace"') }
        its(:body) { is_expected.to include("todo_#{todo.id}") }
      end
    end

    context "with invalid params" do
      let(:params) { { id: todo.id, todo: { title: "" } } }

      it "does not update the todo" do
        expect { request }.not_to change { todo.reload.title }.from("Make coffee")
      end
    end
  end

  describe "DELETE #destroy" do
    subject(:request) { delete :destroy, params: { id: todo.id }, format: format }

    let!(:todo) { create_todo }
    let(:format) { :html }

    it { expect { request }.to change(Todo, :count).by(-1) }

    context "when format is turbo_stream" do
      let(:format) { :turbo_stream }

      before { request }

      its(:content_type) { is_expected.to include("text/vnd.turbo-stream.html") }
      its(:body) { is_expected.to include('action="remove"') }
      its(:body) { is_expected.to include("todo_#{todo.id}") }
    end
  end
end
