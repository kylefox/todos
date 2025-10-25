class TodosController < ApplicationController
  before_action :set_todo, only: %i[update destroy]

  def index
    @todo = Todo.new
    @todos = Todo.recent
  end

  def create
    @todo = Todo.new(todo_params)

    if @todo.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.prepend(
              "todos",
              partial: "todos/todo",
              locals: { todo: @todo }
            ),
            turbo_stream.replace(
              "empty_state",
              partial: "todos/empty_state",
              locals: { todos_present: Todo.exists? }
            ),
            turbo_stream.replace(
              "todo_form",
              partial: "todos/form",
              locals: { todo: Todo.new }
            )
          ]
        end
        format.html { redirect_to todos_path, notice: "Todo was successfully created." }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "todo_form",
            partial: "todos/form",
            locals: { todo: @todo }
          ), status: :unprocessable_entity
        end
        format.html do
          redirect_to todos_path, status: :see_other,
                                  alert: @todo.errors.full_messages.to_sentence
        end
      end
    end
  end

  def update
    if @todo.update(todo_params)
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@todo) }
        format.html { redirect_to todos_path }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@todo) }
        format.html { redirect_to todos_path, alert: @todo.errors.full_messages.join(", ") }
      end
    end
  end

  def destroy
    @todo.destroy

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.remove(@todo),
          turbo_stream.replace(
            "empty_state",
            partial: "todos/empty_state",
            locals: { todos_present: Todo.exists? }
          )
        ]
      end
      format.html { redirect_to todos_path, notice: "Todo was successfully removed." }
    end
  end

  private

  def set_todo
    @todo = Todo.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:title, :description, :completed)
  end
end
