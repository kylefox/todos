require 'rails_helper'

RSpec.describe "todos/_todo.html.erb", type: :view do
  let(:todo) { Todo.new(title: title, description: description, id: 1, created_at: Time.current) }

  before do
    assign(:todo, todo)
    render partial: "todos/todo", locals: { todo: todo }
  end

  context "with HTML in title" do
    let(:title) { "<h1>Malicious Title</h1>" }
    let(:description) { "Normal description" }

    it "escapes HTML tags in titles" do
      expect(rendered).not_to have_selector("h1", text: "Malicious Title")
      expect(rendered).to include("&lt;h1&gt;Malicious Title&lt;/h1&gt;")
    end
  end

  context "with script tags in title" do
    let(:title) { "<script>alert('XSS')</script>Important Todo" }
    let(:description) { "Normal description" }

    it "escapes script tags in titles" do
      expect(rendered).not_to have_selector("script")
      expect(rendered).to include("&lt;script&gt;alert(&#39;XSS&#39;)&lt;/script&gt;Important Todo")
    end
  end

  context "with HTML in description" do
    let(:title) { "Normal title" }
    let(:description) { "<p>This is a <strong>bold</strong> description</p>" }

    it "escapes HTML tags in descriptions" do
      expect(rendered).not_to have_selector("p strong", text: "bold")
      expect(rendered).to include("&lt;p&gt;This is a &lt;strong&gt;bold&lt;/strong&gt; description&lt;/p&gt;")
    end
  end

  context "with script tags in description" do
    let(:title) { "Normal title" }
    let(:description) { "Check this out: <script>document.cookie</script>" }

    it "escapes script tags in descriptions" do
      expect(rendered).not_to have_selector("script")
      expect(rendered).to include("Check this out: &lt;script&gt;document.cookie&lt;/script&gt;")
    end
  end
end
