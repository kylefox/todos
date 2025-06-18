# CLAUDE.md - RSpec Testing Guidelines

This file provides guidance to Claude Code when writing RSpec tests for this repository.

## Core Principles

1. **DRY (Don't Repeat Yourself)** - Use RSpec's rich feature set to minimize repetition
2. **One expectation per example** - Each test should verify exactly one thing
3. **Use RSpec's DSL** - Leverage subject, let, its, and other RSpec features

## Required Gems

```ruby
# In Gemfile test group:
gem "rspec-rails"
gem "rspec-its"  # For `its` syntax
```

The `rspec/its` require is configured in `rails_helper.rb` - do not add it to individual spec files.

## Writing Specs

### Use `subject` for the Primary Action

```ruby
# Good
describe "GET #index" do
  subject(:request) { get :index }
  
  it { is_expected.to be_successful }
end

# Bad
describe "GET #index" do
  it "returns a success response" do
    get :index
    expect(response).to be_successful
  end
end
```

### One Expectation Per Example

```ruby
# Good
context "when format is turbo_stream" do
  let(:format) { :turbo_stream }
  
  before { request }
  
  its(:content_type) { is_expected.to include("text/vnd.turbo-stream.html") }
  its(:body) { is_expected.to include('action="prepend"') }
  its(:body) { is_expected.to include('target="todos"') }
end

# Bad
it "responds with turbo stream" do
  post :create, params: { todo: valid_attributes }, format: :turbo_stream
  expect(response.content_type).to include("text/vnd.turbo-stream.html")
  expect(response.body).to include('action="prepend"')
  expect(response.body).to include('target="todos"')
end
```

### Controller Spec Pattern

```ruby
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
end
```

### Use `let` for Test Data

```ruby
# Good
let(:todo) { create_todo(title: "Test Todo") }
let(:valid_attributes) { { title: "New Todo", description: "Test" } }
let(:invalid_attributes) { { title: "" } }

# Bad
before do
  @todo = create_todo(title: "Test Todo")
  @valid_attributes = { title: "New Todo", description: "Test" }
end
```

### Use Change Matchers

```ruby
# Good
it { expect { request }.to change(Todo, :count).by(1) }
it { expect { request }.to change { todo.reload.completed }.from(false).to(true) }

# Bad
it "creates a todo" do
  count_before = Todo.count
  request
  expect(Todo.count).to eq(count_before + 1)
end
```

### Context Organization

- Use descriptive context blocks
- Nest contexts logically
- Keep related tests together

```ruby
describe "POST #create" do
  context "with valid params" do
    context "when format is turbo_stream" do
      # specs here
    end
    
    context "when format is html" do
      # specs here
    end
  end
  
  context "with invalid params" do
    # specs here
  end
end
```

## Best Practices

1. **Prefer one-liners when possible**: `it { is_expected.to be_successful }`
2. **Use `before` hooks sparingly**: Only for setup that multiple tests need
3. **Name `subject` for clarity**: `subject(:request)` instead of just `subject`
4. **Keep specs focused**: Test behavior, not implementation
5. **Use factory methods**: `create_todo` instead of `Todo.create`

## Anti-patterns to Avoid

1. Multiple expectations in one test
2. Testing implementation details
3. Overly complex setup
4. Deeply nested contexts (max 3 levels)
5. Using instance variables instead of `let`