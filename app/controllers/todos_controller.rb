class TodosController < ApplicationController
  before_action :set_todo, only: %i[update destroy]

  def index
    @todos = Todo.recent
  end

  def create
    @todo = Todo.new(todo_params)

    if @todo.save
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.append("todos", @todo) }
        format.html { redirect_to todos_path }
      end
    else
      respond_to do |format|
        format.turbo_stream { head :unprocessable_entity }
        format.html { redirect_to todos_path, alert: @todo.errors.full_messages.join(", ") }
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
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@todo) }
      format.html { redirect_to todos_path }
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
