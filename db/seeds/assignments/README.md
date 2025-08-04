# Assignment & Content Seed Scripts

This directory contains scripts for setting up course content and assignments.

## Quick Start

Run the unified setup script:
```bash
ruby db/seeds/assignments/setup_ruby_course.rb
```

## Individual Scripts

### Course Setup
- `create_ruby_course.rb` - Create the Ruby course structure
- `verify_ruby_course.rb` - Verify course exists

### Content Creation  
- `create_ruby_content.rb` - Add lesson content blocks
- `create_ruby_content_fixed.rb` - Fixed version of content creation
- `add_content_simple.rb` - Add simple content to lessons
- `add_content_6_10.rb` - Add content to lessons 6-10
- `create_remaining_content.rb` - Create remaining lesson content
- `fix_remaining_content.rb` - Fix content issues

### Assignment Creation
- `create_ruby_assignments.rb` - Create assignments for lessons 1-5
- `create_ruby_assignments_6_10.rb` - Create assignments for lessons 6-10  
- `create_test_assignment.rb` - Create test assignments

### Debugging & Health Checks
- `assignment_health_check.rb` - Check assignment data integrity
- `debug_exact_assignment.rb` - Debug specific assignment issues

## Usage Notes

- All scripts assume Rails environment is loaded
- Scripts are idempotent where possible
- Run health check after major changes
- Scripts create/update course: "Complete Ruby Programming Mastery"