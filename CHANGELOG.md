# CHANGELOG

## 2025-01-18

- Conduct security review of PR #3
- Create view spec to test XSS protection in todo partial
- Confirm Rails ERB templates properly escape HTML by default
- Post PR review comments highlighting security concerns:
  - Authentication system missing (valid concern)
  - Privacy issues with global broadcasting (valid concern)
  - XSS vulnerability (false positive - Rails escapes by default)

## 2025-01-17 (continued)

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

## 2025-01-17

- Update progress in project roadmap
- Add shoulda-matchers gem for better RSpec matchers
- Add comprehensive Todo model specs with validations and scopes
- Add Todo model with validations and scopes
- Add responsive layout with PWA support
- Remove daisyUI references from documentation

## 2025-01-16

- Create TodosController with RESTful index action
- Update CLAUDE.md with project guidelines
- Update PROJECT_ROADMAP.md with project overview
- Create PHASE_1.md with detailed Phase 1 checklist
- Update PROJECT_ROADMAP.md structure