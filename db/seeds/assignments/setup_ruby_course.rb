#!/usr/bin/env ruby
# Unified script to set up Ruby course with content and assignments
# Run with: ruby db/seeds/assignments/setup_ruby_course.rb

puts "🚀 Setting up Complete Ruby Programming Course..."

# Load Rails environment
require_relative '../../../config/environment'

def run_script(script_name)
  script_path = File.join(__dir__, script_name)
  if File.exist?(script_path)
    puts "\n📄 Running #{script_name}..."
    begin
      load script_path
      puts "✅ #{script_name} completed successfully"
    rescue => e
      puts "❌ Error in #{script_name}: #{e.message}"
      puts e.backtrace.first(5).join("\n")
    end
  else
    puts "⚠️  Script #{script_name} not found"
  end
end

# Run scripts in order
scripts = [
  'create_ruby_course.rb',         # Create the course structure
  'create_ruby_content.rb',        # Add lesson content
  'add_content_simple.rb',         # Add additional content
  'add_content_6_10.rb',          # Add content for lessons 6-10
  'create_ruby_assignments.rb',    # Create assignments
  'create_ruby_assignments_6_10.rb' # Create assignments for lessons 6-10
]

scripts.each { |script| run_script(script) }

puts "\n🎉 Ruby course setup complete!"

# Health check
puts "\n🔍 Running health check..."
run_script('assignment_health_check.rb')