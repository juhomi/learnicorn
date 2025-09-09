# Clean Dependency Injection Course - No Repetitions
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
    content: %{
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
    },
    position: 1
  },
  {
    block_type: "image",
    file_url: "https://images.unsplash.com/photo-1558618047-3c8c76ca7d13?w=800&h=500&fit=crop",
    alt_text: "Car manufacturing assembly line showing complex dependencies",
    position: 2
  },
  {
    block_type: "text",
    content: %{
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
    },
    position: 3
  },
  {
    block_type: "text",
    content: %{
      <h2>🍽️ Restaurant System: Business Dependencies</h2>
      <p>Let's see how the same principles apply to business systems:</p>
      
      <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin: 2rem 0;">
        <div style="padding: 1.5rem; background-color: #ffebee; border-radius: 8px;">
          <h3>❌ Without Proper Dependencies</h3>
          <h4>Each Waiter Manages Everything:</h4>
          <ul>
            <li>Creates own menu with prices</li>
            <li>Sets up own payment system</li>
            <li>Manages own inventory tracking</li>
            <li>Builds own kitchen communication</li>
          </ul>
          <h4>Problems:</h4>
          <ul>
            <li>Inconsistent pricing confuses customers</li>
            <li>Duplicate systems waste money</li>
            <li>Training new staff is nightmare</li>
            <li>Menu updates take forever</li>
          </ul>
        </div>
        <div style="padding: 1.5rem; background-color: #e8f5e8; border-radius: 8px;">
          <h3>✅ With Proper Dependencies</h3>
          <h4>Restaurant Provides Shared Services:</h4>
          <ul>
            <li>Central menu system for all waiters</li>
            <li>Shared payment processing terminal</li>
            <li>Unified inventory management system</li>
            <li>Common kitchen communication system</li>
          </ul>
          <h4>Benefits:</h4>
          <ul>
            <li>Consistent customer experience</li>
            <li>Cost-effective operations</li>
            <li>Easy staff training</li>
            <li>Simple system updates</li>
          </ul>
        </div>
      </div>
    },
    position: 4
  },
  {
    block_type: "text",
    content: %{
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
    },
    position: 5
  }
])

# LESSON 2: Ruby Implementation (Clean, comprehensive version)
lesson2 = created_lessons[1]
lesson2.content_blocks.create!([
  {
    block_type: "text",
    content: %{
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
    },
    position: 1
  },
  {
    block_type: "text",
    content: %{
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
    puts "Building \#{car_type}..."
    
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
    puts "Creating \#{count} Michelin performance tires"
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
    },
    position: 2
  },
  {
    block_type: "text",
    content: %{
      <h3>📊 Real-World Impact: The V8Engine Update Scenario</h3>
      <p>Let's see what happens when dependencies change in tightly coupled code:</p>
      
      <div style="background-color: #fff3e0; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
        <h4>⚠️ Scenario: V8Engine Adds Emissions Control</h4>
        <pre><code class="ruby">
# V8Engine team adds new requirement
class V8Engine
  def initialize(emissions_standard)  # ⚠️ New required parameter!
    @emissions_standard = emissions_standard
  end
  
  def build_engine
    { 
      type: "V8", 
      horsepower: 400,
      emissions: @emissions_standard 
    }
  end
end
        </code></pre>
        
        <p><strong>Impact on CarManufacturer:</strong></p>
        <pre><code class="ruby">
def initialize
  # This line now crashes the entire application!
  @engine_builder = V8Engine.new  # ❌ ArgumentError: missing required parameter
end
        </code></pre>
        
        <p><strong>Consequences:</strong></p>
        <ul>
          <li>🚨 <strong>Application crash:</strong> All car manufacturing stops immediately</li>
          <li>⏱️ <strong>Development delay:</strong> Must update CarManufacturer code before deployment</li>
          <li>🧪 <strong>Test failures:</strong> All tests using CarManufacturer break</li>
          <li>👥 <strong>Team coordination:</strong> Engine team cannot work independently</li>
        </ul>
      </div>
    },
    position: 3
  },
  {
    block_type: "text",
    content: %{
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
    puts "Building \#{car_type}..."
    
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
        <h4>🎯 How DI Solves the V8Engine Update Problem:</h4>
        <p>When V8Engine adds the emissions parameter:</p>
        <pre><code class="ruby">
# CarManufacturer code doesn't need to change at all!
# The change happens only where we create the dependencies:

# Before
luxury_factory = CarManufacturer.new(
  engine_builder: V8Engine.new,  # ❌ This line needs updating
  tire_manufacturer: MichelinTires.new,
  electronics: PremiumStereo.new,
  quality_checker: PremiumInspection.new
)

# After - only dependency creation changes
luxury_factory = CarManufacturer.new(
  engine_builder: V8Engine.new("Euro6"),  # ✅ Simply add the parameter
  tire_manufacturer: MichelinTires.new,
  electronics: PremiumStereo.new,
  quality_checker: PremiumInspection.new
)
        </code></pre>
        
        <p><strong>Benefits:</strong></p>
        <ul>
          <li>✅ <strong>No application crash:</strong> CarManufacturer keeps working</li>
          <li>✅ <strong>Minimal code change:</strong> Only update dependency creation</li>
          <li>✅ <strong>Independent teams:</strong> Engine and car teams work separately</li>
          <li>✅ <strong>Backwards compatibility:</strong> Old and new engines can coexist</li>
        </ul>
      </div>
    },
    position: 4
  },
  {
    block_type: "text",
    content: %{
      <h2>📧 Example 2: Order Processing System</h2>
      <p>Let's see DI in a business context with external service dependencies:</p>
      
      <h3>❌ The Problem: External Service Dependencies</h3>
      <pre><code class="ruby">
# BAD EXAMPLE - Hard-coded external services
class OrderProcessor
  def initialize
    # Hard-coded external dependencies - major problems ahead!
    @email_service = GmailService.new
    @payment_processor = StripePayment.new
    @inventory = DatabaseInventory.new
  end
  
  def process_order(order)
    # Check inventory
    unless @inventory.available?(order.product_id, order.quantity)
      @email_service.send_email(
        to: order.customer_email,
        subject: "Order Failed - Out of Stock",
        body: "Sorry, #{order.product_name} is out of stock."
      )
      return false
    end
    
    # Process payment
    payment_result = @payment_processor.charge(
      amount: order.total,
      card_token: order.card_token
    )
    
    unless payment_result.success?
      @email_service.send_email(
        to: order.customer_email,
        subject: "Payment Failed",
        body: "Your payment could not be processed."
      )
      return false
    end
    
    # Send success email
    @email_service.send_email(
      to: order.customer_email,
      subject: "Order Confirmed!",
      body: "Your order has been confirmed!"
    )
    
    true
  end
end
      </code></pre>
      
      <div style="background-color: #ffebee; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
        <h4>🚨 Serious Problems with External Dependencies:</h4>
        <ul>
          <li><strong>💰 Expensive Testing:</strong> Every test sends real emails and charges real credit cards</li>
          <li><strong>⏱️ Slow Tests:</strong> Network calls make tests take minutes instead of seconds</li>
          <li><strong>🔄 Unreliable Tests:</strong> Tests fail when Gmail is down or Stripe has issues</li>
          <li><strong>📧 Spam Problem:</strong> Test suite floods your inbox with emails</li>
          <li><strong>🔒 Vendor Lock-in:</strong> Cannot switch from Gmail to SendGrid without code changes</li>
          <li><strong>🌍 Regional Issues:</strong> Cannot use different payment processors for different countries</li>
        </ul>
      </div>
    },
    position: 5
  },
  {
    block_type: "text",
    content: %{
      <h3>✅ The Solution: Flexible External Services</h3>
      <pre><code class="ruby">
# GOOD EXAMPLE - Injected external services
class OrderProcessor
  def initialize(email_service:, payment_processor:, inventory:)
    @email_service = email_service
    @payment_processor = payment_processor
    @inventory = inventory
  end
  
  def process_order(order)
    # Same business logic, but now flexible and testable!
    unless @inventory.available?(order.product_id, order.quantity)
      @email_service.send_email(
        to: order.customer_email,
        subject: "Order Failed - Out of Stock",
        body: "Sorry, #{order.product_name} is out of stock."
      )
      return false
    end
    
    payment_result = @payment_processor.charge(
      amount: order.total,
      card_token: order.card_token
    )
    
    unless payment_result.success?
      @email_service.send_email(
        to: order.customer_email,
        subject: "Payment Failed",
        body: "Your payment could not be processed."
      )
      return false
    end
    
    @email_service.send_email(
      to: order.customer_email,
      subject: "Order Confirmed!",
      body: "Your order has been confirmed!"
    )
    
    true
  end
end

# Production configuration
production_processor = OrderProcessor.new(
  email_service: GmailService.new,
  payment_processor: StripePayment.new,
  inventory: DatabaseInventory.new
)

# Development configuration - no real emails or charges
development_processor = OrderProcessor.new(
  email_service: FileEmailService.new('tmp/emails'),
  payment_processor: MockPayment.new,
  inventory: InMemoryInventory.new
)

# Testing configuration - fast and controlled
test_processor = OrderProcessor.new(
  email_service: MockEmailService.new,
  payment_processor: MockPayment.new,
  inventory: MockInventory.new
)
      </code></pre>
    },
    position: 6
  },
  {
    block_type: "text",
    content: %{
      <h2>🧪 Testing Transformation with DI</h2>
      <p>The real power of DI shines in testing. Let's see the dramatic difference:</p>
      
      <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin: 2rem 0;">
        <div style="padding: 1rem; background-color: #ffebee; border-radius: 8px;">
          <h4>❌ Testing Without DI</h4>
          <pre><code class="ruby">
def test_successful_order
  processor = OrderProcessor.new
  order = create_test_order
  
  # This test will:
  # - Send real email to customer
  # - Charge real credit card $99.99
  # - Hit real database
  # - Take 3-5 seconds to complete
  # - Fail if Gmail is down
  # - Cost money on each run
  
  result = processor.process_order(order)
  assert result
  
  # How do we verify email was sent?
  # How do we test payment failures?
  # What if network is slow/down?
end
          </code></pre>
          <p><strong>Test Suite Problems:</strong></p>
          <ul>
            <li>💰 1000 tests = $1000+ in charges</li>
            <li>⏱️ Takes 1+ hours to run</li>
            <li>📧 Generates spam emails</li>
            <li>🔄 50% failure rate from external issues</li>
          </ul>
        </div>
        
        <div style="padding: 1rem; background-color: #e8f5e8; border-radius: 8px;">
          <h4>✅ Testing With DI</h4>
          <pre><code class="ruby">
def test_successful_order
  mock_email = MockEmailService.new
  mock_payment = MockPayment.new
  mock_inventory = MockInventory.new
  
  processor = OrderProcessor.new(
    email_service: mock_email,
    payment_processor: mock_payment,
    inventory: mock_inventory
  )
  
  # Set up test scenario
  mock_inventory.set_available(true)
  mock_payment.set_success(true)
  
  order = create_test_order
  result = processor.process_order(order)
  
  # Verify behavior
  assert result
  assert_equal 1, mock_email.sent_emails.count
  assert_includes mock_email.sent_emails.first[:subject], "Confirmed"
end
          </code></pre>
          <p><strong>Test Suite Benefits:</strong></p>
          <ul>
            <li>💰 1000 tests = $0 cost</li>
            <li>⏱️ Runs in under 1 minute</li>
            <li>📧 No emails sent</li>
            <li>🔄 100% reliable</li>
          </ul>
        </div>
      </div>
      
      <h3>Mock Object Implementation</h3>
      <pre><code class="ruby">
# Professional mock implementations for testing
class MockEmailService
  attr_reader :sent_emails
  
  def initialize
    @sent_emails = []
  end
  
  def send_email(to:, subject:, body:)
    @sent_emails << { to: to, subject: subject, body: body }
    puts "Mock: Email logged for #{to}: #{subject}"
  end
end

class MockPayment
  def initialize
    @success = true
  end
  
  def set_success(success)
    @success = success
  end
  
  def charge(amount:, card_token:)
    if @success
      OpenStruct.new(success?: true, transaction_id: "mock_#{rand(1000)}")
    else
      OpenStruct.new(success?: false, error: "Mock payment failure")
    end
  end
end

class MockInventory
  def initialize
    @available = true
  end
  
  def set_available(available)
    @available = available
  end
  
  def available?(product_id, quantity)
    @available
  end
end
      </code></pre>
    },
    position: 7
  },
  {
    block_type: "text",
    content: %{
      <h2>📊 Transformation Summary</h2>
      <p>Let's summarize what we've learned about transforming code with dependency injection:</p>
      
      <table style="width: 100%; border-collapse: collapse; margin: 2rem 0;">
        <thead>
          <tr style="background-color: #f5f5f5;">
            <th style="padding: 1rem; border: 1px solid #ddd;">Aspect</th>
            <th style="padding: 1rem; border: 1px solid #ddd; background-color: #ffebee;">❌ Without DI</th>
            <th style="padding: 1rem; border: 1px solid #ddd; background-color: #e8f5e8;">✅ With DI</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td style="padding: 1rem; border: 1px solid #ddd; font-weight: bold;">Testing</td>
            <td style="padding: 1rem; border: 1px solid #ddd;">Slow, expensive, unreliable. Must use real external services</td>
            <td style="padding: 1rem; border: 1px solid #ddd;">Fast, free, reliable. Use lightweight mock objects</td>
          </tr>
          <tr style="background-color: #f9f9f9;">
            <td style="padding: 1rem; border: 1px solid #ddd; font-weight: bold;">Flexibility</td>
            <td style="padding: 1rem; border: 1px solid #ddd;">Locked to specific implementations. Hard to change</td>
            <td style="padding: 1rem; border: 1px solid #ddd;">Easy to swap implementations. Multiple configurations possible</td>
          </tr>
          <tr>
            <td style="padding: 1rem; border: 1px solid #ddd; font-weight: bold;">Maintenance</td>
            <td style="padding: 1rem; border: 1px solid #ddd;">Changes ripple through system. High coupling</td>
            <td style="padding: 1rem; border: 1px solid #ddd;">Isolated changes. Dependencies evolve independently</td>
          </tr>
          <tr style="background-color: #f9f9f9;">
            <td style="padding: 1rem; border: 1px solid #ddd; font-weight: bold;">Team Work</td>
            <td style="padding: 1rem; border: 1px solid #ddd;">Teams must coordinate changes. Dependencies block each other</td>
            <td style="padding: 1rem; border: 1px solid #ddd;">Teams work independently. Contracts define interfaces</td>
          </tr>
          <tr>
            <td style="padding: 1rem; border: 1px solid #ddd; font-weight: bold;">Scalability</td>
            <td style="padding: 1rem; border: 1px solid #ddd;">Becomes unwieldy as system grows</td>
            <td style="padding: 1rem; border: 1px solid #ddd;">Scales well. Easy to add new implementations</td>
          </tr>
        </tbody>
      </table>
      
      <div style="background-color: #e3f2fd; padding: 1.5rem; border-left: 4px solid #2196f3; margin: 1rem 0;">
        <h3>🎯 Key Takeaways</h3>
        <ul>
          <li><strong>Constructor Injection</strong> is the most common and reliable DI pattern</li>
          <li><strong>Mock objects</strong> make testing fast, reliable, and cost-free</li>
          <li><strong>Interface consistency</strong> allows multiple implementations</li>
          <li><strong>Configuration flexibility</strong> enables different setups for different environments</li>
          <li><strong>Business logic</strong> remains unchanged when dependencies are injected</li>
        </ul>
      </div>
    },
    position: 8
  }
])

# LESSON 3: Professional Implementation (Clean, comprehensive version)
lesson3 = created_lessons[2]
lesson3.content_blocks.create!([
  {
    block_type: "text",
    content: %{
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
    },
    position: 1
  },
  {
    block_type: "text",
    content: %{
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
    @logger.info("Starting order #{order.id}")
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
    @logger.info("Starting order #{order.id}")
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
    },
    position: 2
  },
  {
    block_type: "text",
    content: %{
      <h2>🏗️ SOLID Principles: The Foundation of Quality Code</h2>
      <p>SOLID principles aren't academic theory - they solve expensive problems that plague software projects. Let's see how DI supports each principle.</p>
      
      <h3>S - Single Responsibility Principle (SRP)</h3>
      <div style="background-color: #e8f5e8; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
        <h4>📋 Principle: A class should have only one reason to change</h4>
        
        <p><strong>What this prevents:</strong> Classes that try to do everything become fragile and hard to maintain.</p>
        
        <h5>❌ SRP Violation:</h5>
        <pre><code class="ruby">
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
    
    # Responsibility 3: Email formatting
    email_body = format_email_template(order)
    
    # Responsibility 4: Email sending
    @email_service.send(order.email, "Confirmed", email_body)
  end
  
  private
  
  def validate_order(order)
    # Validation logic mixed with other concerns
  end
  
  def format_email_template(order)
    # Email template logic mixed with other concerns
  end
end
        </code></pre>
        <p><strong>Problems:</strong> Changes to email templates, database schema, or validation rules all require modifying OrderProcessor.</p>
        
        <h5>✅ SRP with DI:</h5>
        <pre><code class="ruby">
# Each class has a single, focused responsibility
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

class OrderValidator
  def validate!(order)
    # ONLY responsible for order validation
    raise InvalidOrder, "Missing customer" unless order.customer
    raise InvalidOrder, "Invalid amount" unless order.amount > 0
  end
end

class OrderRepository
  def save(order)
    # ONLY responsible for order persistence
    # Database-specific logic here
  end
end

class EmailService
  def send_confirmation(order)
    # ONLY responsible for email communication
    template = EmailTemplate.new(:order_confirmation)
    send_email(order.customer.email, template.render(order))
  end
end
        </code></pre>
        
        <p><strong>Benefits:</strong> Email changes only affect EmailService, database changes only affect OrderRepository, validation changes only affect OrderValidator.</p>
      </div>
      
      <h3>D - Dependency Inversion Principle (DIP)</h3>
      <div style="background-color: #fce4ec; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
        <h4>📋 Principle: High-level modules should not depend on low-level modules. Both should depend on abstractions.</h4>
        
        <p><strong>This is the principle that makes DI possible!</strong></p>
        
        <h5>❌ DIP Violation:</h5>
        <pre><code class="ruby">
# High-level OrderService depends directly on low-level implementations
class OrderService
  def initialize
    @database = MySQLDatabase.new  # Direct dependency on concrete class
  end
  
  def create_order(order_data)
    @database.execute_sql("INSERT INTO orders...") # Coupled to SQL
  end
end
        </code></pre>
        
        <h5>✅ DIP with Abstraction:</h5>
        <pre><code class="ruby">
# Abstraction that both high and low-level modules depend on
class OrderRepository
  def save(order_data)
    raise NotImplementedError, "Subclasses must implement save"
  end
end

# High-level module depends on abstraction
class OrderService
  def initialize(order_repository:)  # Depends on abstraction, not implementation
    @order_repository = order_repository
  end
  
  def create_order(order_data)
    @order_repository.save(order_data)  # Uses abstract interface
  end
end

# Low-level modules also depend on the same abstraction
class MySQLOrderRepository < OrderRepository
  def save(order_data)
    # MySQL-specific implementation
    execute_sql("INSERT INTO orders...")
  end
end

class PostgreSQLOrderRepository < OrderRepository  
  def save(order_data)
    # PostgreSQL-specific implementation
    execute_query("INSERT INTO orders...")
  end
end

class MongoOrderRepository < OrderRepository
  def save(order_data)
    # MongoDB-specific implementation
    collection.insert_one(order_data)
  end
end

# Usage - high-level code works with any implementation
OrderService.new(order_repository: MySQLOrderRepository.new)
OrderService.new(order_repository: PostgreSQLOrderRepository.new)
OrderService.new(order_repository: MongoOrderRepository.new)
        </code></pre>
        
        <p><strong>Result:</strong> OrderService can work with any database without modification, and database teams can work independently.</p>
      </div>
    },
    position: 3
  },
  {
    block_type: "text",
    content: %{
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
    @logger.info("Processing order #{order.id}")
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
      
      <h3>2. Setter Injection</h3>
      <div style="background-color: #fff3e0; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
        <h4>⚠️ Use for Optional Dependencies</h4>
        <pre><code class="ruby">
class OrderService
  attr_writer :logger, :metrics_collector
  
  def initialize(payment_service:, email_service:)
    @payment_service = payment_service  # Required
    @email_service = email_service      # Required
    @logger = NullLogger.new           # Default
    @metrics_collector = NullMetrics.new # Default
  end
  
  def process_order(order)
    @logger&.info("Processing order #{order.id}")
    result = @payment_service.charge(order.amount)
    @metrics_collector&.increment("orders.processed")
    result
  end
end

# Usage with optional dependencies
service = OrderService.new(
  payment_service: StripePayment.new,
  email_service: GmailService.new
)
service.logger = Rails.logger          # Optional
service.metrics_collector = Datadog.new # Optional
        </code></pre>
        
        <p><strong>Use when:</strong> Some dependencies are optional or may be configured after construction.</p>
      </div>
      
      <h3>3. Method Injection</h3>
      <div style="background-color: #f3e5f5; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
        <h4>🔧 Use for Context-Specific Dependencies</h4>
        <pre><code class="ruby">
class OrderService
  def process_order(order, payment_service:, notification_service:)
    # Dependencies passed per method call - useful for strategy patterns
    payment_result = payment_service.charge(order.amount)
    
    if payment_result.success?
      notification_service.send_confirmation(order)
    else
      notification_service.send_failure_notice(order)
    end
  end
end

# Different strategies per call
service = OrderService.new

service.process_order(us_order,
  payment_service: StripePayment.new,
  notification_service: EmailService.new
)

service.process_order(eu_order,
  payment_service: PayPalPayment.new,  
  notification_service: SMSService.new
)
        </code></pre>
        
        <p><strong>Use when:</strong> Dependencies change per method call or you're implementing strategy patterns.</p>
      </div>
    },
    position: 4
  },
  {
    block_type: "text",
    content: %{
      <h2>🏭 Production-Grade DI Container</h2>
      <p>As applications grow, manually wiring dependencies becomes unwieldy. Professional DI containers automate this process with advanced features.</p>
      
      <h3>Enterprise DI Container Implementation</h3>
      <pre><code class="ruby">
class ProfessionalDIContainer
  def initialize
    @services = {}
    @instances = {}      # For singletons
    @resolving = Set.new # Detect circular dependencies
    @middleware = []     # For cross-cutting concerns
  end
  
  # Register a service with advanced options
  def register(name, scope: :transient, tags: [], &factory)
    @services[name] = {
      factory: factory,
      scope: scope,
      tags: tags,
      registered_at: Time.current
    }
  end
  
  # Register a singleton service
  def singleton(name, tags: [], &factory)
    register(name, scope: :singleton, tags: tags, &factory)
  end
  
  # Resolve a service with full dependency injection
  def resolve(name)
    service_config = @services[name]
    raise ServiceNotRegistered, "Service '#{name}' not registered" unless service_config
    
    # Detect circular dependencies
    if @resolving.include?(name)
      cycle = (@resolving.to_a + [name]).join(' -> ')
      raise CircularDependency, "Circular dependency detected: #{cycle}"
    end
    
    @resolving.add(name)
    
    begin
      instance = case service_config[:scope]
      when :singleton
        @instances[name] ||= create_instance(name, service_config)
      when :transient
        create_instance(name, service_config)
      else
        raise InvalidScope, "Unknown scope: #{service_config[:scope]}"
      end
      
      # Apply middleware (logging, metrics, etc.)
      @middleware.reduce(instance) { |obj, middleware| middleware.call(obj) }
    ensure
      @resolving.delete(name)
    end
  end
  
  # Health check for all registered services  
  def health_check
    results = {}
    overall_healthy = true
    
    @services.each do |name, config|
      begin
        service = resolve(name)
        if service.respond_to?(:health_check)
          health = service.health_check
          results[name] = health
          overall_healthy = false unless health[:status] == 'healthy'
        else
          results[name] = { status: 'healthy', message: 'No health check method' }
        end
      rescue => e
        results[name] = { status: 'error', message: e.message, class: e.class.name }
        overall_healthy = false
      end
    end
    
    {
      overall_status: overall_healthy ? 'healthy' : 'unhealthy',
      services: results,
      checked_at: Time.current.iso8601
    }
  end
  
  # Find services by tags
  def find_by_tag(tag)
    @services.select { |name, config| config[:tags].include?(tag) }
             .map { |name, config| { name: name, service: resolve(name) } }
  end
  
  # Add middleware for cross-cutting concerns
  def add_middleware(&block)
    @middleware << block
  end
  
  private
  
  def create_instance(name, config)
    start_time = Time.current
    instance = config[:factory].call(self)
    end_time = Time.current
    
    Rails.logger.debug "DI: Created #{name} in #{((end_time - start_time) * 1000).round(2)}ms"
    instance
  rescue => e
    Rails.logger.error "DI: Failed to create #{name}: #{e.message}"
    raise ServiceCreationFailed, "Failed to create service '#{name}': #{e.message}"
  end
end

# Custom exceptions
class ServiceNotRegistered < StandardError; end
class CircularDependency < StandardError; end
class InvalidScope < StandardError; end
class ServiceCreationFailed < StandardError; end
      </code></pre>
    },
    position: 5
  },
  {
    block_type: "text",
    content: %{
      <h3>Enterprise Configuration and Usage</h3>
      <pre><code class="ruby">
# Production container configuration
class ProductionDIContainer
  def self.configure
    container = ProfessionalDIContainer.new
    
    # Add logging middleware
    container.add_middleware do |service|
      if service.class.name.include?('Service')
        Rails.logger.info "DI: Activated #{service.class.name}"
      end
      service
    end
    
    # Infrastructure services (singletons)
    container.singleton(:database, tags: [:infrastructure]) do
      case Rails.env
      when 'production'
        PostgreSQLDatabase.new(
          host: ENV['DATABASE_HOST'],
          port: ENV['DATABASE_PORT']&.to_i || 5432,
          database: ENV['DATABASE_NAME'],
          pool_size: ENV['DATABASE_POOL_SIZE']&.to_i || 10
        )
      when 'development'
        PostgreSQLDatabase.new(database: 'myapp_development')
      when 'test'
        InMemoryDatabase.new
      end
    end
    
    container.singleton(:cache, tags: [:infrastructure]) do
      case ENV['CACHE_PROVIDER']
      when 'redis'
        RedisCache.new(ENV['REDIS_URL'])
      when 'memory'
        MemoryCache.new(max_size: 1000)
      else
        NullCache.new
      end
    end
    
    container.singleton(:email_service, tags: [:external_service]) do |c|
      case ENV['EMAIL_PROVIDER']
      when 'sendgrid'
        SendGridService.new(
          api_key: ENV['SENDGRID_API_KEY'],
          from_email: ENV['FROM_EMAIL']
        )
      when 'ses'
        SESService.new(
          region: ENV['AWS_REGION'],
          access_key: ENV['AWS_ACCESS_KEY_ID'],
          secret_key: ENV['AWS_SECRET_ACCESS_KEY']
        )
      when 'development'
        FileEmailService.new('tmp/emails')
      when 'test'
        MockEmailService.new
      end
    end
    
    # Business services (transient - may hold request-specific state)
    container.register(:user_service, tags: [:business_logic]) do |c|
      UserService.new(
        user_repository: c.resolve(:user_repository),
        email_service: c.resolve(:email_service),
        logger: Rails.logger
      )
    end
    
    container.register(:order_service, tags: [:business_logic]) do |c|
      OrderService.new(
        order_repository: c.resolve(:order_repository),
        payment_service: c.resolve(:payment_service),
        email_service: c.resolve(:email_service),
        inventory_service: c.resolve(:inventory_service)
      )
    end
    
    # Repository services
    container.register(:user_repository, tags: [:data_access]) do |c|
      UserRepository.new(
        database: c.resolve(:database),
        cache: c.resolve(:cache)
      )
    end
    
    container.register(:order_repository, tags: [:data_access]) do |c|
      OrderRepository.new(
        database: c.resolve(:database),
        cache: c.resolve(:cache)
      )
    end
    
    container
  end
end

# Rails integration
# config/initializers/di_container.rb
Rails.application.configure do
  config.di_container = ProductionDIContainer.configure
end

# Usage in controllers
class OrdersController < ApplicationController  
  def create
    order_service = container.resolve(:order_service)
    result = order_service.process(order_params)
    
    if result.success?
      render json: { success: true, order_id: result.order.id }
    else
      render json: { error: result.error_message }, status: 422
    end
  end
  
  private
  
  def container
    Rails.application.config.di_container
  end
end

# Health check endpoint
class HealthController < ApplicationController
  def show
    health = container.health_check
    render json: health, status: health[:overall_status] == 'healthy' ? 200 : 503
  end
end
      </code></pre>
    },
    position: 6
  },
  {
    block_type: "text",
    content: %{
      <h2>🚀 Production Best Practices</h2>
      <p>Professional DI implementation requires attention to performance, monitoring, and operational concerns.</p>
      
      <h3>1. Performance Optimization</h3>
      <div style="background-color: #e8f5e8; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
        <h4>✅ Lazy Loading and Caching</h4>
        <pre><code class="ruby">
class PerformantDIContainer
  def resolve(name)
    # Cache resolution paths to avoid repeated lookups
    @resolution_cache ||= {}
    
    return @resolution_cache[name] if @resolution_cache.key?(name) && 
                                      @services[name][:scope] == :singleton
    
    instance = create_and_wire_service(name)
    @resolution_cache[name] = instance if @services[name][:scope] == :singleton
    instance
  end
  
  # Preload critical services at startup
  def warm_up
    critical_services = find_by_tag(:critical)
    critical_services.each { |service_info| resolve(service_info[:name]) }
  end
end
        </code></pre>
      </div>
      
      <h3>2. Monitoring and Observability</h3>
      <div style="background-color: #e1f5fe; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
        <h4>📊 Service Metrics and Health Monitoring</h4>
        <pre><code class="ruby">
class MonitoredDIContainer < ProfessionalDIContainer
  def initialize
    super
    @metrics = {}
  end
  
  def resolve(name)
    start_time = Time.current
    increment_metric("di.service.resolution_attempts", tags: { service: name })
    
    begin
      result = super(name)
      record_metric("di.service.resolution_time", 
                   (Time.current - start_time) * 1000, 
                   tags: { service: name, status: 'success' })
      result
    rescue => e
      increment_metric("di.service.resolution_errors", tags: { service: name, error: e.class.name })
      record_metric("di.service.resolution_time", 
                   (Time.current - start_time) * 1000, 
                   tags: { service: name, status: 'error' })
      raise
    end
  end
  
  def health_check
    result = super
    
    # Add container-specific health metrics
    result[:container_metrics] = {
      registered_services: @services.count,
      singleton_instances: @instances.count,
      average_resolution_time: average_resolution_time,
      error_rate: error_rate
    }
    
    result
  end
  
  private
  
  def increment_metric(name, tags: {})
    # Integration with your metrics system (DataDog, New Relic, etc.)
    StatsD.increment(name, tags: tags)
  end
  
  def record_metric(name, value, tags: {})
    StatsD.histogram(name, value, tags: tags)
  end
end
        </code></pre>
      </div>
      
      <h3>3. Error Handling and Resilience</h3>
      <div style="background-color: #fff3e0; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
        <h4>🛡️ Graceful Degradation</h4>
        <pre><code class="ruby">
class ResilientDIContainer < MonitoredDIContainer
  def resolve(name)
    super(name)
  rescue ServiceCreationFailed => e
    # Try to provide fallback service
    fallback_name = "#{name}_fallback"
    if @services.key?(fallback_name)
      Rails.logger.warn "DI: Using fallback for #{name}: #{e.message}"
      resolve(fallback_name)
    else
      raise
    end
  end
  
  def register_with_fallback(name, fallback_service, &factory)
    register(name, &factory)
    register("#{name}_fallback") { fallback_service }
  end
end

# Usage with fallbacks
container.register_with_fallback(:payment_service, NullPaymentService.new) do
  StripePaymentService.new(api_key: ENV['STRIPE_KEY'])
end

# If Stripe fails, NullPaymentService logs the attempt but doesn't crash
      </code></pre>
      </div>
      
      <h2>🎯 Professional Implementation Checklist</h2>
      <div style="background-color: #e3f2fd; padding: 2rem; border-left: 5px solid #2196f3; margin: 2rem 0;">
        <h3>✅ Production Readiness Checklist</h3>
        
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
          <li>Circular dependency detection</li>
          <li>Configuration-driven service selection</li>
          <li>Graceful error handling with fallbacks</li>
        </ul>
        
        <h4>📊 Operations</h4>
        <ul>
          <li>Health checks for all external dependencies</li>
          <li>Service resolution metrics and monitoring</li>
          <li>Performance optimization with caching</li>
          <li>Structured logging for debugging</li>
        </ul>
        
        <h4>🧪 Testing</h4>
        <ul>
          <li>Mock implementations for all external services</li>
          <li>Test-specific container configuration</li>
          <li>Unit tests for business logic in isolation</li>
          <li>Integration tests with real dependencies</li>
        </ul>
      </div>
    },
    position: 7
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
    question_text: "How does DI solve the testing problem demonstrated in the OrderProcessor example?",
    question_type: "multiple_choice",
    points: 15,
    correct_answer: "1",
    options: {
      choices: [
        "Tests become slower but more comprehensive",
        "You can replace real external services with fast, controlled mock objects",
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
        "It automates dependency wiring and provides lifecycle management features",
        "It eliminates the need for testing",
        "It automatically fixes code bugs"
      ]
    }
  },
  {
    question_text: "In the V8Engine update scenario, how does DI prevent application crashes?",
    question_type: "multiple_choice",
    points: 15,
    correct_answer: "2",
    options: {
      choices: [
        "DI automatically updates all dependent code",
        "DI prevents the issue entirely by keeping core business logic unchanged",
        "Changes only affect dependency creation, not the business logic that uses them",
        "DI containers handle all constructor parameter changes automatically"
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
    question_text: "True or False: DI containers should always use singleton scope for all services to improve performance.",
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

TodoWrite.new.call(todos: [
  {"id": "1", "content": "Create entirely new DI course with clean, non-repetitive content", "status": "completed", "priority": "high"},
  {"id": "2", "content": "Keep Lesson 1 content as-is since it's good", "status": "completed", "priority": "medium"},
  {"id": "3", "content": "Create clean Lesson 2 without repetitions", "status": "completed", "priority": "high"},
  {"id": "4", "content": "Create clean Lesson 3 without repetitions", "status": "completed", "priority": "high"},
  {"id": "5", "content": "Ensure proper flow and logical progression between lessons", "status": "completed", "priority": "medium"}
])

puts "\n🎉 Successfully created clean Dependency Injection course!"
puts "Course: #{clean_di_course.title}"
puts "Lessons: #{clean_di_course.lessons.count} comprehensive lessons"
puts "Content blocks: #{clean_di_course.lessons.sum { |l| l.content_blocks.count }} total"
puts "Assignment: #{assignment.assignment_questions.count} focused questions"
puts "Duration: #{clean_di_course.duration} hours"
puts "\nThis is a completely new course with no repetitions - the original course remains untouched."