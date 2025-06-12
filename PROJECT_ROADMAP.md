# TaskFlow Project Roadmap

## Project Overview

**TaskFlow** is a collaborative task management application built with Rails 8 that enables teams to create, organize, and track todos across projects with real-time updates and comprehensive audit trails. The application emphasizes simplicity and performance while providing powerful filtering, search, and collaboration features. Users can seamlessly work together on projects, assign tasks, track progress, and maintain visibility into team productivity through an intuitive interface that works across desktop, mobile, and as a progressive web app.

## Phase 1: Absolute Basics + PWA Foundation

### Milestone 1.1: Rails 8 Application Foundation
**Goal:** Get a working Rails 8 app with PWA infrastructure ready

**Developer Tasks:**
- [ ] Set up new Rails 8 application with PostgreSQL
- [ ] Configure Turbo and Stimulus
- [ ] Set up PWA manifest.json with app icons and metadata
- [ ] Implement basic service worker for caching static assets
- [ ] Create basic layout with responsive navigation
- [ ] Set up Tailwind CSS or chosen styling framework
- [ ] Configure development/production environments
- [ ] Set up basic HTTP caching headers in ApplicationController

### Milestone 1.2: Basic Todo CRUD
**Goal:** Users can create, view, edit, and delete todos

**Developer Tasks:**
- [ ] Generate Todo model with name:string, description:text, completed:boolean
- [ ] Create todos_controller with index, show, new, create, edit, update, destroy
- [ ] Build todo form partial with name and description fields
- [ ] Create todo list view showing all todos
- [ ] Add basic todo item partial with complete/incomplete toggle
- [ ] Implement CSS styling for todo list and forms
- [ ] Add form validations (name presence, length limits)
- [ ] Set up basic database indexes on todos table

### Milestone 1.3: Real-time Toggle & Updates
**Goal:** Todo completion state updates instantly across all browser tabs

**Developer Tasks:**
- [ ] Create Turbo Stream templates for todo updates
- [ ] Add stimulus controller for optimistic UI updates
- [ ] Implement broadcast functionality when todo completion changes
- [ ] Set up Redis for ActionCable in development/production
- [ ] Create todo update stimulus controller for checkbox handling
- [ ] Add Turbo Stream responses to todos#update action
- [ ] Test real-time updates across multiple browser tabs
- [ ] Handle edge cases for failed updates (rollback optimistic changes)

### Milestone 1.4: Performance & Caching
**Goal:** Fast page loads with proper caching strategy

**Developer Tasks:**
- [ ] Implement Russian Doll caching for todo list
- [ ] Add cache_key methods to Todo model
- [ ] Set up fragment caching in todo list view
- [ ] Configure ETags and Last-Modified headers for todo pages
- [ ] Add database query optimization (N+1 prevention)
- [ ] Implement cache expiration on todo updates
- [ ] Set up cache warming strategies
- [ ] Add performance monitoring gems (bullet, rack-mini-profiler)

## Phase 2: Essential Todo Features

### Milestone 2.1: Soft Delete & Trash
**Goal:** Users can delete todos safely and recover them

**Developer Tasks:**
- [ ] Add deleted_at:datetime column to todos table
- [ ] Implement soft delete scope methods (active, deleted)
- [ ] Create trash controller and views
- [ ] Update todos controller to use soft delete
- [ ] Build trash emptying functionality with 30-day auto-delete
- [ ] Add background job for automatic trash cleanup
- [ ] Update all existing queries to exclude soft-deleted todos
- [ ] Add restore functionality in trash view

### Milestone 2.2: Priority & Basic Filtering
**Goal:** Users can prioritize todos and filter their list

**Developer Tasks:**
- [ ] Add priority:integer column to todos table (0=normal, 1=high)
- [ ] Update todo forms to include priority selection
- [ ] Add priority indicator styling in todo list
- [ ] Create filter stimulus controller for client-side filtering
- [ ] Implement URL-based filtering (completed, priority, etc.)
- [ ] Add filter UI components (checkboxes, radio buttons)
- [ ] Update todo list caching to handle filtered views
- [ ] Add priority-based sorting options

### Milestone 2.3: Markdown & Sorting
**Goal:** Rich text descriptions and organized todo lists

**Developer Tasks:**
- [ ] Add markdown gem (redcarpet or kramdown)
- [ ] Create markdown helper for rendering descriptions
- [ ] Update todo description display to render markdown
- [ ] Add markdown toolbar/preview to description textarea
- [ ] Implement sorting by creation date, priority, completion
- [ ] Create sort stimulus controller for dynamic sorting
- [ ] Add sorting UI controls to todo list header
- [ ] Update caching strategy to handle sorted views

## Phase 3: Organization & Search

### Milestone 3.1: Projects Foundation
**Goal:** Basic project creation and todo organization

**Developer Tasks:**
- [ ] Generate Project model with name:string, description:text
- [ ] Add project_id:references to todos table
- [ ] Create projects controller with basic CRUD
- [ ] Build project list and detail views
- [ ] Add project selection to todo forms
- [ ] Update todo list to show project context
- [ ] Implement project-based filtering
- [ ] Add project todo count displays

### Milestone 3.2: Search Functionality
**Goal:** Full-text search across todos and projects

**Developer Tasks:**
- [ ] Set up pg_search gem for PostgreSQL full-text search
- [ ] Add search scopes to Todo and Project models
- [ ] Create search controller and results view
- [ ] Build search form with autocomplete
- [ ] Implement search highlighting in results
- [ ] Add search indexing for performance
- [ ] Create search stimulus controller for instant search
- [ ] Handle search state in URL parameters

### Milestone 3.3: Advanced Filtering & History
**Goal:** Powerful filtering and completion tracking

**Developer Tasks:**
- [ ] Build advanced filter form (date ranges, multiple projects)
- [ ] Implement date-based filtering with date pickers
- [ ] Create completion logbook view showing recently completed todos
- [ ] Add completed_at timestamp tracking
- [ ] Build filter persistence using localStorage
- [ ] Create filter reset functionality
- [ ] Add bulk operations UI (select multiple todos)
- [ ] Implement export functionality for filtered lists

## Phase 4: Users & Collaboration

### Milestone 4.1: User Authentication
**Goal:** Secure user accounts and data isolation

**Developer Tasks:**
- [ ] Set up Devise gem for authentication
- [ ] Generate User model with basic profile fields
- [ ] Add user_id to todos and projects tables
- [ ] Implement user scoping for all queries
- [ ] Create user registration and login flows
- [ ] Add user profile management
- [ ] Update all controllers to require authentication
- [ ] Add user-specific caching strategies

### Milestone 4.2: Team Collaboration
**Goal:** Multiple users can work on shared projects

**Developer Tasks:**
- [ ] Create ProjectMembership join model (user, project, role)
- [ ] Implement project invitation system
- [ ] Add assignee_id:references to todos table
- [ ] Build team member selection in todo forms
- [ ] Create project team management interface
- [ ] Add role-based permissions (owner, member)
- [ ] Implement activity feeds for shared projects
- [ ] Update real-time updates for team members

### Milestone 4.3: Comments & Audit Trail
**Goal:** Rich collaboration with full change tracking

**Developer Tasks:**
- [ ] Generate Comment model (todo, user, content, created_at)
- [ ] Create commenting interface on todo detail pages
- [ ] Implement audit trail using paper_trail gem
- [ ] Build change history view for todos
- [ ] Add real-time comment updates
- [ ] Create notification system for mentions
- [ ] Build activity timeline for projects
- [ ] Add comment markdown support and notifications

---

**Note:** Each milestone represents roughly 1-2 weeks of focused development work and can be assigned to individual developers or small teams.