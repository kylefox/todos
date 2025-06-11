# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

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