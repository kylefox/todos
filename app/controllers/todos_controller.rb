class TodosController < ApplicationController
  def index
    @todos = Todo.recent
  end

  def create
    @todo = Todo.new(todo_params)

    if @todo.save
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.prepend("todos", @todo) }
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
    @todo = Todo.find(params[:id])

    if @todo.update(todo_params)
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@todo) }
        format.html { redirect_to todos_path }
      end
    else
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            @todo,
            partial: "todos/todo",
            locals: { todo: @todo }
          )
        }
        format.html { redirect_to todos_path, alert: @todo.errors.full_messages.join(", ") }
      end
    end
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@todo) }
      format.html { redirect_to todos_path }
    end
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :description, :completed)
  end
end
