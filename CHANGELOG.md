# CHANGELOG

## 2025-07-27

- Reorganize project phases to defer PWA and production polish features
  - Create PHASE_5.md for Production Launch Preparation
  - Move PWA Infrastructure items from Phase 1 to Phase 5
  - Move Polish & Launch Prep items from Phase 1 to Phase 5
  - Update PROJECT_ROADMAP.md to include Phase 5
  - Phase 1 now focuses solely on core todo functionality

## 2025-07-21

- Update Ruby gem dependencies to latest versions:
  - rubocop 1.76.1 → 1.78.0
  - selenium-webdriver 4.33.0 → 4.34.0
  - solid_cable 3.0.8 → 3.0.11
  - solid_queue 1.1.5 → 1.2.0
  - tailwindcss-rails 4.2.3 → 4.3.0
  - kamal 2.6.1 → 2.7.0
  - debug 1.10.0 → 1.11.0
  - And other minor dependency updates

## 2025-07-13

- Upgrade Ruby from 3.3.7 to 3.4.4 (latest stable version)
  - Updated .tool-versions and .ruby-version using mise
  - Updated CLAUDE.md documentation to reflect new Ruby version
  - All tests passing with new Ruby version
- Upgrade rspec-rails from 7.1.1 to 8.0.1 for Rails 8 compatibility
  - All 76 tests passing without any changes required

## 2025-07-12

- Enable JavaScript system tests with Selenium Manager

## 2025-06-18

- Refactor controller specs with rspec-its gem for DRY principles
- Apply RSpec best practices to entire test suite
- Conduct security review of PR #3
- Create view spec to test XSS protection in todo partial
- Confirm Rails ERB templates properly escape HTML by default
- Post PR review comments highlighting security concerns:
  - Authentication system missing (valid concern)
  - Privacy issues with global broadcasting (valid concern)
  - XSS vulnerability (false positive - Rails escapes by default)
- Refactor TodosController to follow Rails conventions:
  - Add `before_action :set_todo` callback to DRY up code
  - Remove duplicate `Todo.find` calls from update and destroy actions
- Add controller-specific CLAUDE.md with coding conventions

## 2025-06-17

- Update progress in project roadmap
- Add comprehensive test suite with 47 passing tests
- Implement real-time todo management with Turbo Streams
  - Connect TodosController to database with Todo.recent scope
  - Create _todo partial with checkbox, title, description, and timestamps
  - Add new todo form with inline creation
  - Implement full CRUD actions (create, update, destroy) with Turbo Streams
  - Create todo_checkbox Stimulus controller for toggling completion
  - Enable real-time broadcasting for multi-tab synchronization
  - Add reset_form Stimulus controller for form cleanup
  - Create seed data for testing
- Add comprehensive test suite:
  - Configure Capybara for system testing
  - Create controller specs for all CRUD actions
  - Add request specs testing Turbo Stream responses
  - Build system specs with JavaScript testing
  - Update model specs with broadcast testing
  - Create test helpers for simple todo creation
- All 47 tests passing with comprehensive coverage:
  - 11 controller specs testing CRUD actions
  - 21 model specs with validations and broadcasting
  - 13 request specs testing Turbo Stream responses  
  - 2 system specs for integration testing
- Clarify testing dependencies per Rails documentation:
  - `rails-controller-testing` required for `assigns()` in controller specs
  - `capybara` required for system tests (not included in Rails by default)
  - `selenium-webdriver` required for JavaScript system tests
- Add shoulda-matchers gem for better RSpec matchers
- Add comprehensive Todo model specs with validations and scopes
- Add Todo model with validations and scopes
- Add responsive layout with PWA support
- Remove daisyUI references from documentation

## 2025-06-12

- Create TodosController with RESTful index action
- Update CLAUDE.md with project guidelines
- Update PROJECT_ROADMAP.md with project overview
- Create PHASE_1.md with detailed Phase 1 checklist
- Update PROJECT_ROADMAP.md structure