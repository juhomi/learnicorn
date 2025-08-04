# Find the Ruby course
ruby_course = Course.where(title: 'Complete Ruby Programming Mastery').last

if ruby_course.nil?
  puts "❌ Ruby course not found!"
  exit
end

puts "📋 Creating assignments for Ruby course lessons..."

# Assignment data for each lesson
assignment_data = {
  1 => {
    title: "Ruby Syntax & Fundamentals Quiz",
    description: "Test your understanding of Ruby basics, syntax, and fundamental concepts",
    assignment_type: "quiz",
    max_score: 100,
    published: true,
    questions: [
      {
        question_type: "multiple_choice",
        question_text: "Which method is used to output text to the console in Ruby?",
        points: 10,
        correct_answer: "1",
        options: { choices: ["print", "puts", "echo", "console.log"] }
      },
      {
        question_type: "true_false", 
        question_text: "Ruby is a statically typed programming language.",
        points: 10,
        correct_answer: "0"
      },
      {
        question_type: "multiple_choice",
        question_text: "Who created the Ruby programming language?",
        points: 15,
        correct_answer: "2",
        options: { choices: ["Guido van Rossum", "James Gosling", "Yukihiro Matsumoto", "Brendan Eich"] }
      },
      {
        question_type: "coding",
        question_text: "Write a Ruby program that outputs 'Hello, Ruby!' to the console.",
        points: 25,
        correct_answer: "puts, Hello, Ruby"
      },
      {
        question_type: "multiple_choice",
        question_text: "What does MINASWAN stand for in Ruby community?",
        points: 15,
        correct_answer: "0",
        options: { choices: ["Matz is Nice and So We Are Nice", "Make It Nice and Simple With A Name", "Modular Integrated Nice Apps With Awesome Names", "Modern Internet Nice Apps With Active Networks"] }
      },
      {
        question_type: "essay",
        question_text: "Explain three key principles of Ruby philosophy and why they make Ruby developer-friendly.",
        points: 25
      }
    ]
  },

  2 => {
    title: "Variables & Data Types Assessment", 
    description: "Assess your knowledge of Ruby variables, data types, and operators",
    assignment_type: "mixed",
    max_score: 100,
    published: true,
    questions: [
      {
        question_type: "multiple_choice",
        question_text: "Which of the following is the correct way to create a string with interpolation in Ruby?",
        points: 15,
        correct_answer: "1",
        options: { choices: ["'Hello \#{name}'", '"Hello \#{name}"', "'Hello ' + name", "All of the above"] }
      },
      {
        question_type: "true_false",
        question_text: "In Ruby, variables must be declared with a specific type before use.",
        points: 10,
        correct_answer: "0"
      },
      {
        question_type: "coding",
        question_text: "Create variables for: name (string), age (integer), height (float), and is_student (boolean). Then print each variable.",
        points: 25,
        correct_answer: "name, age, height, is_student, puts, print"
      },
      {
        question_type: "multiple_choice", 
        question_text: "What is the difference between symbols and strings in Ruby?",
        points: 20,
        correct_answer: "2",
        options: { choices: ["No difference", "Symbols are faster but immutable", "Symbols are immutable and memory efficient", "Strings are better for identifiers"] }
      },
      {
        question_type: "coding",
        question_text: "Write code to create a hash with keys :name, :age, and :city, then access the :name value.",
        points: 20,
        correct_answer: "hash, name, age, city, symbol, colon"
      },
      {
        question_type: "essay",
        question_text: "Compare arrays and hashes in Ruby. When would you use each?",
        points: 10
      }
    ]
  },

  3 => { 
    title: "Control Flow & Loops Mastery",
    description: "Master Ruby's control structures, conditional statements, and iteration methods",
    assignment_type: "coding",
    max_score: 100,
    published: true,
    questions: [
      {
        question_type: "coding",
        question_text: "Write an if/elsif/else statement that assigns letter grades based on numeric scores (90+ = A, 80-89 = B, 70-79 = C, below 70 = F).",
        points: 25,
        correct_answer: "if, elsif, else, score, grade, 90, 80, 70"
      },
      {
        question_type: "multiple_choice",
        question_text: "Which Ruby method is preferred for iterating over arrays?",
        points: 15,
        correct_answer: "1",
        options: { choices: ["for loop", "each method", "while loop", "until loop"] }
      },
      {
        question_type: "coding", 
        question_text: "Use the times method to print numbers 1 through 5.",
        points: 20,
        correct_answer: "5.times, puts, times, block"
      },
      {
        question_type: "true_false",
        question_text: "The 'unless' keyword executes code when the condition is false.",
        points: 10,
        correct_answer: "1"
      },
      {
        question_type: "coding",
        question_text: "Write a case/when statement that takes a day name and returns 'Weekday' or 'Weekend'.",
        points: 30,
        correct_answer: "case, when, day, weekday, weekend, monday, saturday, sunday"
      }
    ]
  },

  4 => {
    title: "Methods & Blocks Proficiency", 
    description: "Demonstrate understanding of Ruby methods, blocks, procs, and lambdas",
    assignment_type: "coding",
    max_score: 100,
    published: true,
    questions: [
      {
        question_type: "coding",
        question_text: "Define a method called 'greet' that takes a name parameter with a default value of 'World' and returns a greeting message.",
        points: 20,
        correct_answer: "def, greet, name, World, default, parameter"
      },
      {
        question_type: "multiple_choice",
        question_text: "What happens when a Ruby method doesn't have an explicit return statement?",
        points: 15,
        correct_answer: "2", 
        options: { choices: ["It returns nil", "It causes an error", "It returns the last evaluated expression", "It returns false"] }
      },
      {
        question_type: "coding",
        question_text: "Create a method that accepts variable arguments (*args) and returns the sum of all numbers passed to it.",
        points: 25,
        correct_answer: "def, *args, sum, each, total, reduce"
      },
      {
        question_type: "true_false",
        question_text: "Blocks in Ruby can be passed to methods using curly braces { } or do...end syntax.",
        points: 10,
        correct_answer: "1"
      },
      {
        question_type: "coding",
        question_text: "Use the map method with a block to create a new array containing the squares of [1, 2, 3, 4, 5].",
        points: 30,
        correct_answer: "map, block, square, each, multiply, **"
      }
    ]
  },

  5 => {
    title: "Arrays & Hashes Expertise",
    description: "Master Ruby's collection types and their powerful methods",
    assignment_type: "mixed",
    max_score: 100, 
    published: true,
    questions: [
      {
        question_type: "coding",
        question_text: "Create an array of fruits and use the select method to find all fruits that contain the letter 'a'.",
        points: 25,
        correct_answer: "array, fruits, select, include, contain, letter"
      },
      {
        question_type: "multiple_choice",
        question_text: "Which method would you use to transform all elements in an array?",
        points: 15,
        correct_answer: "1",
        options: { choices: ["each", "map", "select", "find"] }
      },
      {
        question_type: "coding",
        question_text: "Create a hash representing a person with name, age, and city. Then add a new key 'occupation' and print all key-value pairs.",
        points: 30,
        correct_answer: "hash, person, name, age, city, occupation, each, key, value"
      },
      {
        question_type: "true_false", 
        question_text: "Ruby arrays can contain elements of different data types.",
        points: 10,
        correct_answer: "1"
      },
      {
        question_type: "coding",
        question_text: "Use the reduce method to find the product of all numbers in the array [2, 3, 4, 5].",
        points: 20,
        correct_answer: "reduce, product, multiply, inject, *"
      }
    ]
  }
}

# Create assignments for lessons 1-5
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

puts "\n🎉 Ruby course assignments created successfully!"
puts "📈 Summary:"
puts "- Course: #{ruby_course.title}"
puts "- Total lessons with assignments: #{ruby_course.lessons.joins(:assignments).distinct.count}"
puts "- Total assignments: #{ruby_course.lessons.joins(:assignments).count}"
puts "- Total questions: #{ruby_course.lessons.joins(assignments: :assignment_questions).count}"