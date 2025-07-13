# Todos - Rails Application

A modern Rails 8.0.2 application for managing todos.

## Prerequisites

- macOS (tested on macOS 15.5)
- [Homebrew](https://brew.sh/)
- [mise](https://mise.jdx.dev/) - for Ruby and PostgreSQL version management

## Setup

### 1. Install mise

```bash
brew install mise
```

### 2. Install PostgreSQL dependencies

PostgreSQL requires several Homebrew packages to compile successfully:

```bash
brew install icu4c openssl@3 ossp-uuid readline zlib
```

### 3. Clone and setup the project

```bash
git clone <repository-url>
cd todos
```

### 4. Install Ruby and PostgreSQL

The project uses mise to manage tool versions. Simply run:

```bash
mise install
```

This will install:
- Ruby 3.4.4
- PostgreSQL 17.5

**Note on PostgreSQL installation**: If the PostgreSQL installation fails with missing library errors, you may need to set environment variables to help it find the Homebrew dependencies:

```bash
LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib -L/opt/homebrew/opt/icu4c@77/lib -L/opt/homebrew/opt/ossp-uuid/lib" \
CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include -I/opt/homebrew/opt/icu4c@77/include -I/opt/homebrew/opt/ossp-uuid/include" \
PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@3/lib/pkgconfig:/opt/homebrew/opt/icu4c@77/lib/pkgconfig" \
mise install postgres@latest
```

### 5. Setup PostgreSQL

After PostgreSQL is installed, you need to create a database user:

```bash
# Create a superuser role with your username
mise exec postgres -- psql -U postgres -c "CREATE ROLE $USER WITH SUPERUSER LOGIN;"

# Create a database with your username
mise exec postgres -- createdb $USER
```

### 6. Install Ruby dependencies

```bash
bundle install
```

### 7. Setup the database

```bash
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed  # if you have seed data
```

## Running the Application

Start the development server and Tailwind CSS watcher:

```bash
bin/dev
```

Visit http://localhost:3000

## Development Commands

- `bin/rails console` - Interactive Rails console
- `bin/rails db:migrate` - Run database migrations
- `bin/rails spec` - Run RSpec test suite
- `bin/rubocop` - Run Ruby style checks
- `bin/brakeman` - Run security vulnerability scanner

## Useful MCP Servers

[PostgreSQL](https://www.npmjs.com/package/@modelcontextprotocol/server-postgres)

```bash
claude mcp add postgres -- npx -y @modelcontextprotocol/server-postgres postgresql://127.0.0.1/todos_development
```

[Puppeteer](https://www.npmjs.com/package/@modelcontextprotocol/server-puppeteer)

```bash
claude mcp add puppeteer -- npx -y @modelcontextprotocol/server-puppeteer
```

## Architecture

This Rails 8.0.2 application uses:
- **Import Maps** for JavaScript (no bundling required)
- **Stimulus** for JavaScript behavior
- **Turbo** for SPA-like navigation and real-time updates
- **Tailwind CSS** for styling
- **PostgreSQL** for the database
- **Solid Cache/Queue/Cable** (database-backed, no Redis needed)
- **RSpec** with comprehensive test suite (47 tests)

## Troubleshooting

### PostgreSQL connection issues

If you get "role does not exist" errors, ensure you've created the database user as shown in step 5.

### Mise activation

The `.tool-versions` file ensures the correct Ruby and PostgreSQL versions are activated when you enter the project directory. If tools aren't activated automatically, run:

```bash
mise trust
```
