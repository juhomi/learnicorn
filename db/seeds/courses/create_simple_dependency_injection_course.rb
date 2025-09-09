# Simple Dependency Injection Course Seed File
# Focused, practical course with clean Ruby examples

# Find or create instructor user
instructor = User.where(role: 'instructor').first
if instructor.nil?
  instructor = User.create!(
    email: 'di.instructor@example.com',
    password: 'password123',
    password_confirmation: 'password123',
    role: 'instructor',
    name: 'Alex Johnson'
  )
end

# Delete existing course with same title if it exists
Course.where(title: 'Mastering Dependency Injection: From Theory to Practice').destroy_all

# Create the course
di_course = Course.create!(
  title: 'Mastering Dependency Injection: From Theory to Practice',
  description: 'A focused, practical course that teaches dependency injection through real Ruby code examples. Learn the fundamentals, see the problems DI solves, and master implementation.',
  duration: 6,
  instructor: instructor,
  published: true
)

puts "✅ Created DI course: #{di_course.title}"

# Create lessons
lessons_data = [
  {
    title: 'Understanding Dependency Injection: Theory and Examples',
    content: 'Complete introduction to dependency injection with real-world examples.',
    position: 1
  },
  {
    title: 'Ruby Code: Problems Without DI vs Solutions With DI',
    content: 'Detailed Ruby examples showing before and after DI implementation.',
    position: 2
  },
  {
    title: 'Advanced Concepts: IoC, Design Patterns, and Best Practices',
    content: 'Deep dive into advanced DI concepts and production practices.',
    position: 3
  }
]

created_lessons = []
lessons_data.each do |lesson_data|
  lesson = di_course.lessons.create!(lesson_data)
  created_lessons << lesson
  puts "✅ Created lesson #{lesson.position}: #{lesson.title}"
end

# Lesson 1 content
lesson1 = created_lessons[0]
lesson1.content_blocks.create!([
  {
    block_type: "text",
    content: %{
      <h1>Understanding Dependency Injection</h1>
      <p>Dependency Injection (DI) is a fundamental design pattern where objects receive their dependencies from external sources rather than creating them internally.</p>
      
      <h2>What is a Dependency?</h2>
      <p>A dependency is something your code needs to function properly:</p>
      <ul>
        <li>🚗 <strong>Car depends on:</strong> Engine, wheels, fuel system</li>
        <li>📱 <strong>Smartphone depends on:</strong> Battery, screen, processor</li>
        <li>💻 <strong>Software depends on:</strong> Databases, APIs, services</li>
      </ul>
      
      <h2>Car Manufacturing Example</h2>
      <p>Traditional approach: Each assembly worker builds their own engine, makes their own tires, creates their own electronics.</p>
      <p><strong>Problems:</strong></p>
      <ul>
        <li>⏱️ Extremely slow - 90% making parts, 10% assembling</li>
        <li>💰 Expensive - duplicate equipment for each worker</li>
        <li>🔧 Inconsistent quality - each worker's parts differ</li>
        <li>🧪 Cannot test assembly separate from part creation</li>
      </ul>
      
      <p>Modern approach: Specialized suppliers provide parts, workers focus on assembly.</p>
      <p><strong>Benefits:</strong></p>
      <ul>
        <li>⚡ Fast and efficient - each specialist focuses on expertise</li>
        <li>💰 Cost effective - shared resources, bulk production</li>
        <li>🎯 Consistent quality - specialized teams perfect components</li>
        <li>🧪 Easy testing - can test assembly with different engine types</li>
      </ul>
    },
    position: 1
  },
  {
    block_type: "text", 
    content: %{
      <h2>Restaurant System Example</h2>
      <p>Imagine a restaurant where each waiter must:</p>
      
      <h3>❌ Without DI (Problems)</h3>
      <ul>
        <li>Create their own menu with prices</li>
        <li>Set up their own payment system</li>
        <li>Build their own kitchen communication</li>
        <li>Manage their own inventory tracking</li>
      </ul>
      <p><strong>Result:</strong> Inconsistent pricing, duplicate systems, training nightmare</p>
      
      <h3>✅ With DI (Solution)</h3>
      <ul>
        <li>Restaurant provides shared menu system</li>
        <li>Central payment processing for all waiters</li>
        <li>Unified kitchen communication system</li>
        <li>Common inventory management</li>
      </ul>
      <p><strong>Result:</strong> Consistent experience, cost-effective, easy training</p>
      
      <h2>Key Benefits of DI</h2>
      <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem; margin: 1rem 0;">
        <div style="padding: 1rem; background-color: #e8f5e8; border-radius: 8px;">
          <h4>🧪 Testability</h4>
          <p>Replace real services with mock objects for testing</p>
        </div>
        <div style="padding: 1rem; background-color: #fff3e0; border-radius: 8px;">
          <h4>🔄 Flexibility</h4>
          <p>Switch implementations without changing client code</p>
        </div>
        <div style="padding: 1rem; background-color: #f3e5f5; border-radius: 8px;">
          <h4>🛠 Maintainability</h4>
          <p>Changes to dependencies don't affect clients</p>
        </div>
        <div style="padding: 1rem; background-color: #e1f5fe; border-radius: 8px;">
          <h4>🎯 Focus</h4>
          <p>Each class focuses on its primary responsibility</p>
        </div>
      </div>
    },
    position: 2
  }
])

# Lesson 2 content - Ruby examples
lesson2 = created_lessons[1]
lesson2.content_blocks.create!([
  {
    block_type: "text",
    content: %{
      <h1>Ruby Code Examples: Before and After DI</h1>
      <p>Let's see dependency injection in action with real Ruby code examples.</p>
      
      <h2>Example 1: Car Manufacturing System</h2>
      <h3>❌ Without Dependency Injection (Bad)</h3>
      <pre><code class="ruby">
# BAD - Tight coupling
class CarManufacturer
  def initialize
    # Creating dependencies internally - the problem!
    @engine_builder = V8Engine.new
    @tire_manufacturer = MichelinTires.new
    @electronics = BasicRadio.new
  end
  
  def build_car(car_type)
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

# Usage - very limited
factory = CarManufacturer.new
sedan = factory.build_car("Sedan")
      </code></pre>
      
      <h3>Problems with the above code:</h3>
      <ul>
        <li>🧪 <strong>Testing nightmare:</strong> Must use real V8Engine, real tires</li>
        <li>🔒 <strong>Vendor lock-in:</strong> Cannot use different engines</li>
        <li>🛠 <strong>Hard maintenance:</strong> Engine changes break CarManufacturer</li>
        <li>⚡ <strong>No flexibility:</strong> Same parts for all car types</li>
      </ul>
    },
    position: 1
  },
  {
    block_type: "text",
    content: %{
      <h3>✅ With Dependency Injection (Good)</h3>
      <pre><code class="ruby">
# GOOD - Dependencies injected
class CarManufacturer
  def initialize(engine_builder:, tire_manufacturer:, electronics:)
    @engine_builder = engine_builder
    @tire_manufacturer = tire_manufacturer
    @electronics = electronics
  end
  
  def build_car(car_type)
    engine = @engine_builder.build_engine
    tires = @tire_manufacturer.create_tires(4)
    radio = @electronics.install_system
    
    Car.new(engine: engine, tires: tires, electronics: radio)
  end
end

# Multiple implementations available
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

class MichelinTires
  def create_tires(count)
    Array.new(count, { brand: "Michelin", type: "Performance" })
  end
end

class BridgestoneTires
  def create_tires(count)
    Array.new(count, { brand: "Bridgestone", type: "Eco" })
  end
end

# Now we can mix and match!
luxury_factory = CarManufacturer.new(
  engine_builder: V8Engine.new,
  tire_manufacturer: MichelinTires.new,
  electronics: PremiumStereo.new
)

eco_factory = CarManufacturer.new(
  engine_builder: ElectricMotor.new,
  tire_manufacturer: BridgestoneTires.new,
  electronics: BasicRadio.new
)
      </code></pre>
    },
    position: 2
  },
  {
    block_type: "text",
    content: %{
      <h2>Example 2: Order Processing System</h2>
      <h3>❌ Without DI - Tightly Coupled</h3>
      <pre><code class="ruby">
class OrderProcessor
  def initialize
    # Hard-coded dependencies!
    @email_service = GmailService.new
    @payment_processor = StripePayment.new
  end
  
  def process_order(order)
    payment_result = @payment_processor.charge(order.total)
    
    if payment_result.success?
      @email_service.send_confirmation(order)
      true
    else
      @email_service.send_failure_notice(order)
      false
    end
  end
end

# Testing problems:
# - Makes real Gmail API calls
# - Charges real credit cards
# - Slow, expensive, unreliable tests
      </code></pre>
      
      <h3>✅ With DI - Flexible and Testable</h3>
      <pre><code class="ruby">
class OrderProcessor
  def initialize(email_service:, payment_processor:)
    @email_service = email_service
    @payment_processor = payment_processor
  end
  
  def process_order(order)
    payment_result = @payment_processor.charge(order.total)
    
    if payment_result.success?
      @email_service.send_confirmation(order)
      true
    else
      @email_service.send_failure_notice(order)
      false
    end
  end
end

# Production usage
production_processor = OrderProcessor.new(
  email_service: GmailService.new,
  payment_processor: StripePayment.new
)

# Test usage with mocks
test_processor = OrderProcessor.new(
  email_service: MockEmailService.new,
  payment_processor: MockPayment.new
)
      </code></pre>
    },
    position: 3
  },
  {
    block_type: "text",
    content: %{
      <h2>Testing Made Easy with DI</h2>
      <pre><code class="ruby">
require 'minitest/autorun'

class OrderProcessorTest < Minitest::Test
  def setup
    @mock_email = MockEmailService.new
    @mock_payment = MockPayment.new
    
    @processor = OrderProcessor.new(
      email_service: @mock_email,
      payment_processor: @mock_payment
    )
  end
  
  def test_successful_order
    order = create_test_order
    @mock_payment.set_success(true)
    
    result = @processor.process_order(order)
    
    assert result
    assert_equal 1, @mock_email.sent_emails.count
    assert_includes @mock_email.sent_emails.first[:subject], "Confirmed"
  end
  
  def test_failed_payment
    order = create_test_order
    @mock_payment.set_success(false)
    
    result = @processor.process_order(order)
    
    refute result
    assert_includes @mock_email.sent_emails.first[:subject], "Failed"
  end
end

# Mock implementations for testing
class MockEmailService
  attr_reader :sent_emails
  
  def initialize
    @sent_emails = []
  end
  
  def send_confirmation(order)
    @sent_emails << { to: order.email, subject: "Order Confirmed" }
  end
  
  def send_failure_notice(order)
    @sent_emails << { to: order.email, subject: "Payment Failed" }
  end
end

class MockPayment
  def initialize
    @success = true
  end
  
  def set_success(success)
    @success = success
  end
  
  def charge(amount)
    OpenStruct.new(success?: @success)
  end
end
      </code></pre>
    },
    position: 4
  }
])

# Lesson 3 content - Advanced concepts
lesson3 = created_lessons[2]
lesson3.content_blocks.create!([
  {
    block_type: "text",
    content: %{
      <h1>Advanced DI Concepts</h1>
      
      <h2>Inversion of Control (IoC)</h2>
      <p><strong>Definition:</strong> A principle where control of object creation is inverted from the object itself to an external entity.</p>
      
      <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin: 2rem 0;">
        <div style="padding: 1.5rem; background-color: #ffebee; border-radius: 8px;">
          <h4>❌ Traditional Control</h4>
          <p>"I'll handle everything myself"</p>
          <ul>
            <li>Object creates its dependencies</li>
            <li>Object controls lifecycle</li>
            <li>Object manages initialization</li>
          </ul>
        </div>
        <div style="padding: 1.5rem; background-color: #e8f5e8; border-radius: 8px;">
          <h4>✅ Inverted Control</h4>
          <p>"Someone else provides what I need"</p>
          <ul>
            <li>External entity creates dependencies</li>
            <li>External entity manages lifecycle</li>
            <li>External entity handles initialization</li>
          </ul>
        </div>
      </div>
      
      <h2>SOLID Principles and DI</h2>
      <h3>1. Single Responsibility Principle (SRP)</h3>
      <p>With DI, each class has one reason to change.</p>
      <pre><code class="ruby">
class OrderService
  def initialize(email_service:, payment_processor:)
    @email_service = email_service
    @payment_processor = payment_processor
  end
  
  def process_order(order)
    # ONLY responsible for order processing logic
    # NOT responsible for email or payment implementation
    if @payment_processor.charge(order.amount)
      @email_service.send_confirmation(order)
    end
  end
end
      </code></pre>
    },
    position: 1
  },
  {
    block_type: "text",
    content: %{
      <h3>2. Dependency Inversion Principle (DIP)</h3>
      <p>High-level modules should not depend on low-level modules. Both should depend on abstractions.</p>
      
      <pre><code class="ruby">
# BAD - High-level depends on low-level
class OrderService
  def initialize
    @database = MySQLDatabase.new  # Direct dependency on implementation
  end
  
  def create_order(order_data)
    @database.execute_sql("INSERT INTO orders...")  # Coupled to SQL
  end
end

# GOOD - Both depend on abstraction
class OrderService
  def initialize(order_repository:)  # Depends on abstraction
    @order_repository = order_repository
  end
  
  def create_order(order_data)
    @order_repository.save(order_data)  # Abstract interface
  end
end

# Abstraction
class OrderRepository
  def save(order_data)
    raise NotImplementedError
  end
end

# Implementations depend on abstraction
class MySQLOrderRepository < OrderRepository
  def save(order_data)
    # MySQL-specific implementation
  end
end

class PostgreSQLOrderRepository < OrderRepository
  def save(order_data)
    # PostgreSQL-specific implementation
  end
end
      </code></pre>
    },
    position: 2
  },
  {
    block_type: "text",
    content: %{
      <h2>DI Patterns</h2>
      
      <h3>1. Constructor Injection (Most Common)</h3>
      <pre><code class="ruby">
class OrderService
  def initialize(payment_service:, email_service:)
    @payment_service = payment_service
    @email_service = email_service
  end
end
      </code></pre>
      
      <h3>2. Setter Injection</h3>
      <pre><code class="ruby">
class OrderService
  attr_writer :payment_service, :email_service
  
  def process_order(order)
    @payment_service&.charge(order.amount)
  end
end
      </code></pre>
      
      <h3>3. Method Injection</h3>
      <pre><code class="ruby">
class OrderService
  def process_order(order, payment_service:, email_service:)
    payment_service.charge(order.amount)
    email_service.send_confirmation(order)
  end
end
      </code></pre>
      
      <h2>Simple DI Container</h2>
      <pre><code class="ruby">
class DIContainer
  def initialize
    @services = {}
  end
  
  def register(name, &block)
    @services[name] = block
  end
  
  def resolve(name)
    @services[name]&.call(self)
  end
end

# Usage
container = DIContainer.new

container.register(:email_service) { GmailService.new }
container.register(:payment_service) { StripePayment.new }

container.register(:order_service) do |c|
  OrderService.new(
    email_service: c.resolve(:email_service),
    payment_service: c.resolve(:payment_service)
  )
end

order_service = container.resolve(:order_service)
      </code></pre>
    },
    position: 3
  },
  {
    block_type: "text",
    content: %{
      <h2>Production Best Practices</h2>
      
      <h3>1. Configuration-Based DI</h3>
      <pre><code class="ruby">
# config/services.yml
production:
  email_service: SendGridService
  payment_service: StripePayment
  
development:
  email_service: MailHogService
  payment_service: MockPayment
  
test:
  email_service: MockEmailService
  payment_service: MockPayment

# Service factory
class ServiceContainer
  def self.email_service
    @email_service ||= case Rails.env
    when 'production'
      SendGridService.new
    when 'development'
      MailHogService.new
    else
      MockEmailService.new
    end
  end
  
  def self.order_service
    @order_service ||= OrderService.new(
      email_service: email_service,
      payment_service: payment_service
    )
  end
end
      </code></pre>
      
      <h3>2. Health Monitoring</h3>
      <pre><code class="ruby">
class HealthCheckService
  def initialize(dependencies:)
    @dependencies = dependencies
  end
  
  def check_health
    results = {}
    
    @dependencies.each do |name, service|
      results[name] = check_service_health(service)
    end
    
    {
      status: all_healthy?(results) ? 'healthy' : 'unhealthy',
      services: results
    }
  end
  
  private
  
  def check_service_health(service)
    service.respond_to?(:health_check) ? service.health_check : { status: 'unknown' }
  rescue => e
    { status: 'error', message: e.message }
  end
end
      </code></pre>
    },
    position: 4
  }
])

# Create assignment - assignments belong to lessons, not courses
assignment = created_lessons.last.assignments.create!(
  title: "Dependency Injection Mastery Test",
  assignment_type: "quiz",
  published: true,
  max_score: 100
)

# Create questions
questions = [
  {
    question_text: "What is the core principle of Dependency Injection?",
    question_type: "multiple_choice",
    points: 10,
    correct_answer: "1",
    options: {
      choices: [
        "Objects create all dependencies internally",
        "Objects receive dependencies from external sources",
        "Objects use global variables for dependencies",
        "Objects hardcode all dependency references"
      ]
    }
  },
  {
    question_text: "In the car manufacturing example, what happens when each worker builds their own engine?",
    question_type: "multiple_choice",
    points: 10,
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
    question_text: "Which code correctly shows dependency injection?",
    question_type: "multiple_choice",
    points: 15,
    correct_answer: "1",
    options: {
      choices: [
        "def initialize; @service = PaymentService.new; end",
        "def initialize(payment_service:); @service = payment_service; end",
        "def initialize; @service = nil; end",
        "PAYMENT_SERVICE = PaymentService.new"
      ]
    }
  },
  {
    question_text: "What is Inversion of Control?",
    question_type: "multiple_choice",
    points: 15,
    correct_answer: "1",
    options: {
      choices: [
        "A way to control program execution flow",
        "A principle where object creation control moves to external entities",
        "A method to reverse string values",
        "A technique for error handling"
      ]
    }
  },
  {
    question_text: "How does DI improve testing?",
    question_type: "multiple_choice",
    points: 15,
    correct_answer: "1",
    options: {
      choices: [
        "Tests become slower but more thorough",
        "You can replace dependencies with fast, controlled mock objects",
        "Testing becomes unnecessary",
        "Test coverage automatically increases"
      ]
    }
  },
  {
    question_text: "Which SOLID principle is most directly supported by DI?",
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
    question_text: "What problem does tight coupling create?",
    question_type: "multiple_choice",
    points: 10,
    correct_answer: "1",
    options: {
      choices: [
        "Code runs faster",
        "Changes in one component require changes in dependent components",
        "Memory usage decreases",
        "Security improves"
      ]
    }
  },
  {
    question_text: "True or False: With DI, you can test OrderService without real payment calls.",
    question_type: "true_false",
    points: 5,
    correct_answer: "1",
    options: {}
  },
  {
    question_text: "True or False: DI makes code more complex and harder to understand.",
    question_type: "true_false",
    points: 5,
    correct_answer: "0",
    options: {}
  }
]

questions.each_with_index do |q_data, index|
  assignment.assignment_questions.create!(q_data)
  puts "✅ Created question #{index + 1}"
end

puts "\n🎉 Successfully created Dependency Injection course!"
puts "Course: #{di_course.title}"
puts "Lessons: #{di_course.lessons.count}"
puts "Assignment: #{assignment.assignment_questions.count} questions"
puts "Duration: #{di_course.duration} hours"