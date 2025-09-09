# Find or create instructor user
instructor = User.where(role: 'instructor').first
if instructor.nil?
  instructor = User.create!(
    email: 'di.instructor@example.com',
    password: 'password123',
    password_confirmation: 'password123',
    role: 'instructor',
    first_name: 'David',
    last_name: 'Johnson'
  )
end

# Create Dependency Injection Course
di_course = Course.create!(
  title: 'Mastering Dependency Injection',
  description: 'Learn dependency injection through real-world examples, practical Ruby code, and design patterns. Understand IoC containers and build maintainable, testable applications.',
  duration: 8, # 8 hours total course duration
  instructor: instructor,
  published: true
)

puts "✅ Created DI course: #{di_course.title}"
puts "Course ID: #{di_course.id}"

# Create lessons for Dependency Injection course
lessons_data = [
  {
    title: 'Introduction to Dependency Injection',
    content: 'Welcome to the world of Dependency Injection - a fundamental design principle for building maintainable software.',
    position: 1
  },
  {
    title: 'Real-World Examples of Dependency Injection', 
    content: 'Understanding DI through everyday analogies: coffee shops and car manufacturing.',
    position: 2
  },
  {
    title: 'From Real World to Code: Making the Connection',
    content: 'Bridging the gap between real-world analogies and software development.',
    position: 3
  },
  {
    title: 'Why Dependency Injection is Essential',
    content: 'Understanding the compelling reasons to use dependency injection in modern software development.',
    position: 4
  },
  {
    title: 'Ruby Without Dependency Injection: The Problems',
    content: 'Real Ruby code without DI and the problems it creates.',
    position: 5
  },
  {
    title: 'Ruby With Dependency Injection: The Solution',
    content: 'Refactoring Ruby code to use dependency injection and solving the problems.',
    position: 6
  },
  {
    title: 'Another Ruby Example: Logger System',
    content: 'Exploring dependency injection with a logger system example.',
    position: 7
  },
  {
    title: 'Design Patterns and Inversion of Control',
    content: 'Understanding the broader context of DI within software design patterns.',
    position: 8
  }
]

created_lessons = []
lessons_data.each do |lesson_data|
  lesson = di_course.lessons.create!(lesson_data)
  created_lessons << lesson
  puts "✅ Created lesson #{lesson.position}: #{lesson.title}"
end

# Add content blocks to lessons
puts "\n📝 Adding content blocks..."

# Lesson 1: Introduction content blocks
lesson1 = created_lessons[0]
lesson1.content_blocks.create!([
  {
    block_type: "text",
    content: "<h2>What is Dependency Injection?</h2><p>Dependency Injection (DI) is a design pattern that allows objects to receive their dependencies from external sources rather than creating them internally.</p><h3>Key Concepts:</h3><ul><li><strong>Dependency:</strong> An object that another object needs to function</li><li><strong>Injection:</strong> The process of providing these dependencies from outside</li><li><strong>Inversion of Control:</strong> The principle of reversing the control of object creation</li></ul>",
    position: 1
  },
  {
    block_type: "image",
    file_url: "https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?w=800&h=400&fit=crop",
    alt_text: "Abstract representation of interconnected systems",
    position: 2
  }
])

# Lesson 2: Real-world examples content blocks  
lesson2 = created_lessons[1]
lesson2.content_blocks.create!([
  {
    block_type: "text",
    content: "<h2>Real-World Example 1: Coffee Shop ☕</h2><p>Imagine you're building a coffee shop system. Without DI: barista creates own equipment (tightly coupled). With DI: coffee shop provides equipment to baristas (flexible).</p>",
    position: 1
  },
  {
    block_type: "image", 
    file_url: "https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?w=800&h=500&fit=crop",
    alt_text: "Modern coffee shop with barista making coffee",
    position: 2
  },
  {
    block_type: "text",
    content: "<h2>Real-World Example 2: Car Manufacturing 🚗</h2><p>Car assembly lines are perfect examples of DI. Instead of each car model creating its own components, the assembly line injects components into car frames.</p>",
    position: 3
  },
  {
    block_type: "image",
    file_url: "https://images.unsplash.com/photo-1563720360172-67b8f3dce741?w=800&h=500&fit=crop", 
    alt_text: "Modern car assembly line with robotic systems",
    position: 4
  }
])

# Lesson 3: Transition content blocks
lesson3 = created_lessons[2]
lesson3.content_blocks.create!([
  {
    block_type: "text",
    content: "<h2>Coffee Shop → Software Classes</h2><p>Real-world concepts translate directly to software:</p><ul><li>Barista → OrderProcessor class</li><li>Coffee Machine → PaymentService class</li><li>Coffee Shop Manager → IoC Container</li></ul>",
    position: 1
  }
])

# Lesson 4: Why DI is essential
lesson4 = created_lessons[3] 
lesson4.content_blocks.create!([
  {
    block_type: "text",
    content: "<h2>The Core Problems DI Solves</h2><h3>🧪 Testability Crisis</h3><p>Hard-coded dependencies make unit testing nearly impossible.</p><h3>🔒 Tight Coupling Trap</h3><p>Classes are locked to specific implementations.</p><h3>🔧 Maintenance Nightmare</h3><p>Changes to dependencies require modifying all dependent classes.</p>",
    position: 1
  }
])

# Lesson 5: Ruby without DI - add code examples
lesson5 = created_lessons[4]
lesson5.content_blocks.create!([
  {
    block_type: "text",
    content: "<h2>E-commerce Order System Without DI</h2><p>Let's see the problems created by hard-coded dependencies:</p>",
    position: 1
  },
  {
    block_type: "text",
    content: "<h3>Payment Service</h3><pre><code class='language-ruby'>class StripePaymentService\n  def charge(amount, card_token)\n    # Real Stripe API call\n    puts \"Charged $\#{amount} via Stripe\"\n    { success: true, transaction_id: \"stripe_\#{rand(10000)}\" }\n  end\nend</code></pre>",
    position: 2
  },
  {
    block_type: "text", 
    content: "<h3>Order Processor (Without DI)</h3><pre><code class='language-ruby'>class OrderProcessor\n  def initialize\n    # ⚠️ PROBLEM: Hard-coded dependencies\n    @payment_service = StripePaymentService.new\n    @email_service = SendgridEmailService.new\n  end\n  \n  def process_order(order_data)\n    payment_result = @payment_service.charge(order_data[:total], order_data[:card_token])\n    # More processing...\n  end\nend</code></pre>",
    position: 3
  },
  {
    block_type: "text",
    content: "<h2>🚨 The Problems</h2><ul><li>Untestable without real Stripe charges</li><li>Vendor lock-in to Stripe</li><li>Same config for all environments</li><li>Multiple responsibilities</li></ul>",
    position: 4
  }
])

# Lesson 6: Ruby with DI - solution
lesson6 = created_lessons[5]
lesson6.content_blocks.create!([
  {
    block_type: "text",
    content: "<h2>Refactoring to Use Dependency Injection</h2>",
    position: 1
  },
  {
    block_type: "text",
    content: "<h3>Refactored OrderProcessor with DI</h3><pre><code class='language-ruby'>class OrderProcessor\n  def initialize(payment_service:, email_service:)\n    # ✅ SOLUTION: Dependencies injected via constructor\n    @payment_service = payment_service\n    @email_service = email_service\n  end\n  \n  def process_order(order_data)\n    # Same business logic, but using injected dependencies\n    payment_result = @payment_service.charge(order_data[:total], order_data[:card_token])\n    # More processing...\n  end\nend</code></pre>",
    position: 2
  },
  {
    block_type: "text",
    content: "<h3>Mock Services for Testing</h3><pre><code class='language-ruby'>class MockPaymentService\n  def initialize(should_succeed: true)\n    @should_succeed = should_succeed\n  end\n  \n  def charge(amount, card_token)\n    if @should_succeed\n      { success: true, transaction_id: \"mock_\#{rand(10000)}\" }\n    else\n      { success: false, error: \"Mock payment failure\" }\n    end\n  end\nend</code></pre>",
    position: 3
  },
  {
    block_type: "text",
    content: "<h2>✅ Problems Solved!</h2><ul><li>Fully testable with mocks</li><li>Any payment/email service works</li><li>Different configs per environment</li><li>Single responsibility maintained</li></ul>",
    position: 4
  }
])

# Lesson 7: Another Ruby example
lesson7 = created_lessons[6]
lesson7.content_blocks.create!([
  {
    block_type: "text", 
    content: "<h2>Logger System Example</h2><p>Data processing application with flexible logging.</p>",
    position: 1
  },
  {
    block_type: "text",
    content: "<h3>Without DI (Bad)</h3><pre><code class='language-ruby'>class DataProcessor\n  def initialize\n    # Hard-coded dependencies\n    @logger = FileLogger.new('/var/log/app.log')\n    @db_client = PostgresClient.new\n  end\nend</code></pre><p>Problems: Real files in tests, slow I/O, inflexible environments</p>",
    position: 2
  },
  {
    block_type: "text",
    content: "<h3>With DI (Good)</h3><pre><code class='language-ruby'>class DataProcessor\n  def initialize(logger:, db_client:)\n    @logger = logger\n    @db_client = db_client\n  end\nend\n\n# Different loggers for different needs:\n# ConsoleLogger for development\n# MemoryLogger for testing  \n# JsonLogger for production</code></pre>",
    position: 3
  }
])

# Lesson 8: Design patterns and IoC
lesson8 = created_lessons[7]
lesson8.content_blocks.create!([
  {
    block_type: "text",
    content: "<h2>Design Patterns and Dependency Injection</h2><p>DI is part of a family of design patterns that promote flexible, maintainable code.</p>",
    position: 1
  },
  {
    block_type: "text",
    content: "<h2>🔄 Inversion of Control (IoC)</h2><p>Traditional: Objects control their dependencies</p><p>Inverted: External system provides dependencies</p><p>This simple shift leads to more flexible, testable systems.</p>",
    position: 2
  },
  {
    block_type: "image",
    file_url: "https://images.unsplash.com/photo-1518709268805-4e9042af2176?w=800&h=400&fit=crop",
    alt_text: "Abstract geometric pattern representing design patterns",
    position: 3
  },
  {
    block_type: "text",
    content: "<h2>SOLID Principles and DI</h2><ul><li><strong>Single Responsibility:</strong> Classes focus on core purpose</li><li><strong>Open/Closed:</strong> Open for extension, closed for modification</li><li><strong>Dependency Inversion:</strong> Depend on abstractions, not concretions</li></ul>",
    position: 4
  }
])

puts "✅ Added content blocks to all lessons"

# Create assignment with multiple choice questions  
puts "\n📋 Creating assignment..."

assignment = lesson8.assignments.create!(
  title: "Dependency Injection Mastery Quiz",
  assignment_type: "quiz", 
  published: true,
  max_score: 60
)

# Create questions using the correct format
questions_data = [
  {
    question_text: "What is the primary benefit of Dependency Injection?",
    question_type: "multiple_choice",
    points: 10,
    correct_answer: "2",  # Third option (0-based index)
    options: { 
      choices: [
        "It makes code run faster",
        "It reduces memory usage", 
        "It makes code more testable and flexible by removing hard-coded dependencies",
        "It automatically handles errors"
      ]
    }
  },
  {
    question_text: "In the coffee shop analogy, what does the coffee shop manager represent?",
    question_type: "multiple_choice",
    points: 10,
    correct_answer: "1",  # Second option
    options: {
      choices: [
        "The main business logic class",
        "An IoC container or dependency injection framework",
        "A database connection", 
        "The user interface"
      ]
    }
  },
  {
    question_text: "What does 'Inversion of Control' mean?",
    question_type: "multiple_choice",
    points: 10,
    correct_answer: "1",  # Second option
    options: {
      choices: [
        "Objects create and manage their own dependencies",
        "Control of dependency creation is moved to an external system",
        "The user interface controls all business logic",
        "Errors are handled automatically"
      ]
    }
  },
  {
    question_text: "Which Ruby code demonstrates proper dependency injection?",
    question_type: "multiple_choice",
    points: 10,
    correct_answer: "1",  # Second option
    options: {
      choices: [
        "class Service; def initialize; @logger = FileLogger.new; end; end",
        "class Service; def initialize(logger:); @logger = logger; end; end",
        "class Service; def logger; @logger ||= Logger.new; end; end",
        "class Service; Logger = FileLogger.new; end"
      ]
    }
  },
  {
    question_text: "What is a major testing problem with hard-coded dependencies?",
    question_type: "multiple_choice", 
    points: 10,
    correct_answer: "1",  # Second option
    options: {
      choices: [
        "Tests run too quickly",
        "Tests cannot isolate units and may require real external services",
        "Tests use too much memory",
        "Tests are too easy to write"
      ]
    }
  },
  {
    question_text: "Which SOLID principle is most directly implemented by DI?",
    question_type: "multiple_choice",
    points: 10,
    correct_answer: "3",  # Fourth option
    options: {
      choices: [
        "Single Responsibility Principle",
        "Open/Closed Principle", 
        "Liskov Substitution Principle",
        "Dependency Inversion Principle"
      ]
    }
  }
]

# Create all questions
questions_data.each_with_index do |question_data, index|
  assignment.assignment_questions.create!(question_data)
  puts "✅ Created question #{index + 1}: #{question_data[:question_text][0..50]}..."
end

puts "✅ Created assignment with #{assignment.assignment_questions.count} questions"

puts "\n🎉 Course creation complete!"
puts "Course: #{di_course.title}"
puts "Lessons: #{di_course.lessons.count}"
puts "Assignment: #{assignment.title} with #{assignment.assignment_questions.count} questions"
puts "Total course duration: #{di_course.duration} hours"