require 'rails_helper'
require 'rspec/its'

RSpec.describe "Todos", type: :request do
  describe "GET /todos" do
    subject(:request) { get todos_path }

    it { is_expected.to eq(200) }

    context "when todos exist" do
      let!(:todo) { create_todo(title: "Test Todo") }

      it "displays the todo" do
        request
        expect(response.body).to include("Test Todo")
      end
    end
  end

  describe "POST /todos" do
    subject(:request) { post todos_path, params: params, headers: headers }

    let(:headers) { {} }

    context "with valid params" do
      let(:params) { { todo: { title: "New Todo", description: "Description" } } }

      context "with turbo stream format" do
        let(:headers) { turbo_stream_headers }

        it { expect { request }.to change(Todo, :count).by(1) }

        context "response" do
          before { request }

          it { expect_turbo_stream_response }

          it "includes prepend action" do
            expect(turbo_stream_actions).to include("prepend")
          end
        end
      end

      context "with HTML format" do
        it { is_expected.to redirect_to(todos_path) }
      end
    end

    context "with invalid params" do
      let(:params) { { todo: { title: "" } } }

      context "with turbo stream format" do
        let(:headers) { turbo_stream_headers }

        it { is_expected.to eq(422) }
      end
    end
  end

  describe "PATCH /todos/:id" do
    subject(:request) { patch todo_path(todo), params: params, headers: headers }

    let(:todo) { create_todo(completed: false) }
    let(:params) { { todo: { completed: true } } }
    let(:headers) { {} }

    context "with turbo stream format" do
      let(:headers) { turbo_stream_headers }

      it "updates the todo" do
        expect { request }.to change { todo.reload.completed }.from(false).to(true)
      end

      context "response" do
        before { request }

        it { expect_turbo_stream_response }

        it "includes replace action" do
          expect(turbo_stream_actions).to include("replace")
        end
      end
    end

    context "with HTML format" do
      it { is_expected.to redirect_to(todos_path) }
    end
  end

  describe "DELETE /todos/:id" do
    subject(:request) { delete todo_path(todo), headers: headers }

    let!(:todo) { create_todo }
    let(:headers) { {} }

    context "with turbo stream format" do
      let(:headers) { turbo_stream_headers }

      it { expect { request }.to change(Todo, :count).by(-1) }

      context "response" do
        before do
          @todo_id = todo.id
          request
        end

        it { expect_turbo_stream_response }

        it "includes remove action" do
          expect(turbo_stream_actions).to include("remove")
        end
      end
    end

    context "with HTML format" do
      it { is_expected.to redirect_to(todos_path) }
    end
  end
end
