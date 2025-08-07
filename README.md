# Learnicorn - Learning Management System

A modular Learning Management System built with Ruby on Rails 8.0, supporting role-based access control for admins, instructors, and students.

## Features

- **Multi-role Authentication System**: Support for admins, instructors, and students
- **Course Management**: Create, edit, and manage courses with lessons
- **Student Enrollment**: Students can browse and enroll in courses
- **Progress Tracking**: Track lesson completions and student progress
- **Admin Dashboard**: Administrative oversight of users, courses, and enrollments
- **Instructor Tools**: Course creation and student management for instructors
- **Modern Web Technologies**: Built with Turbo, Stimulus, and modern Rails practices

## Technology Stack

- **Ruby**: 3.3.3
- **Rails**: 8.0.2
- **Database**: PostgreSQL
- **Frontend**: Turbo
- **CSS**: Modern CSS with Propshaft asset pipeline
- **Testing**: Minitest 

## Getting Started

### Prerequisites

- Ruby 3.3.3
- PostgreSQL
- Node.js (for asset compilation)
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd learnicorn
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Setup environment variables**
   ```bash
   cp .env.example .env
   ```
   Edit `.env` with your database credentials and configuration.

4. **Setup the database**
   ```bash
   bin/rails db:create
   bin/rails db:migrate
   bin/rails db:seed
   ```

5. **Start the development server**
   ```bash
   bin/dev
   ```
   
 
The application will be available at `http://localhost:3000`.


## User Roles & Access

### Admin Users
- Full system access
- Manage all users, courses, and enrollments
- System-wide analytics and oversight
- Access via `/admin` namespace

### Instructor Users
- Create and manage their own courses
- Add lessons to their courses
- View enrolled students
- Access via `/instructor` namespace

### Student Users
- Browse and enroll in courses
- Take lessons and track progress
- View personal dashboard with enrolled courses
- Access via `/student` namespace

## Development

### Running Tests
```bash
bin/rails test
```

### Code Quality
```bash
bin/rubocop          # Ruby style checking
bin/brakeman         # Security analysis
```

### Database Operations
```bash
bin/rails db:migrate          # Run migrations
bin/rails db:rollback         # Rollback last migration
bin/rails db:seed             # Seed database
bin/rails db:reset            # Drop, create, migrate, and seed
```



## Project Structure

```
app/
├── controllers/           # Request handling
│   ├── admin/            # Admin namespace controllers
│   ├── instructor/       # Instructor namespace controllers
│   └── student/          # Student namespace controllers
├── models/               # Data models
├── views/                # View templates
├── jobs/                 # Background jobs
└── mailers/              # Email handling

config/
├── routes.rb             # Application routes
├── database.yml          # Database configuration
└── deploy.yml            # Kamal deployment config

db/
├── migrate/              # Database migrations
└── seeds.rb              # Sample data
```


## Environment Variables

Create a `.env` file based on `.env.example`:

## License

This project is licensed under the MIT License - see the LICENSE file for details.
