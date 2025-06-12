# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## IMPORTANT RULES

1. **Never make assumptions** - Always ask for clarification before adding dependencies, tools, or features
2. **Do only what is explicitly requested** - Don't add extras without permission
3. **Confirm architectural decisions** - Check before adding databases, caching layers, or third-party services
4. **Do not add extraneous, unhelpful, verbose comments to the code** - Keep code clean and self-documenting
5. **Follow YAGNI (You Ain't Gonna Need It)** - Only add configurations, dependencies, and code that are immediately needed
6. **Keep it simple.** Think step by step about whether there exists a less over-engineered and yet simpler, more elegant, and more robust solution to the problem that accords with KISS and DRY principles.
7. **Avoid complexity.** Always prioritize the simplest solution over complexity. If a solution is starting to feel complex, pause and ask the user for guidance and approval before continuing.
8. **Keep codebase maintainable.** Don't create duplicate functionality, keep files focused and concise, suggest refactoring opportunities.

## Workflow

- **Focus:** Modify only the code I specify or is directly related to the current task; leave everything else untouched.
- **Steps:** Break large tasks into stages; pause after each for my approval.
- **Planning:** Before big changes, tell me your plan and have me confirm it before proceeding.
- **Tracking:** Log completed work in CHANGELOG.md. Brief bullet points, grouped by date.

## Tech Stack

- Ruby 3.3.7 (managed via mise)
- Rails 8 (with built-in Solid Cache, Solid Queue, Solid Cable)
- PostgreSQL
- Hotwire (Turbo + Stimulus)
- PWA (Progressive Web App)

## Coding Standards

### Ruby/Rails Conventions

- Follow Ruby Style Guide (rubocop standard)
- Use Rails conventions and best practices
- Always use the latest APIs and features available for Rails, Stimulus, Turbo, etc.
- Consult documentation if you are unsure about how framework features work
- Prefer composition over inheritance
- Keep controllers thin, models skinny
- Use concerns for shared behavior
- Write descriptive commit messages
- Write tests as often as practical when adding or changing code

### Turbo/Hotwire Patterns

- Use Turbo Frames for partial page updates
- Turbo Streams for real-time broadcasts
- Stimulus for JavaScript behavior
- Progressive enhancement approach
- Graceful degradation for non-JS

### UI Development with daisyUI

- Use semantic component classes (btn, card, modal, etc.)
- Avoid excessive utility classes when daisyUI components exist
- Apply themes for consistent styling
- Customize with Tailwind utilities when needed
- Reference: https://daisyui.com/components/

### Testing

- RSpec for testing framework
- System tests for user flows
- Model tests for validations/methods
- Service tests for business logic
- Request specs for API endpoints
- Maintain good test coverage

### Database Design

- Use proper indexes
- Add database constraints
- Use enums for status fields
- Soft deletes where appropriate
- UUID primary keys for API exposure

## Development Workflow

### Git Workflow

- Feature branches from main
- Descriptive branch names: feature/add-user-auth
- Run linters and tests before making commits

## Performance Guidelines

- Use database indexes appropriately
- Implement caching (Russian doll caching)
- Background jobs for heavy processing
- Optimize N+1 queries
- Use Turbo to minimize full page loads

## Accessibility

- Semantic HTML
- ARIA labels where needed
- Keyboard navigation support
- Screen reader friendly
- High contrast mode support

## PWA Requirements

- Service worker for offline
- Web app manifest
- Push notifications
- Installable on mobile/desktop
- Responsive design
- Touch-friendly UI

## Remember

- Prioritize user experience
- Make it production-ready
- Keep it simple and maintainable

## Development Commands

```bash
# Setup
mise install          # Install Ruby & PostgreSQL
bundle install        # Install gems
bin/setup             # Setup database

# Development
bin/dev               # Start Rails + Tailwind watcher
bin/rails console     # Rails console (or bin/rails c)
bin/rails db:migrate  # Run migrations
bin/rails spec        # Run RSpec tests
bin/rubocop           # Ruby style checks
bin/brakeman          # Security scanner

# PostgreSQL
pg_ctl start          # Start PostgreSQL
pg_ctl stop           # Stop PostgreSQL
psql                  # PostgreSQL console
```

## Architecture Notes

- Rails 8.0.2 with Import Maps (no JS bundling)
- Stimulus + Turbo for interactivity
- Tailwind CSS with Foreman watch process
- PostgreSQL with Solid Cache/Queue/Cable
- Propshaft asset pipeline
- RSpec configured for testing
