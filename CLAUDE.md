# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## IMPORTANT RULES

1. **Never make assumptions** - Always ask for clarification before adding dependencies, tools, or features
2. **Do only what is explicitly requested** - Don't add extras without permission
3. **Confirm architectural decisions** - Check before adding databases, caching layers, or third-party services
4. **Do not add extraneous, unhelpful, verbose comments to the code** - Keep code clean and self-documenting
5. **Follow YAGNI (You Ain't Gonna Need It)** - Only add configurations, dependencies, and code that are immediately needed
6. **Keep it simple.** Think step by step about whether there exists a less over-engineered and yet simpler, more elegant, and more robust solution to the problem that accords with KISS and DRY principles.

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

- Write tests as needed for critical functionality
- System tests for user flows
- Model tests for validations/methods
- Service tests for business logic
- Maintain good test coverage

### Database Design

- Use proper indexes
- Add database constraints
- Use enums for status fields
- Soft deletes where appropriate
- UUID primary keys for API exposure

## Development Workflow

### Commands to Run

```bash
# Setup (first time)
mise install          # Install all tools
bundle install        # Install Ruby gems

# Development
bin/dev               # Start Rails with Tailwind watch
bin/rails test        # Run test suite
bin/rails db:migrate  # Run migrations
bin/rubocop           # Lint Ruby code
bin/rails routes      # View routes

# Deployment checks
bin/rails assets:precompile
bin/rails db:prepare
```

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

### Starting the Application

```bash
bin/dev  # Starts Rails server and Tailwind CSS watcher concurrently
```

### Setup

```bash
bin/setup  # Initial setup - installs dependencies and prepares database
```

### Database Commands

```bash
bin/rails db:create     # Create databases
bin/rails db:migrate    # Run migrations
bin/rails db:seed       # Load seed data
bin/rails db:reset      # Drop, create, migrate, and seed
```

### Code Quality

```bash
bin/rubocop            # Run Ruby style checks
bin/brakeman           # Run security vulnerability scanner
```

### Rails Console

```bash
bin/rails console      # Interactive Rails console
bin/rails c            # Shorthand
```

### PostgreSQL Management

```bash
pg_ctl start          # Start PostgreSQL server
pg_ctl stop           # Stop PostgreSQL server  
pg_ctl status         # Check PostgreSQL status
psql                  # PostgreSQL interactive terminal
```

## Architecture Overview

This is a Rails 8.0.2 application using modern Rails conventions:

### Frontend Stack

- **Import Maps**: JavaScript modules without bundling (configured in config/importmap.rb)
- **Stimulus**: Modest JavaScript framework for HTML you already have
- **Turbo**: SPA-like page updates without writing JavaScript
- **Tailwind CSS**: Utility-first CSS framework (watch with bin/dev)

### Backend Architecture

- **Database**: PostgreSQL with Solid Cache/Queue/Cable (all database-backed)
- **Asset Pipeline**: Propshaft (not Sprockets) for serving assets
- **Web Server**: Puma

### Key Directories

- `app/javascript/controllers/`: Stimulus controllers
- `app/assets/stylesheets/tailwind/`: Tailwind configuration
- `config/importmap.rb`: JavaScript module mappings

### Important Notes

- No test framework is currently configured
- Uses database-backed adapters for caching, queuing, and WebSockets (no Redis needed)
- Deployment-ready with Dockerfile and Kamal configuration
- Development uses Foreman to manage multiple processes (Rails + Tailwind watcher)
