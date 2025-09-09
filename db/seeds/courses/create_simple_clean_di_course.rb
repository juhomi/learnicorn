# Clean Dependency Injection Course - Simple Version
# A well-organized, comprehensive course with clear content flow

# Find or create instructor user
instructor = User.where(role: 'instructor').first
if instructor.nil?
  instructor = User.create!(
    email: 'clean.di.instructor@example.com',
    password: 'password123',
    password_confirmation: 'password123',
    role: 'instructor',
    name: 'Sarah Chen'
  )
end

# Create the new course with different title
clean_di_course = Course.create!(
  title: 'Complete Dependency Injection Guide: Theory to Production',
  description: 'Master dependency injection from fundamental concepts to production implementation. Learn through practical Ruby examples, understand design principles, and implement professional DI patterns.',
  duration: 8, # 8 hours - comprehensive but focused
  instructor: instructor,
  published: true
)

puts "✅ Created clean DI course: #{clean_di_course.title}"

# Create lessons
lessons_data = [
  {
    title: 'Dependency Injection Fundamentals and Real-World Examples',
    content: 'Complete introduction to DI concepts with car manufacturing and restaurant analogies.',
    position: 1
  },
  {
    title: 'Ruby Implementation: From Problems to Solutions',
    content: 'Comprehensive Ruby examples showing DI transformation and testing strategies.',
    position: 2
  },
  {
    title: 'Professional DI: Design Patterns and Production Practices',
    content: 'Advanced concepts, SOLID principles, IoC containers, and enterprise implementation.',
    position: 3
  }
]

created_lessons = []
lessons_data.each do |lesson_data|
  lesson = clean_di_course.lessons.create!(lesson_data)
  created_lessons << lesson
  puts "✅ Created lesson #{lesson.position}: #{lesson.title}"
end

# LESSON 1: Fundamentals (Keep the good content from original)
lesson1 = created_lessons[0]
lesson1.content_blocks.create!([
  {
    block_type: "text",
    content: <<~HTML
      <h1>Dependency Injection Fundamentals</h1>
      <p>Dependency Injection (DI) is one of the most important design patterns in software development. This lesson teaches you what it is, why it matters, and how it transforms software design through practical examples.</p>
      
      <div style="background-color: #e3f2fd; padding: 1.5rem; border-left: 4px solid #2196f3; margin: 1rem 0;">
        <h3>🎯 Learning Objectives</h3>
        <ul>
          <li>Understand what dependencies are and why they matter</li>
          <li>Learn the core principles of dependency injection</li>
          <li>See real-world examples through manufacturing and business systems</li>
          <li>Identify problems that DI solves in software development</li>
        </ul>
      </div>
      
      <h2>What is a Dependency?</h2>
      <p>A dependency is something your code needs to function properly. Think of dependencies like ingredients in cooking:</p>
      
      <div style="background-color: #f5f5f5; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
        <h3>📋 Definition: Dependency</h3>
        <p><strong>A dependency is an object, service, or resource that your class needs to perform its function.</strong></p>
      </div>
      
      <ul>
        <li>🍝 <strong>To make pasta:</strong> You depend on noodles, sauce, and water</li>
        <li>🚗 <strong>To build a car:</strong> You depend on an engine, wheels, transmission, and electronics</li>
        <li>💻 <strong>In software:</strong> Your class depends on other classes, databases, APIs, or services</li>
      </ul>
    HTML,
    position: 1
  },
  {
    block_type: "text",
    content: <<~HTML
      <h2>🚗 Car Manufacturing: Understanding Dependencies</h2>
      <p>Let's understand dependencies through car manufacturing - an example everyone can relate to:</p>
      
      <h3>Traditional Approach: Each Worker Does Everything</h3>
      <div style="background-color: #ffebee; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
        <h4>❌ The Inefficient Way</h4>
        <p>Imagine if each car assembly worker had to:</p>
        <ul>
          <li><strong>Build their own engine</strong> from raw materials</li>
          <li><strong>Manufacture their own tires</strong> from rubber</li>
          <li><strong>Create their own electronics</strong> from silicon chips</li>
          <li><strong>Mix their own paint</strong> from pigments</li>
        </ul>
        
        <h4>Problems with this approach:</h4>
        <ul>
          <li>⏱️ <strong>Extremely slow:</strong> 90% time making parts, 10% assembling cars</li>
          <li>💰 <strong>Expensive:</strong> Duplicate equipment and materials for each worker</li>
          <li>🔧 <strong>Inconsistent quality:</strong> Each worker's parts perform differently</li>
          <li>🧪 <strong>Impossible to test:</strong> Must build real engines to test assembly process</li>
          <li>📚 <strong>Hard to maintain:</strong> Engine design changes require retraining every worker</li>
        </ul>
      </div>
      
      <h3>Modern Approach: Specialized Dependencies</h3>
      <div style="background-color: #e8f5e8; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
        <h4>✅ The Efficient Way</h4>
        <p>In modern manufacturing:</p>
        <ul>
          <li><strong>Engine specialists</strong> build engines in dedicated facilities</li>
          <li><strong>Tire specialists</strong> manufacture tires optimized for different vehicles</li>
          <li><strong>Electronics teams</strong> create infotainment and control systems</li>
          <li><strong>Assembly workers</strong> focus only on putting pieces together</li>
        </ul>
        
        <h4>Benefits of this approach:</h4>
        <ul>
          <li>⚡ <strong>Fast and efficient:</strong> Each specialist focuses on their expertise</li>
          <li>💰 <strong>Cost effective:</strong> Shared resources, bulk production</li>
          <li>🎯 <strong>Consistent quality:</strong> Specialized teams perfect their components</li>
          <li>🧪 <strong>Easy testing:</strong> Can test assembly with different engine types</li>
          <li>🔄 <strong>Flexibility:</strong> Different car models can use different engines without changing assembly process</li>
        </ul>
      </div>
    HTML,
    position: 2
  },
  {
    block_type: "text",
    content: <<~HTML
      <h2>🔗 Connecting to Software Development</h2>
      <p>These real-world principles directly apply to software architecture:</p>
      
      <table style="width: 100%; border-collapse: collapse; margin: 2rem 0;">
        <thead>
          <tr style="background-color: #f5f5f5;">
            <th style="padding: 1rem; border: 1px solid #ddd; text-align: left;">Real World</th>
            <th style="padding: 1rem; border: 1px solid #ddd; text-align: left;">Software Equivalent</th>
            <th style="padding: 1rem; border: 1px solid #ddd; text-align: left;">Purpose</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td style="padding: 1rem; border: 1px solid #ddd;">Assembly Worker</td>
            <td style="padding: 1rem; border: 1px solid #ddd;">Ruby Class/Controller</td>
            <td style="padding: 1rem; border: 1px solid #ddd;">Coordinates main functionality</td>
          </tr>
          <tr style="background-color: #f9f9f9;">
            <td style="padding: 1rem; border: 1px solid #ddd;">Engine Supplier</td>
            <td style="padding: 1rem; border: 1px solid #ddd;">Service Class</td>
            <td style="padding: 1rem; border: 1px solid #ddd;">Provides specific business logic</td>
          </tr>
          <tr>
            <td style="padding: 1rem; border: 1px solid #ddd;">Parts Warehouse</td>
            <td style="padding: 1rem; border: 1px solid #ddd;">Database/Repository</td>
            <td style="padding: 1rem; border: 1px solid #ddd;">Stores and retrieves data</td>
          </tr>
          <tr style="background-color: #f9f9f9;">
            <td style="padding: 1rem; border: 1px solid #ddd;">Quality Control</td>
            <td style="padding: 1rem; border: 1px solid #ddd;">Validation Service</td>
            <td style="padding: 1rem; border: 1px solid #ddd;">Ensures data integrity</td>
          </tr>
        </tbody>
      </table>
      
      <h2>📋 Formal Definition</h2>
      <div style="background-color: #e3f2fd; padding: 2rem; border-left: 5px solid #2196f3; margin: 2rem 0;">
        <h3>🎯 Dependency Injection is:</h3>
        <p><strong>A design pattern where objects receive their dependencies from external sources rather than creating them internally.</strong></p>
        
        <h4>Key Components:</h4>
        <ul>
          <li><strong>Client:</strong> The object that needs dependencies (assembly worker, waiter)</li>
          <li><strong>Service:</strong> The dependency that provides functionality (engine, payment system)</li>
          <li><strong>Injector:</strong> The system that provides services to clients (factory manager, restaurant owner)</li>
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
    HTML,
    position: 3
  }
])

# LESSON 2: Ruby Implementation (Clean, comprehensive version without complex interpolations)
lesson2 = created_lessons[1] 
lesson2.content_blocks.create!([
  {
    block_type: "text",
    content: <<~HTML
      <h1>Ruby Implementation: From Problems to Solutions</h1>
      <p>Now let's see dependency injection in action through Ruby code. We'll examine real examples, understand the problems that tight coupling creates, and see how DI provides elegant solutions.</p>
      
      <div style="background-color: #e3f2fd; padding: 1.5rem; border-left: 4px solid #2196f3; margin: 1rem 0;">
        <h3>🎯 What You'll Master</h3>
        <ul>
          <li>Identify tight coupling problems in Ruby code</li>
          <li>Transform tightly coupled code using dependency injection</li>
          <li>Implement testing strategies with mock objects</li>
          <li>Apply DI patterns in real business scenarios</li>
        </ul>
      </div>
    HTML,
    position: 1
  },
  {
    block_type: "text",
    content: <<~HTML
      <h2>🚗 Example 1: Car Manufacturing System</h2>
      
      <h3>❌ The Problem: Tightly Coupled Code</h3>
      <p>Here's how most developers initially write code - with dependencies hard-coded inside:</p>
      
      <pre><code class="ruby">
# BAD EXAMPLE - Tight Coupling
class CarManufacturer
  def initialize
    # Creating dependencies internally - this is the root problem!
    @engine_builder = V8Engine.new
    @tire_manufacturer = MichelinTires.new  
    @electronics = BasicRadio.new
    @quality_checker = BasicInspection.new
  end
  
  def build_car(car_type)
    puts "Building " + car_type + "..."
    
    engine = @engine_builder.build_engine
    tires = @tire_manufacturer.create_tires(4)
    radio = @electronics.install_system
    
    @quality_checker.inspect_car(engine, tires, radio)
    Car.new(engine: engine, tires: tires, electronics: radio)
  end
end

class V8Engine
  def build_engine
    puts "Building V8 engine with 400HP"
    { type: "V8", horsepower: 400 }
  end
end

class MichelinTires
  def create_tires(count)
    puts "Creating " + count.to_s + " Michelin performance tires"
    Array.new(count, { brand: "Michelin", type: "Performance" })
  end
end

# Usage - very limited!
factory = CarManufacturer.new
sedan = factory.build_car("Sedan")
      </code></pre>
      
      <div style="background-color: #ffebee; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
        <h4>🚨 Critical Problems with This Code:</h4>
        <ul>
          <li><strong>🧪 Testing Nightmare:</strong> Every test must use real V8Engine, real MichelinTires - slow, expensive, unreliable</li>
          <li><strong>🔒 Vendor Lock-in:</strong> Cannot use different engines without modifying CarManufacturer class</li>
          <li><strong>🛠 Maintenance Hell:</strong> If V8Engine constructor changes, CarManufacturer breaks</li>
          <li><strong>⚡ No Flexibility:</strong> All cars get identical parts regardless of requirements</li>
          <li><strong>🎯 Mixed Responsibilities:</strong> CarManufacturer must know about engine internals</li>
        </ul>
      </div>
    HTML,
    position: 2
  },
  {
    block_type: "text",
    content: <<~HTML
      <h3>✅ The Solution: Dependency Injection</h3>
      <p>Here's the same functionality transformed with dependency injection:</p>
      
      <pre><code class="ruby">
# GOOD EXAMPLE - Dependency Injection
class CarManufacturer
  def initialize(engine_builder:, tire_manufacturer:, electronics:, quality_checker:)
    # Dependencies are provided from outside - the key transformation!
    @engine_builder = engine_builder
    @tire_manufacturer = tire_manufacturer
    @electronics = electronics
    @quality_checker = quality_checker
  end
  
  def build_car(car_type)
    puts "Building " + car_type + "..."
    
    # Same business logic - but now flexible!
    engine = @engine_builder.build_engine
    tires = @tire_manufacturer.create_tires(4)
    radio = @electronics.install_system
    
    @quality_checker.inspect_car(engine, tires, radio)
    Car.new(engine: engine, tires: tires, electronics: radio)
  end
end

# Multiple implementations now possible
class V8Engine
  def build_engine
    { type: "V8", horsepower: 400 }
  end
end

class ElectricMotor
  def build_engine
    { type: "Electric", horsepower: 500, torque: "instant" }
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

# Now we can create different car configurations!
luxury_factory = CarManufacturer.new(
  engine_builder: V8Engine.new,
  tire_manufacturer: MichelinTires.new,
  electronics: PremiumStereo.new,
  quality_checker: PremiumInspection.new
)

eco_factory = CarManufacturer.new(
  engine_builder: ElectricMotor.new,
  tire_manufacturer: BridgestoneTires.new,
  electronics: BasicRadio.new,
  quality_checker: BasicInspection.new
)

luxury_sedan = luxury_factory.build_car("Luxury Sedan")
eco_car = eco_factory.build_car("Eco Car")
      </code></pre>
      
      <div style="background-color: #e8f5e8; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
        <h4>🎯 Benefits of the DI Solution:</h4>
        <ul>
          <li>✅ <strong>No application crashes:</strong> CarManufacturer keeps working when dependencies change</li>
          <li>✅ <strong>Minimal code changes:</strong> Only update dependency creation, not business logic</li>
          <li>✅ <strong>Independent teams:</strong> Engine and car teams work separately</li>
          <li>✅ <strong>Multiple configurations:</strong> Easy to create luxury, eco, sports car variants</li>
          <li>✅ <strong>Easy testing:</strong> Can inject mock objects instead of real dependencies</li>
        </ul>
      </div>
    HTML,
    position: 3
  },
  {
    block_type: "text",
    content: <<~HTML
      <h2>🧪 Testing Transformation with DI</h2>
      <p>The real power of DI shines in testing. Let's see the dramatic difference:</p>
      
      <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin: 2rem 0;">
        <div style="padding: 1rem; background-color: #ffebee; border-radius: 8px;">
          <h4>❌ Testing Without DI</h4>
          <pre><code class="ruby">
def test_successful_car_build
  factory = CarManufacturer.new
  car = factory.build_car("Test Car")
  
  # This test will:
  # - Actually create a real V8Engine
  # - Order real Michelin tires
  # - Install real radio system
  # - Take several seconds to complete
  # - Fail if any supplier is down
  
  assert_not_nil car
  # How do we verify specific engine was used?
  # How do we test error scenarios?
end
          </code></pre>
          <p><strong>Test Suite Problems:</strong></p>
          <ul>
            <li>⏱️ Takes minutes to run full suite</li>
            <li>🔄 Unreliable due to external dependencies</li>
            <li>🧪 Cannot test edge cases easily</li>
            <li>💰 May cost money if using real services</li>
          </ul>
        </div>
        
        <div style="padding: 1rem; background-color: #e8f5e8; border-radius: 8px;">
          <h4>✅ Testing With DI</h4>
          <pre><code class="ruby">
def test_successful_car_build
  mock_engine = MockEngine.new
  mock_tires = MockTires.new
  mock_electronics = MockElectronics.new
  mock_quality = MockQuality.new
  
  factory = CarManufacturer.new(
    engine_builder: mock_engine,
    tire_manufacturer: mock_tires,
    electronics: mock_electronics,
    quality_checker: mock_quality
  )
  
  car = factory.build_car("Test Car")
  
  # Verify behavior
  assert_not_nil car
  assert mock_engine.build_called
  assert_equal 4, mock_tires.tire_count
  assert mock_quality.inspection_performed
end
          </code></pre>
          <p><strong>Test Suite Benefits:</strong></p>
          <ul>
            <li>⏱️ Runs in milliseconds</li>
            <li>🔄 100% reliable</li>
            <li>🧪 Easy to test all scenarios</li>
            <li>💰 Completely free to run</li>
          </ul>
        </div>
      </div>
      
      <h3>Mock Object Implementation</h3>
      <pre><code class="ruby">
# Professional mock implementations for testing
class MockEngine
  attr_reader :build_called
  
  def initialize
    @build_called = false
  end
  
  def build_engine
    @build_called = true
    { type: "Mock Engine", horsepower: 100 }
  end
end

class MockTires
  attr_reader :tire_count
  
  def create_tires(count)
    @tire_count = count
    Array.new(count, { brand: "Mock", type: "Test" })
  end
end

class MockQuality
  attr_reader :inspection_performed
  
  def inspect_car(engine, tires, radio)
    @inspection_performed = true
    true
  end
end
      </code></pre>
    HTML,
    position: 4
  }
])

# LESSON 3: Professional Implementation (Clean version)
lesson3 = created_lessons[2]
lesson3.content_blocks.create!([
  {
    block_type: "text",
    content: <<~HTML
      <h1>Professional DI: Design Patterns and Production Practices</h1>
      <p>You've seen dependency injection solve real problems through Ruby examples. Now let's understand the deeper principles and professional techniques that make DI a cornerstone of enterprise software development.</p>
      
      <div style="background-color: #e3f2fd; padding: 1.5rem; border-left: 4px solid #2196f3; margin: 1rem 0;">
        <h3>🎯 Professional Mastery Objectives</h3>
        <ul>
          <li>Understand the theoretical foundations behind DI (IoC, SOLID principles)</li>
          <li>Master professional DI patterns and when to use them</li>
          <li>Implement production-grade DI containers</li>
          <li>Apply enterprise-level monitoring and best practices</li>
        </ul>
      </div>
      
      <h2>🤔 Why Study Design Principles?</h2>
      <p>DI isn't just a coding technique - it's part of a family of design principles that have evolved over decades of software engineering experience. Understanding these principles transforms you from someone who uses DI to someone who architects with DI.</p>
      
      <div style="background-color: #f1f8e9; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
        <h3>🏗️ The Architecture Hierarchy</h3>
        <p>Professional software development operates at multiple levels:</p>
        <ul>
          <li><strong>🔧 Techniques:</strong> Individual coding practices (like constructor injection)</li>
          <li><strong>📐 Patterns:</strong> Proven solutions to common problems (like dependency injection)</li>
          <li><strong>⚖️ Principles:</strong> Fundamental guidelines for good design (like SOLID)</li>
          <li><strong>🏛️ Architecture:</strong> Overall system structure and organization</li>
        </ul>
        <p>This lesson moves you up this hierarchy - from technique to architecture.</p>
      </div>
    HTML,
    position: 1
  },
  {
    block_type: "text",
    content: <<~HTML
      <h2>🔄 Inversion of Control: The Revolutionary Principle</h2>
      <p>Inversion of Control (IoC) is the theoretical foundation that makes dependency injection possible. Let's understand why it's considered revolutionary.</p>
      
      <h3>What "Control" Means in Software</h3>
      <div style="background-color: #f5f5f5; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
        <h4>🎮 Types of Control in Software:</h4>
        <ul>
          <li><strong>Object Creation Control:</strong> Who decides when and how objects are instantiated?</li>
          <li><strong>Dependency Management:</strong> Who manages relationships between objects?</li>
          <li><strong>Lifecycle Control:</strong> Who controls initialization, usage, and cleanup?</li>
          <li><strong>Configuration Control:</strong> Who decides how objects are configured?</li>
          <li><strong>Flow Control:</strong> Who controls the sequence of operations?</li>
        </ul>
      </div>
      
      <h3>Traditional Control vs. Inverted Control</h3>
      <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin: 2rem 0;">
        <div style="padding: 1.5rem; background-color: #ffebee; border-radius: 8px;">
          <h4>❌ Traditional Control ("Pull" Model)</h4>
          <pre><code class="ruby">
class OrderService
  def initialize
    # I control what I need
    @database = Database.connect("production")
    @email = EmailService.new("api_key")
    @payment = PaymentGateway.new("stripe")
    @logger = Logger.new("/var/log/app.log")
  end
  
  def process_order(order)
    # I control the sequence and decisions
    @logger.info("Starting order")
    @database.save(order)
    result = @payment.charge(order.amount)
    @email.send_confirmation(order) if result.success?
  end
end
          </code></pre>
          
          <p><strong>Characteristics:</strong></p>
          <ul>
            <li>Object knows exactly what it depends on</li>
            <li>Object creates its own dependencies</li>
            <li>Object controls configuration details</li>
            <li>Hard-coded implementation knowledge</li>
          </ul>
        </div>
        
        <div style="padding: 1.5rem; background-color: #e8f5e8; border-radius: 8px;">
          <h4>✅ Inverted Control ("Push" Model)</h4>
          <pre><code class="ruby">
class OrderService
  def initialize(database:, email_service:, payment_gateway:, logger:)
    # Someone else controls what I get
    @database = database
    @email = email_service  
    @payment = payment_gateway
    @logger = logger
  end
  
  def process_order(order)
    # I control my core logic, but not my dependencies
    @logger.info("Starting order")
    @database.save(order)
    result = @payment.charge(order.amount)
    @email.send_confirmation(order) if result.success?
  end
end
          </code></pre>
          
          <p><strong>Characteristics:</strong></p>
          <ul>
            <li>Object declares what it needs</li>
            <li>External entity provides dependencies</li>
            <li>External entity controls configuration</li>
            <li>No implementation knowledge required</li>
          </ul>
        </div>
      </div>
      
      <h3>Why IoC is Revolutionary</h3>
      <div style="background-color: #e3f2fd; padding: 1.5rem; border-left: 4px solid #2196f3; margin: 1rem 0;">
        <h4>🚀 The IoC Revolution Creates:</h4>
        
        <h5>1. True Separation of Concerns</h5>
        <ul>
          <li><strong>OrderService</strong> focuses only on order processing logic</li>
          <li><strong>DatabaseService</strong> focuses only on data persistence</li>
          <li><strong>IoC Container</strong> focuses only on object lifecycle and wiring</li>
        </ul>
        
        <h5>2. Runtime Flexibility</h5>
        <ul>
          <li>Choose database type at runtime (MySQL, PostgreSQL, SQLite)</li>
          <li>Switch email providers per environment (Gmail, SendGrid, Mock)</li>
          <li>Configure logging levels dynamically</li>
        </ul>
        
        <h5>3. Composition-Based Architecture</h5>
        <ul>
          <li>Build complex behavior through object composition</li>
          <li>Create new combinations without new classes</li>
          <li>Favor flexible composition over rigid inheritance</li>
        </ul>
      </div>
    HTML,
    position: 2
  },
  {
    block_type: "text",
    content: <<~HTML
      <h2>🏗️ SOLID Principles and DI</h2>
      <p>SOLID principles aren't academic theory - they solve expensive problems that plague software projects. Let's see how DI supports the key principles:</p>
      
      <h3>S - Single Responsibility Principle (SRP)</h3>
      <div style="background-color: #e8f5e8; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
        <h4>📋 Principle: A class should have only one reason to change</h4>
        
        <p><strong>What this prevents:</strong> Classes that try to do everything become fragile and hard to maintain.</p>
        
        <pre><code class="ruby">
# BAD - Multiple responsibilities mixed together
class OrderProcessor
  def initialize
    @database = Database.new
    @email_service = EmailService.new
  end
  
  def process_order(order)
    # Responsibility 1: Order validation
    validate_order(order)
    
    # Responsibility 2: Data persistence  
    @database.execute("INSERT INTO orders...")
    
    # Responsibility 3: Email formatting and sending
    email_body = format_email_template(order)
    @email_service.send(order.email, "Confirmed", email_body)
  end
end

# GOOD - Single responsibility with DI
class OrderProcessor
  def initialize(validator:, order_repository:, email_service:)
    @validator = validator
    @order_repository = order_repository
    @email_service = email_service
  end
  
  def process_order(order)
    # ONLY responsible for orchestrating order processing
    @validator.validate!(order)
    @order_repository.save(order)
    @email_service.send_confirmation(order)
  end
end

# Each dependency has its own focused responsibility
class OrderValidator
  def validate!(order)
    # ONLY responsible for order validation
  end
end

class OrderRepository
  def save(order)
    # ONLY responsible for order persistence
  end
end

class EmailService
  def send_confirmation(order)
    # ONLY responsible for email communication
  end
end
        </code></pre>
        
        <p><strong>Result with DI:</strong> Email changes only affect EmailService, database changes only affect OrderRepository, validation changes only affect OrderValidator.</p>
      </div>
      
      <h3>D - Dependency Inversion Principle (DIP)</h3>
      <div style="background-color: #fce4ec; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
        <h4>📋 Principle: High-level modules should not depend on low-level modules. Both should depend on abstractions.</h4>
        
        <p><strong>This is the principle that makes DI possible!</strong></p>
        
        <pre><code class="ruby">
# BAD - High-level depends directly on low-level
class OrderService
  def initialize
    @database = MySQLDatabase.new  # Direct dependency on concrete class
  end
  
  def create_order(order_data)
    @database.execute_sql("INSERT INTO orders...") # Coupled to SQL
  end
end

# GOOD - Both depend on abstraction
class OrderRepository
  def save(order_data)
    raise NotImplementedError, "Subclasses must implement save"
  end
end

# High-level module depends on abstraction
class OrderService
  def initialize(order_repository:)
    @order_repository = order_repository # Depends on abstraction, not implementation
  end
  
  def create_order(order_data)
    @order_repository.save(order_data) # Uses abstract interface
  end
end

# Low-level modules also depend on the same abstraction
class MySQLOrderRepository < OrderRepository
  def save(order_data)
    execute_sql("INSERT INTO orders...")
  end
end

class PostgreSQLOrderRepository < OrderRepository  
  def save(order_data)
    execute_query("INSERT INTO orders...")
  end
end

# Usage - high-level code works with any implementation
OrderService.new(order_repository: MySQLOrderRepository.new)
OrderService.new(order_repository: PostgreSQLOrderRepository.new)
        </code></pre>
        
        <p><strong>Result:</strong> OrderService can work with any database without modification, and database teams can work independently.</p>
      </div>
    HTML,
    position: 3
  },
  {
    block_type: "text",
    content: <<~HTML
      <h2>📦 Professional DI Patterns</h2>
      <p>There are several ways to implement dependency injection. Understanding when to use each pattern is key to professional implementation.</p>
      
      <h3>1. Constructor Injection (Recommended)</h3>
      <div style="background-color: #e8f5e8; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
        <h4>✅ Best for Required Dependencies</h4>
        <pre><code class="ruby">
class OrderService
  def initialize(payment_service:, email_service:, logger:)
    @payment_service = payment_service
    @email_service = email_service
    @logger = logger
  end
  
  def process_order(order)
    @logger.info("Processing order")
    # All dependencies guaranteed to be available
  end
end

# Clear, explicit dependency declaration
service = OrderService.new(
  payment_service: StripePayment.new,
  email_service: GmailService.new,
  logger: Rails.logger
)
        </code></pre>
        
        <p><strong>Advantages:</strong></p>
        <ul>
          <li>Dependencies are guaranteed at object creation</li>
          <li>Immutable after construction (thread-safe)</li>
          <li>Clear dependency requirements</li>
          <li>Prevents partially constructed objects</li>
        </ul>
      </div>
      
      <h3>2. Simple DI Container for Production</h3>
      <div style="background-color: #f1f8e9; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
        <h4>🏭 Professional Container Implementation</h4>
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
    service_config = @services[name]
    raise "Service not registered: #{name}" unless service_config
    
    case service_config[:scope]
    when :singleton
      @instances[name] ||= service_config[:factory].call(self)
    when :transient
      service_config[:factory].call(self)
    end
  end
  
  def health_check
    results = {}
    @services.each do |name, config|
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
    
    {
      overall: results.all? { |_, result| result[:status] == 'ok' },
      services: results
    }
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
    PostgreSQLDatabase.new('development_db')
  end
end

container.singleton(:email_service) do
  case Rails.env
  when 'production'
    SendGridService.new(ENV['SENDGRID_KEY'])
  when 'development'
    FileEmailService.new('tmp/emails')
  when 'test'
    MockEmailService.new
  end
end

container.register(:order_service) do |c|
  OrderService.new(
    order_repository: c.resolve(:order_repository),
    email_service: c.resolve(:email_service)
  )
end

# Usage in Rails
Rails.application.config.di_container = container

class OrdersController < ApplicationController
  def create
    order_service = Rails.application.config.di_container.resolve(:order_service)
    result = order_service.process(order_params)
    
    if result.success?
      render json: { success: true }
    else
      render json: { error: result.error_message }, status: 422
    end
  end
end
        </code></pre>
      </div>
      
      <h2>🎯 Production Best Practices Checklist</h2>
      <div style="background-color: #e3f2fd; padding: 2rem; border-left: 5px solid #2196f3; margin: 2rem 0;">
        <h3>✅ Professional Implementation Checklist</h3>
        
        <h4>🏗️ Architecture</h4>
        <ul>
          <li>All dependencies injected via constructor</li>
          <li>Abstractions define service contracts</li>
          <li>Each class has single responsibility</li>
          <li>High-level modules don't depend on low-level implementations</li>
        </ul>
        
        <h4>🔧 Implementation</h4>
        <ul>
          <li>DI container with singleton and transient scopes</li>
          <li>Configuration-driven service selection</li>
          <li>Graceful error handling</li>
          <li>Health checks for external dependencies</li>
        </ul>
        
        <h4>🧪 Testing</h4>
        <ul>
          <li>Mock implementations for all external services</li>
          <li>Test-specific container configuration</li>
          <li>Unit tests for business logic in isolation</li>
          <li>Integration tests with real dependencies</li>
        </ul>
      </div>
    HTML,
    position: 4
  }
])

# Create assignment for the new course  
assignment = created_lessons.last.assignments.create!(
  title: "Complete Dependency Injection Mastery Assessment",
  assignment_type: "quiz",
  published: true,
  max_score: 100
)

# Create comprehensive questions
questions_data = [
  {
    question_text: "What is the fundamental principle behind Dependency Injection?",
    question_type: "multiple_choice",
    points: 10,
    correct_answer: "1",
    options: {
      choices: [
        "Objects create all their dependencies internally for better control",
        "Objects receive their dependencies from external sources rather than creating them internally",
        "Objects use global variables to share dependencies",
        "Objects hardcode all dependency references for performance"
      ]
    }
  },
  {
    question_text: "In the car manufacturing example, what main problem occurs when each worker builds their own engine?",
    question_type: "multiple_choice",
    points: 10,
    correct_answer: "2",
    options: {
      choices: [
        "Cars are built faster because workers are self-sufficient",
        "Quality improves because workers control their own parts",  
        "Time is wasted, costs increase, quality becomes inconsistent, and testing becomes impossible",
        "The manufacturing process becomes more efficient and scalable"
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
        "A programming technique that controls application flow",
        "A principle where control of object creation moves from objects to external entities",
        "A method for reversing string values in Ruby",
        "A way to invert boolean logic in conditional statements"
      ]
    }
  },
  {
    question_text: "Which Ruby code correctly demonstrates constructor injection?",
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
    question_text: "How does DI improve testing in the CarManufacturer example?",
    question_type: "multiple_choice",
    points: 15,
    correct_answer: "1",
    options: {
      choices: [
        "Tests become slower but more comprehensive",
        "You can inject mock objects instead of real engines and tires, making tests fast and reliable",
        "Testing becomes unnecessary because DI prevents bugs",
        "Tests automatically generate themselves"
      ]
    }
  },
  {
    question_text: "Which SOLID principle is most directly implemented by Dependency Injection?",
    question_type: "multiple_choice",
    points: 10,
    correct_answer: "3",
    options: {
      choices: [
        "Single Responsibility Principle (SRP)",
        "Open/Closed Principle (OCP)", 
        "Liskov Substitution Principle (LSP)",
        "Dependency Inversion Principle (DIP)"
      ]
    }
  },
  {
    question_text: "What is the main advantage of using a DI container in production applications?",
    question_type: "multiple_choice",
    points: 10,
    correct_answer: "1",
    options: {
      choices: [
        "It makes applications run faster",
        "It automates dependency wiring and provides lifecycle management",
        "It eliminates the need for testing", 
        "It automatically fixes code bugs"
      ]
    }
  },
  {
    question_text: "True or False: With proper DI implementation, you can test OrderService without making real API calls, database queries, or sending actual emails.",
    question_type: "true_false",
    points: 5,
    correct_answer: "1",
    options: {}
  },
  {
    question_text: "True or False: In dependency injection, the business logic of your classes needs to change when you switch from one implementation to another.",
    question_type: "true_false", 
    points: 5,
    correct_answer: "0",
    options: {}
  }
]

questions_data.each_with_index do |question_data, index|
  assignment.assignment_questions.create!(question_data)
  puts "✅ Created question #{index + 1}: #{question_data[:question_text][0..50]}..."
end

puts "\n🎉 Successfully created clean Dependency Injection course!"
puts "Course: #{clean_di_course.title}"
puts "Lessons: #{clean_di_course.lessons.count} comprehensive lessons"
puts "Content blocks: #{clean_di_course.lessons.sum { |l| l.content_blocks.count }} total"
puts "Assignment: #{assignment.assignment_questions.count} focused questions"
puts "Duration: #{clean_di_course.duration} hours"
puts "\nThis is a completely new course with no repetitions - the original course remains untouched."