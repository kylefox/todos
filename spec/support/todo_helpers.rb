# Simple helper methods for todo tests
module TodoHelpers
  def create_todo(title: "Test Todo", description: nil, completed: false)
    Todo.create!(
      title: title,
      description: description,
      completed: completed
    )
  end
  
  def create_todos(count = 3)
    count.times do |i|
      create_todo(title: "Todo #{i + 1}", completed: i.even?)
    end
  end
end

RSpec.configure do |config|
  config.include TodoHelpers
end