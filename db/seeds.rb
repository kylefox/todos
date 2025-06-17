# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create sample todos for development
Todo.destroy_all

Todo.create!([
  {
    title: "Set up development environment",
    description: "Install Ruby, Rails, and PostgreSQL",
    completed: true
  },
  {
    title: "Create Todo model",
    description: "Add validations and database indexes",
    completed: true
  },
  {
    title: "Build todo UI components",
    description: "Create partials and forms for todo management",
    completed: false
  },
  {
    title: "Implement real-time updates",
    description: "Use Turbo Streams for live synchronization across tabs",
    completed: false
  },
  {
    title: "Add PWA features",
    description: "Service worker, offline support, and app icons",
    completed: false
  }
])

puts "Created #{Todo.count} todos"
