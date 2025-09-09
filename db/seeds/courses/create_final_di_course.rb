# Final Clean Dependency Injection Course
# Simple version that avoids syntax issues

# Find or create instructor user
instructor = User.where(role: 'instructor').first
if instructor.nil?
  instructor = User.create!(
    email: 'final.di.instructor@example.com',
    password: 'password123',
    password_confirmation: 'password123',
    role: 'instructor',
    name: 'Dr. Sarah Chen'
  )
end

# Create the new course
final_di_course = Course.create!(
  title: 'Complete Dependency Injection Guide: Theory to Production',
  description: 'Master dependency injection from fundamental concepts to production implementation. Learn through practical Ruby examples, understand design principles, and implement professional DI patterns.',
  duration: 8,
  instructor: instructor,
  published: true
)

puts "✅ Created clean DI course: #{final_di_course.title}"

# Create lessons
lessons_data = [
  {
    title: 'Dependency Injection Fundamentals and Real-World Examples',
    content: 'Complete introduction to DI concepts with practical analogies.',
    position: 1
  },
  {
    title: 'Ruby Implementation: From Problems to Solutions',
    content: 'Comprehensive Ruby examples showing DI transformation.',
    position: 2
  },
  {
    title: 'Professional DI: Design Patterns and Production Practices',
    content: 'Advanced concepts and enterprise implementation.',
    position: 3
  }
]

created_lessons = []
lessons_data.each do |lesson_data|
  lesson = final_di_course.lessons.create!(lesson_data)
  created_lessons << lesson
  puts "✅ Created lesson #{lesson.position}: #{lesson.title}"
end

# LESSON 1: Fundamentals
lesson1 = created_lessons[0]

# Content Block 1
lesson1.content_blocks.create!(
  block_type: "text",
  content: %{
    <h1>Dependency Injection Fundamentals</h1>
    <p>Dependency Injection (DI) is one of the most important design patterns in software development. This lesson teaches you what it is, why it matters, and how it transforms software design.</p>
    
    <div style="background-color: #e3f2fd; padding: 1.5rem; border-left: 4px solid #2196f3; margin: 1rem 0;">
      <h3>🎯 Learning Objectives</h3>
      <ul>
        <li>Understand what dependencies are and why they matter</li>
        <li>Learn the core principles of dependency injection</li>
        <li>See real-world examples through manufacturing systems</li>
        <li>Identify problems that DI solves in software development</li>
      </ul>
    </div>
    
    <h2>What is a Dependency?</h2>
    <p>A dependency is something your code needs to function properly.</p>
    
    <div style="background-color: #f5f5f5; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
      <h3>📋 Definition</h3>
      <p><strong>A dependency is an object, service, or resource that your class needs to perform its function.</strong></p>
    </div>
    
    <h3>Examples of Dependencies:</h3>
    <ul>
      <li>🍝 <strong>To make pasta:</strong> You depend on noodles, sauce, and water</li>
      <li>🚗 <strong>To build a car:</strong> You depend on an engine, wheels, and electronics</li>
      <li>💻 <strong>In software:</strong> Your class depends on other classes, databases, or APIs</li>
    </ul>
  },
  position: 1
)

# Content Block 2
lesson1.content_blocks.create!(
  block_type: "text",
  content: %{
    <h2>🚗 Car Manufacturing Example</h2>
    <p>Let's understand dependencies through car manufacturing:</p>
    
    <h3>Traditional Approach (Problems)</h3>
    <div style="background-color: #ffebee; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
      <h4>❌ Each Worker Does Everything</h4>
      <p>Imagine if each car assembly worker had to:</p>
      <ul>
        <li>Build their own engine from raw materials</li>
        <li>Manufacture their own tires from rubber</li>
        <li>Create their own electronics from chips</li>
        <li>Mix their own paint from pigments</li>
      </ul>
      
      <h4>Problems:</h4>
      <ul>
        <li>⏱️ <strong>Extremely slow:</strong> 90% time making parts, 10% assembling</li>
        <li>💰 <strong>Expensive:</strong> Duplicate equipment for each worker</li>
        <li>🔧 <strong>Inconsistent quality:</strong> Each worker's parts differ</li>
        <li>🧪 <strong>Hard to test:</strong> Must build real engines to test assembly</li>
      </ul>
    </div>
    
    <h3>Modern Approach (Solution)</h3>
    <div style="background-color: #e8f5e8; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
      <h4>✅ Specialized Dependencies</h4>
      <p>In modern manufacturing:</p>
      <ul>
        <li>Engine specialists build engines in dedicated facilities</li>
        <li>Tire specialists manufacture optimized tires</li>
        <li>Electronics teams create control systems</li>
        <li>Assembly workers focus only on putting pieces together</li>
      </ul>
      
      <h4>Benefits:</h4>
      <ul>
        <li>⚡ <strong>Fast:</strong> Each specialist focuses on their expertise</li>
        <li>💰 <strong>Cost effective:</strong> Shared resources, bulk production</li>
        <li>🎯 <strong>Consistent:</strong> Specialized teams perfect their components</li>
        <li>🧪 <strong>Testable:</strong> Can test assembly with different engines</li>
      </ul>
    </div>
  },
  position: 2
)

# Content Block 3
lesson1.content_blocks.create!(
  block_type: "text",
  content: %{
    <h2>📋 Formal Definition of Dependency Injection</h2>
    <div style="background-color: #e3f2fd; padding: 2rem; border-left: 5px solid #2196f3; margin: 2rem 0;">
      <h3>🎯 Dependency Injection is:</h3>
      <p><strong>A design pattern where objects receive their dependencies from external sources rather than creating them internally.</strong></p>
      
      <h4>Key Components:</h4>
      <ul>
        <li><strong>Client:</strong> The object that needs dependencies</li>
        <li><strong>Service:</strong> The dependency that provides functionality</li>
        <li><strong>Injector:</strong> The system that provides services to clients</li>
      </ul>
    </div>
    
    <h2>🎯 Core Benefits</h2>
    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 1rem; margin: 2rem 0;">
      <div style="padding: 1rem; background-color: #e8f5e8; border-radius: 8px;">
        <h4>🧪 Testability</h4>
        <p>Replace real dependencies with mock objects for fast, reliable testing</p>
      </div>
      <div style="padding: 1rem; background-color: #fff3e0; border-radius: 8px;">
        <h4>🔄 Flexibility</h4>
        <p>Switch implementations without changing client code</p>
      </div>
      <div style="padding: 1rem; background-color: #f3e5f5; border-radius: 8px;">
        <h4>🛠 Maintainability</h4>
        <p>Changes to dependencies don't affect client classes</p>
      </div>
      <div style="padding: 1rem; background-color: #e1f5fe; border-radius: 8px;">
        <h4>🎯 Focus</h4>
        <p>Each class focuses on its primary responsibility</p>
      </div>
    </div>
  },
  position: 3
)

# LESSON 2: Ruby Implementation
lesson2 = created_lessons[1]

# Content Block 1
lesson2.content_blocks.create!(
  block_type: "text",
  content: %{
    <h1>Ruby Implementation: From Problems to Solutions</h1>
    <p>Now let's see dependency injection in action through Ruby code. We'll examine real examples and understand how DI solves practical problems.</p>
    
    <div style="background-color: #e3f2fd; padding: 1.5rem; border-left: 4px solid #2196f3; margin: 1rem 0;">
      <h3>🎯 What You'll Master</h3>
      <ul>
        <li>Identify tight coupling problems in Ruby code</li>
        <li>Transform code using dependency injection</li>
        <li>Implement testing strategies with mock objects</li>
        <li>Apply DI patterns in business scenarios</li>
      </ul>
    </div>
  },
  position: 1
)

# Content Block 2
lesson2.content_blocks.create!(
  block_type: "text",
  content: %{
    <h2>🚗 Example: Car Manufacturing System</h2>
    
    <h3>❌ The Problem: Tightly Coupled Code</h3>
    <pre><code class="ruby">
# BAD EXAMPLE - Tight Coupling
class CarManufacturer
  def initialize
    # Creating dependencies internally - the problem!
    @engine_builder = V8Engine.new
    @tire_manufacturer = MichelinTires.new  
    @electronics = BasicRadio.new
  end
  
  def build_car(car_type)
    puts "Building car..."
    
    engine = @engine_builder.build_engine
    tires = @tire_manufacturer.create_tires(4)
    radio = @electronics.install_system
    
    Car.new(engine: engine, tires: tires, electronics: radio)
  end
end

class V8Engine
  def build_engine
    { type: "V8", horsepower: 400 }
  end
end

# Usage - very limited!
factory = CarManufacturer.new
sedan = factory.build_car("Sedan")
    </code></pre>
    
    <div style="background-color: #ffebee; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
      <h4>🚨 Problems with This Code:</h4>
      <ul>
        <li><strong>🧪 Testing Nightmare:</strong> Must use real V8Engine, real tires</li>
        <li><strong>🔒 Vendor Lock-in:</strong> Cannot use different engines</li>
        <li><strong>🛠 Hard Maintenance:</strong> Engine changes break CarManufacturer</li>
        <li><strong>⚡ No Flexibility:</strong> All cars get identical parts</li>
      </ul>
    </div>
  },
  position: 2
)

# Content Block 3
lesson2.content_blocks.create!(
  block_type: "text",
  content: %{
    <h3>✅ The Solution: Dependency Injection</h3>
    <pre><code class="ruby">
# GOOD EXAMPLE - Dependency Injection
class CarManufacturer
  def initialize(engine_builder:, tire_manufacturer:, electronics:)
    # Dependencies provided from outside!
    @engine_builder = engine_builder
    @tire_manufacturer = tire_manufacturer
    @electronics = electronics
  end
  
  def build_car(car_type)
    puts "Building car..."
    
    # Same business logic - but now flexible!
    engine = @engine_builder.build_engine
    tires = @tire_manufacturer.create_tires(4)
    radio = @electronics.install_system
    
    Car.new(engine: engine, tires: tires, electronics: radio)
  end
end

# Multiple implementations possible
class V8Engine
  def build_engine
    { type: "V8", horsepower: 400 }
  end
end

class ElectricMotor
  def build_engine
    { type: "Electric", horsepower: 500 }
  end
end

# Create different configurations!
luxury_factory = CarManufacturer.new(
  engine_builder: V8Engine.new,
  tire_manufacturer: MichelinTires.new,
  electronics: PremiumStereo.new
)

eco_factory = CarManufacturer.new(
  engine_builder: ElectricMotor.new,
  tire_manufacturer: EcoTires.new,
  electronics: BasicRadio.new
)
    </code></pre>
    
    <div style="background-color: #e8f5e8; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
      <h4>✅ Benefits:</h4>
      <ul>
        <li>Easy to test with mock objects</li>
        <li>Can create multiple car variants</li>
        <li>Dependencies can evolve independently</li>
        <li>Business logic stays unchanged</li>
      </ul>
    </div>
  },
  position: 3
)

# Content Block 4
lesson2.content_blocks.create!(
  block_type: "text",
  content: %{
    <h2>🧪 Testing Transformation</h2>
    <p>The real power of DI shines in testing:</p>
    
    <h3>❌ Testing Without DI</h3>
    <pre><code class="ruby">
def test_car_build
  factory = CarManufacturer.new
  car = factory.build_car("Test Car")
  
  # Problems:
  # - Uses real V8Engine (slow)
  # - Uses real tire manufacturing (external dependencies)
  # - Cannot control test scenarios
  # - Hard to verify specific behaviors
end
    </code></pre>
    
    <h3>✅ Testing With DI</h3>
    <pre><code class="ruby">
def test_car_build
  # Create controlled mock objects
  mock_engine = MockEngine.new
  mock_tires = MockTires.new
  mock_electronics = MockElectronics.new
  
  factory = CarManufacturer.new(
    engine_builder: mock_engine,
    tire_manufacturer: mock_tires,
    electronics: mock_electronics
  )
  
  car = factory.build_car("Test Car")
  
  # Verify behavior
  assert mock_engine.build_called
  assert_equal 4, mock_tires.tire_count
  assert car.present?
end

# Mock implementations
class MockEngine
  attr_reader :build_called
  
  def initialize
    @build_called = false
  end
  
  def build_engine
    @build_called = true
    { type: "Mock", horsepower: 100 }
  end
end
    </code></pre>
    
    <div style="background-color: #e8f5e8; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
      <h4>Testing Benefits:</h4>
      <ul>
        <li>⚡ Tests run in milliseconds</li>
        <li>🔄 100% reliable - no external dependencies</li>
        <li>🧪 Easy to test all scenarios</li>
        <li>💰 Free to run thousands of times</li>
      </ul>
    </div>
  },
  position: 4
)

# LESSON 3: Professional Implementation
lesson3 = created_lessons[2]

# Content Block 1
lesson3.content_blocks.create!(
  block_type: "text",
  content: %{
    <h1>Professional DI: Design Patterns and Production</h1>
    <p>Now let's understand the deeper principles and professional techniques that make DI enterprise-ready.</p>
    
    <div style="background-color: #e3f2fd; padding: 1.5rem; border-left: 4px solid #2196f3; margin: 1rem 0;">
      <h3>🎯 Professional Mastery</h3>
      <ul>
        <li>Understand theoretical foundations (IoC, SOLID principles)</li>
        <li>Master professional DI patterns</li>
        <li>Implement production-grade containers</li>
        <li>Apply enterprise best practices</li>
      </ul>
    </div>
    
    <h2>🔄 Inversion of Control (IoC)</h2>
    <p>IoC is the theoretical foundation that makes DI possible.</p>
    
    <h3>Traditional Control vs. Inverted Control</h3>
    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin: 2rem 0;">
      <div style="padding: 1.5rem; background-color: #ffebee; border-radius: 8px;">
        <h4>❌ Traditional ("Pull" Model)</h4>
        <pre><code class="ruby">
class OrderService
  def initialize
    # I control what I need
    @database = Database.new
    @email = EmailService.new
  end
end
        </code></pre>
        <p>Object creates and controls its dependencies</p>
      </div>
      
      <div style="padding: 1.5rem; background-color: #e8f5e8; border-radius: 8px;">
        <h4>✅ Inverted ("Push" Model)</h4>
        <pre><code class="ruby">
class OrderService
  def initialize(database:, email:)
    # Someone else provides what I need
    @database = database
    @email = email
  end
end
        </code></pre>
        <p>External entity provides dependencies</p>
      </div>
    </div>
  },
  position: 1
)

# Content Block 2  
lesson3.content_blocks.create!(
  block_type: "text",
  content: %{
    <h2>🏗️ SOLID Principles and DI</h2>
    
    <h3>S - Single Responsibility Principle</h3>
    <div style="background-color: #e8f5e8; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
      <h4>Principle: A class should have only one reason to change</h4>
      
      <pre><code class="ruby">
# BAD - Multiple responsibilities
class OrderProcessor
  def initialize
    @database = Database.new
    @email = EmailService.new
  end
  
  def process_order(order)
    # Validation logic
    validate_order(order)
    
    # Database logic  
    @database.save(order)
    
    # Email formatting and sending
    email_body = format_email(order)
    @email.send(email_body)
  end
end

# GOOD - Single responsibility with DI
class OrderProcessor
  def initialize(validator:, repository:, email_service:)
    @validator = validator
    @repository = repository
    @email_service = email_service
  end
  
  def process_order(order)
    # ONLY orchestrates - doesn't do everything
    @validator.validate!(order)
    @repository.save(order)
    @email_service.send_confirmation(order)
  end
end
      </code></pre>
    </div>
    
    <h3>D - Dependency Inversion Principle</h3>
    <div style="background-color: #fce4ec; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
      <h4>High-level modules shouldn't depend on low-level modules</h4>
      
      <pre><code class="ruby">
# BAD - Direct dependency on concrete class
class OrderService
  def initialize
    @database = MySQLDatabase.new  # Coupled to MySQL
  end
end

# GOOD - Depends on abstraction
class OrderService
  def initialize(repository:)
    @repository = repository  # Any repository implementation
  end
end

# Abstract interface
class OrderRepository
  def save(order)
    raise NotImplementedError
  end
end

# Concrete implementations
class MySQLOrderRepository < OrderRepository
  def save(order)
    # MySQL implementation
  end
end

class PostgreSQLOrderRepository < OrderRepository
  def save(order) 
    # PostgreSQL implementation
  end
end
      </code></pre>
    </div>
  },
  position: 2
)

# Content Block 3
lesson3.content_blocks.create!(
  block_type: "text",
  content: %{
    <h2>📦 Professional DI Container</h2>
    
    <pre><code class="ruby">
class ProductionDIContainer
  def initialize
    @services = {}
    @instances = {} # For singletons
  end
  
  def register(name, scope: :transient, &factory)
    @services[name] = { factory: factory, scope: scope }
  end
  
  def singleton(name, &factory)
    register(name, scope: :singleton, &factory)
  end
  
  def resolve(name)
    config = @services[name]
    raise "Service not registered: " + name.to_s unless config
    
    case config[:scope]
    when :singleton
      @instances[name] ||= config[:factory].call(self)
    when :transient
      config[:factory].call(self)
    end
  end
  
  def health_check
    results = {}
    @services.each do |name, _config|
      begin
        service = resolve(name)
        if service.respond_to?(:health_check)
          results[name] = service.health_check
        else
          results[name] = { status: 'ok' }
        end
      rescue => e
        results[name] = { status: 'error', message: e.message }
      end
    end
    
    { overall: results.all? { |_, r| r[:status] == 'ok' }, services: results }
  end
end

# Configuration
container = ProductionDIContainer.new

# Register services
container.singleton(:database) do
  case Rails.env
  when 'production'
    PostgreSQLDatabase.new(ENV['DATABASE_URL'])
  when 'test'
    InMemoryDatabase.new
  else
    PostgreSQLDatabase.new('dev_db')
  end
end

container.register(:order_service) do |c|
  OrderService.new(
    repository: c.resolve(:order_repository),
    email_service: c.resolve(:email_service)
  )
end

# Usage in Rails controllers
class OrdersController < ApplicationController
  def create
    service = container.resolve(:order_service)
    result = service.process(order_params)
    
    if result.success?
      render json: { success: true }
    else
      render json: { error: result.message }
    end
  end
end
    </code></pre>
  },
  position: 3
)

# Content Block 4
lesson3.content_blocks.create!(
  block_type: "text",
  content: %{
    <h2>🎯 Production Best Practices</h2>
    
    <div style="background-color: #e3f2fd; padding: 2rem; border-left: 5px solid #2196f3; margin: 2rem 0;">
      <h3>✅ Professional Implementation Checklist</h3>
      
      <h4>🏗️ Architecture</h4>
      <ul>
        <li>All dependencies injected via constructor</li>
        <li>Abstractions define service contracts</li>
        <li>Each class has single responsibility</li>
        <li>High-level modules independent of low-level details</li>
      </ul>
      
      <h4>🔧 Implementation</h4>
      <ul>
        <li>DI container with singleton and transient scopes</li>
        <li>Configuration-driven service selection</li>
        <li>Health checks for external dependencies</li>
        <li>Graceful error handling and fallbacks</li>
      </ul>
      
      <h4>🧪 Testing</h4>
      <ul>
        <li>Mock implementations for all external services</li>
        <li>Test-specific container configuration</li>
        <li>Unit tests test business logic in isolation</li>
        <li>Integration tests verify real service interactions</li>
      </ul>
      
      <h4>📊 Operations</h4>
      <ul>
        <li>Service resolution metrics and monitoring</li>
        <li>Performance optimization with caching</li>
        <li>Structured logging for debugging</li>
        <li>Health endpoints for infrastructure monitoring</li>
      </ul>
    </div>
    
    <h2>🚀 Key Takeaways</h2>
    <div style="background-color: #f1f8e9; padding: 1.5rem; border-radius: 8px; margin: 2rem 0;">
      <p><strong>You now understand:</strong></p>
      <ul>
        <li>Why DI solves real, expensive problems in software development</li>
        <li>How to implement DI patterns professionally in Ruby</li>
        <li>The theoretical foundations (IoC, SOLID) that make DI powerful</li>
        <li>Production techniques for enterprise-level systems</li>
      </ul>
      <p><strong>Next steps:</strong> Practice refactoring existing code to use DI, build your own container, and apply these patterns in real projects!</p>
    </div>
  },
  position: 4
)

# Create assignment
assignment = created_lessons.last.assignments.create!(
  title: "Dependency Injection Mastery Assessment",
  assignment_type: "quiz",
  published: true,
  max_score: 100
)

# Create questions
questions_data = [
  {
    question_text: "What is the core principle of Dependency Injection?",
    question_type: "multiple_choice",
    points: 15,
    correct_answer: "1",
    options: {
      choices: [
        "Objects create dependencies internally for control",
        "Objects receive dependencies from external sources rather than creating them internally",
        "Objects use global variables for dependencies",
        "Objects hardcode all dependency references"
      ]
    }
  },
  {
    question_text: "In the car manufacturing analogy, what problem occurs when each worker builds their own engine?",
    question_type: "multiple_choice",
    points: 15,
    correct_answer: "2",
    options: {
      choices: [
        "Production becomes more efficient",
        "Quality improves across all cars",
        "Time is wasted, costs increase, and quality becomes inconsistent",
        "Workers become more specialized"
      ]
    }
  },
  {
    question_text: "Which Ruby code demonstrates proper constructor injection?",
    question_type: "multiple_choice", 
    points: 15,
    correct_answer: "1",
    options: {
      choices: [
        "def initialize; @service = PaymentService.new; end",
        "def initialize(payment_service:); @service = payment_service; end",
        "def payment_service; @service ||= PaymentService.new; end",
        "PAYMENT_SERVICE = PaymentService.new"
      ]
    }
  },
  {
    question_text: "What is Inversion of Control (IoC)?",
    question_type: "multiple_choice",
    points: 15,
    correct_answer: "1",
    options: {
      choices: [
        "A way to control program execution flow",
        "A principle where control of object creation moves to external entities",
        "A method for reversing string values",
        "A technique for error handling"
      ]
    }
  },
  {
    question_text: "How does DI improve testing in the CarManufacturer example?",
    question_type: "multiple_choice",
    points: 15,
    correct_answer: "1", 
    options: {
      choices: [
        "Tests become slower but more thorough",
        "You can inject mock objects making tests fast and reliable",
        "Testing becomes unnecessary",
        "Tests automatically generate themselves"
      ]
    }
  },
  {
    question_text: "Which SOLID principle is most directly implemented by DI?",
    question_type: "multiple_choice",
    points: 10,
    correct_answer: "3",
    options: {
      choices: [
        "Single Responsibility Principle",
        "Open/Closed Principle",
        "Liskov Substitution Principle",
        "Dependency Inversion Principle"
      ]
    }
  },
  {
    question_text: "What is the main advantage of a DI container?",
    question_type: "multiple_choice", 
    points: 10,
    correct_answer: "1",
    options: {
      choices: [
        "Makes applications run faster",
        "Automates dependency wiring and lifecycle management",
        "Eliminates the need for testing",
        "Automatically fixes bugs"
      ]
    }
  },
  {
    question_text: "True or False: With DI, you can test OrderService without real database calls or emails.",
    question_type: "true_false",
    points: 5,
    correct_answer: "1",
    options: {}
  }
]

questions_data.each_with_index do |question_data, index|
  assignment.assignment_questions.create!(question_data)
  puts "✅ Created question #{index + 1}"
end

puts "\n🎉 Successfully created clean Dependency Injection course!"
puts "Course: #{final_di_course.title}"
puts "Lessons: #{final_di_course.lessons.count}"
puts "Content blocks: #{final_di_course.lessons.sum { |l| l.content_blocks.count }}"
puts "Assignment: #{assignment.assignment_questions.count} questions"
puts "Duration: #{final_di_course.duration} hours"
puts "\nThis is a completely new, clean course with no repetitions!"