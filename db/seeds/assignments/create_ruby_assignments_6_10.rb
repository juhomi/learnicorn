# Find the Ruby course
ruby_course = Course.where(title: 'Complete Ruby Programming Mastery').last

if ruby_course.nil?
  puts "❌ Ruby course not found!"
  exit
end

puts "📋 Creating assignments for Ruby course lessons 6-10..."

# Assignment data for lessons 6-10
assignment_data = {
  6 => {
    title: "Object-Oriented Programming Mastery",
    description: "Demonstrate understanding of classes, objects, inheritance, and OOP principles in Ruby",
    assignment_type: "coding",
    max_score: 120,
    published: true,
    questions: [
      {
        question_type: "coding",
        question_text: "Create a Person class with attributes name and age, including getter and setter methods.",
        points: 25,
        correct_answer: "class, Person, attr, name, age, initialize, def"
      },
      {
        question_type: "multiple_choice",
        question_text: "Which Ruby keyword is used to create inheritance between classes?",
        points: 15,
        correct_answer: "1",
        options: { choices: ["extends", "<", "inherits", "super"] }
      },
      {
        question_type: "coding", 
        question_text: "Create a Vehicle class and a Car class that inherits from Vehicle. Add a method to display vehicle information.",
        points: 35,
        correct_answer: "class, Vehicle, Car, <, inheritance, initialize, super, def"
      },
      {
        question_type: "true_false",
        question_text: "In Ruby, all methods are public by default.",
        points: 10,
        correct_answer: "1"
      },
      {
        question_type: "coding",
        question_text: "Demonstrate method overriding by creating a parent and child class where the child overrides a parent method.",
        points: 35,
        correct_answer: "class, override, parent, child, def, super, method"
      }
    ]
  },

  7 => {
    title: "Modules & Mixins Proficiency",
    description: "Master Ruby modules, namespacing, and mixins for code organization",
    assignment_type: "mixed",
    max_score: 100,
    published: true,
    questions: [
      {
        question_type: "multiple_choice",
        question_text: "What is the primary difference between a class and a module in Ruby?",
        points: 20,
        correct_answer: "2",
        options: { choices: ["No difference", "Modules are faster", "Modules cannot be instantiated", "Classes are better"] }
      },
      {
        question_type: "coding", 
        question_text: "Create a module called Greetings with a method say_hello, then include it in a Person class.",
        points: 30,
        correct_answer: "module, Greetings, say_hello, include, Person, def"
      },
      {
        question_type: "true_false",
        question_text: "Ruby supports multiple inheritance through mixins.",
        points: 15,
        correct_answer: "1"
      },
      {
        question_type: "coding",
        question_text: "Create a namespace module called Animals with classes Dog and Cat inside it.",
        points: 25,
        correct_answer: "module, Animals, class, Dog, Cat, namespace, ::"
      },
      {
        question_type: "essay",
        question_text: "Explain the benefits of using modules over classes for shared functionality.",
        points: 10
      }
    ]
  },

  8 => {
    title: "File I/O & Exception Handling Assessment",
    description: "Handle files and errors gracefully in Ruby applications",
    assignment_type: "coding", 
    max_score: 100,
    published: true,
    questions: [
      {
        question_type: "coding",
        question_text: "Write code to read the contents of a file named 'data.txt' and print each line.",
        points: 25,
        correct_answer: "File.open, read, each_line, puts, file, data.txt"
      },
      {
        question_type: "multiple_choice",
        question_text: "Which block ensures code execution even if an exception occurs?",
        points: 15,
        correct_answer: "3",
        options: { choices: ["rescue", "catch", "finally", "ensure"] }
      },
      {
        question_type: "coding",
        question_text: "Implement error handling using begin/rescue/ensure for file operations.",
        points: 35,
        correct_answer: "begin, rescue, ensure, exception, error, StandardError"
      },
      {
        question_type: "true_false", 
        question_text: "Ruby automatically closes files when the program ends.",
        points: 10,
        correct_answer: "1"
      },
      {
        question_type: "coding",
        question_text: "Write a method that safely writes data to a file with proper error handling.",
        points: 15,
        correct_answer: "def, File.open, write, rescue, ensure, close"
      }
    ]
  },

  9 => {
    title: "Regular Expressions Mastery",
    description: "Master pattern matching and text processing with Ruby regex",
    assignment_type: "mixed",
    max_score: 100,
    published: true,
    questions: [
      {
        question_type: "multiple_choice",
        question_text: "Which operator is used for regex matching in Ruby?",
        points: 15,
        correct_answer: "1", 
        options: { choices: ["==", "=~", "match", "find"] }
      },
      {
        question_type: "coding",
        question_text: "Write a regex pattern to match valid email addresses and test it with a sample email.",
        points: 30,
        correct_answer: "regex, email, @, pattern, match, =~, /.*@.*\\..*/i"
      },
      {
        question_type: "true_false",
        question_text: "Ruby regex patterns are case-sensitive by default.",
        points: 10,
        correct_answer: "1"
      },
      {
        question_type: "coding",
        question_text: "Use regex to extract all phone numbers from a string in the format (xxx) xxx-xxxx.",
        points: 25,
        correct_answer: "regex, phone, \\(\\d{3}\\), scan, match, extract"
      },
      {
        question_type: "coding", 
        question_text: "Replace all occurrences of 'color' with 'colour' in a text using regex.",
        points: 20,
        correct_answer: "gsub, color, colour, regex, replace, /color/i"
      }
    ]
  },

  10 => {
    title: "Gems & Package Management Final Project",
    description: "Understand Ruby gems ecosystem and package management with Bundler",
    assignment_type: "essay",
    max_score: 100,
    published: true,
    questions: [
      {
        question_type: "multiple_choice",
        question_text: "Which file is used to specify gem dependencies in a Ruby project?",
        points: 15,
        correct_answer: "1",
        options: { choices: ["Gemspec", "Gemfile", "gems.rb", "dependencies.txt"] }
      },
      {
        question_type: "coding",
        question_text: "Write the commands to install a gem called 'httparty' and require it in your Ruby script.",
        points: 20,
        correct_answer: "gem install, httparty, require, bundle, add"
      },
      {
        question_type: "true_false",
        question_text: "Bundler helps manage gem dependencies and versions for Ruby projects.",
        points: 10,
        correct_answer: "1"
      },
      {
        question_type: "essay",
        question_text: "Explain the Ruby gems ecosystem. Discuss how to find, install, and manage gems in a project. Include the roles of RubyGems and Bundler.",
        points: 35
      },
      {
        question_type: "coding",
        question_text: "Create a simple Gemfile with dependencies for a web application (include sinatra, json gems with specific versions).",
        points: 20,
        correct_answer: "Gemfile, gem, sinatra, json, version, source, rubygems"
      }
    ]
  }
}

# Create assignments for lessons 6-10
assignment_data.each do |lesson_position, data|
  lesson = ruby_course.lessons.find_by(position: lesson_position)
  
  if lesson
    puts "\n📝 Creating assignment for: #{lesson.title}"
    
    # Create the assignment
    assignment = lesson.assignments.create!(
      title: data[:title],
      description: data[:description], 
      assignment_type: data[:assignment_type],
      max_score: data[:max_score],
      published: data[:published],
      position: 1
    )
    
    puts "  ✅ Created assignment: #{assignment.title}"
    
    # Add questions to the assignment
    data[:questions].each_with_index do |question_data, index|
      question = assignment.assignment_questions.create!(
        question_text: question_data[:question_text],
        question_type: question_data[:question_type],
        points: question_data[:points], 
        correct_answer: question_data[:correct_answer],
        options: question_data[:options] || {},
        position: index + 1
      )
      
      puts "    ✅ Added #{question.question_type} question (#{question.points} pts)"
    end
    
    puts "  📊 Total questions: #{assignment.assignment_questions.count}"
    puts "  🎯 Total points: #{assignment.assignment_questions.sum(:points)}"
    
  else
    puts "❌ Lesson #{lesson_position} not found!"
  end
end

puts "\n🎉 Ruby course assignments 6-10 created successfully!"
puts "📈 Final Summary:"
puts "- Course: #{ruby_course.title}"
puts "- Total lessons with assignments: #{ruby_course.lessons.joins(:assignments).distinct.count}"
puts "- Total assignments: #{ruby_course.lessons.joins(:assignments).count}"
puts "- Total questions: #{ruby_course.lessons.joins(assignments: :assignment_questions).count}"
puts "- Total possible points: #{ruby_course.lessons.joins(assignments: :assignment_questions).sum('assignment_questions.points')}"