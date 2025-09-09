# Enhance Dependency Injection Course with More Detailed Content
# This script adds detailed explanations to Lessons 2 and 3

course = Course.find_by(title: 'Mastering Dependency Injection: From Theory to Practice')
if course.nil?
  puts "Course not found!"
  exit
end

lesson2 = course.lessons.find_by(position: 2)
lesson3 = course.lessons.find_by(position: 3)

puts "Enhancing Lesson 2 with detailed Ruby code explanations..."

# Add detailed code analysis to Lesson 2
lesson2.content_blocks.create!(
  block_type: 'text',
  content: %{
    <h2>🔍 Deep Dive: Understanding the Car Manufacturing Code</h2>
    <p>Let's break down exactly what makes the first example problematic and how dependency injection solves each issue.</p>
    
    <h3>Analyzing the Problematic Code</h3>
    <p>In our <strong>bad example</strong>, the <code>CarManufacturer</code> class violates several fundamental programming principles:</p>
    
    <div style="background-color: #fff3e0; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
      <h4>🔍 Line-by-Line Analysis of the Problem:</h4>
      <pre><code class="ruby">
def initialize
  # These four lines are the root of our problems:
  @engine_builder = V8Engine.new          # ❌ Hard dependency on V8Engine class
  @tire_manufacturer = MichelinTires.new  # ❌ Hard dependency on MichelinTires class  
  @electronics = BasicRadio.new           # ❌ Hard dependency on BasicRadio class
  @quality_checker = BasicInspection.new  # ❌ Hard dependency on BasicInspection class
end
      </code></pre>
      
      <p><strong>Why this is problematic:</strong></p>
      <ul>
        <li><strong>Tight Coupling:</strong> CarManufacturer is permanently bound to these four specific classes</li>
        <li><strong>Hard to Test:</strong> Every test must instantiate real V8Engine, real MichelinTires, etc.</li>
        <li><strong>No Flexibility:</strong> Cannot build different types of cars (electric, hybrid, luxury, economy)</li>
        <li><strong>Violation of Open/Closed Principle:</strong> Must modify CarManufacturer to support new engine types</li>
        <li><strong>Single Point of Failure:</strong> If any dependency changes its constructor, CarManufacturer breaks</li>
      </ul>
    </div>
    
    <h3>The Hidden Costs of Tight Coupling</h3>
    <p>Consider what happens in a real development scenario with this tightly coupled code:</p>
    
    <div style="background-color: #ffebee; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
      <h4>📊 Scenario: V8Engine Class Needs an Update</h4>
      <p>Imagine the V8Engine team decides to add emissions control:</p>
      <pre><code class="ruby">
# V8Engine team updates their class
class V8Engine
  def initialize(emissions_standard)  # ⚠️ New required parameter!
    @emissions_standard = emissions_standard
  end
  
  def build_engine
    # Now includes emissions control logic
    { 
      type: "V8", 
      horsepower: 400,
      emissions: @emissions_standard 
    }
  end
end
      </code></pre>
      
      <p><strong>Impact on our CarManufacturer:</strong></p>
      <pre><code class="ruby">
def initialize
  # This line now crashes the entire application!
  @engine_builder = V8Engine.new  # ❌ ArgumentError: missing required parameter
end
      </code></pre>
      
      <p><strong>Consequences:</strong></p>
      <ul>
        <li>🚨 <strong>Application crash:</strong> All car manufacturing stops</li>
        <li>⏱️ <strong>Development delay:</strong> Must update CarManufacturer code immediately</li>
        <li>🧪 <strong>Test failures:</strong> All tests using CarManufacturer break</li>
        <li>🔄 <strong>Deployment rollback:</strong> Cannot deploy V8Engine update until CarManufacturer is fixed</li>
        <li>👥 <strong>Team coordination:</strong> V8Engine team cannot work independently</li>
      </ul>
    </div>
  },
  position: 5
)

# Add more detailed explanation of the DI solution
lesson2.content_blocks.create!(
  block_type: 'text',
  content: %{
    <h2>🎯 How Dependency Injection Solves These Problems</h2>
    <p>Now let's examine our improved solution and understand exactly how it addresses each issue:</p>
    
    <h3>The Power of Constructor Injection</h3>
    <div style="background-color: #e8f5e8; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
      <h4>✅ Analyzing the Improved Code:</h4>
      <pre><code class="ruby">
class CarManufacturer
  def initialize(engine_builder:, tire_manufacturer:, electronics:)
    # These dependencies are provided from outside - this is the key!
    @engine_builder = engine_builder        # ✅ Any object that responds to build_engine
    @tire_manufacturer = tire_manufacturer  # ✅ Any object that responds to create_tires  
    @electronics = electronics              # ✅ Any object that responds to install_system
  end
  
  def build_car(car_type)
    # This code doesn't change - it works with any implementation!
    engine = @engine_builder.build_engine
    tires = @tire_manufacturer.create_tires(4)
    radio = @electronics.install_system
    
    Car.new(engine: engine, tires: tires, electronics: radio)
  end
end
      </code></pre>
    </div>
    
    <h3>Understanding the Transformation</h3>
    <p><strong>What changed and why it matters:</strong></p>
    
    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; margin: 1rem 0;">
      <div style="padding: 1rem; background-color: #ffebee; border-radius: 8px;">
        <h4>❌ Before (Tightly Coupled)</h4>
        <ul>
          <li><code>CarManufacturer</code> creates its own dependencies</li>
          <li>Hard-coded class names throughout</li>
          <li>Cannot change implementations</li>
          <li>Testing requires real objects</li>
          <li>Changes ripple through system</li>
        </ul>
      </div>
      <div style="padding: 1rem; background-color: #e8f5e8; border-radius: 8px;">
        <h4>✅ After (Dependency Injection)</h4>
        <ul>
          <li><code>CarManufacturer</code> receives dependencies</li>
          <li>Works with any compatible object</li>
          <li>Easy to swap implementations</li>
          <li>Testing uses lightweight mocks</li>
          <li>Changes are isolated</li>
        </ul>
      </div>
    </div>
    
    <h3>Real-World Benefits in Action</h3>
    <p>Let's see how this solves our earlier V8Engine update scenario:</p>
    
    <div style="background-color: #e8f5e8; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
      <h4>🎯 Scenario Resolution: V8Engine Update with DI</h4>
      <p>When V8Engine adds the emissions parameter:</p>
      <pre><code class="ruby">
# V8Engine team updates their class (same as before)
class V8Engine
  def initialize(emissions_standard)
    @emissions_standard = emissions_standard
  end
  
  def build_engine
    { type: "V8", horsepower: 400, emissions: @emissions_standard }
  end
end

# CarManufacturer code doesn't need to change at all!
# The change happens where we create and inject the dependencies:

# Before (where we wire up the dependencies)
luxury_factory = CarManufacturer.new(
  engine_builder: V8Engine.new,  # ❌ This line needs updating
  tire_manufacturer: MichelinTires.new,
  electronics: PremiumStereo.new
)

# After (only the dependency creation changes)
luxury_factory = CarManufacturer.new(
  engine_builder: V8Engine.new("Euro6"),  # ✅ Simply add the parameter
  tire_manufacturer: MichelinTires.new,
  electronics: PremiumStereo.new
)
      </code></pre>
      
      <p><strong>Impact with DI:</strong></p>
      <ul>
        <li>✅ <strong>No application crash:</strong> CarManufacturer keeps working</li>
        <li>✅ <strong>Minimal code change:</strong> Only update dependency creation, not business logic</li>
        <li>✅ <strong>Tests still pass:</strong> Mock objects in tests are unaffected</li>
        <li>✅ <strong>Independent deployment:</strong> Teams can work separately</li>
        <li>✅ <strong>Backwards compatibility:</strong> Old and new engines can coexist</li>
      </ul>
    </div>
  },
  position: 6
)

# Add detailed explanation of the Order Processing example
lesson2.content_blocks.create!(
  block_type: 'text',
  content: %{
    <h2>📧 Deep Dive: Order Processing System Analysis</h2>
    <p>Our second example demonstrates dependency injection in a more business-focused context. Let's examine the email and payment processing challenges in detail.</p>
    
    <h3>Understanding the Business Logic Flow</h3>
    <p>First, let's trace through what our <code>OrderProcessor</code> actually does:</p>
    
    <div style="background-color: #f5f5f5; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
      <h4>🔄 Order Processing Workflow:</h4>
      <ol>
        <li><strong>Receive Order:</strong> Customer places an order with payment information</li>
        <li><strong>Process Payment:</strong> Attempt to charge the customer's payment method</li>
        <li><strong>Handle Success:</strong> Send confirmation email if payment succeeds</li>
        <li><strong>Handle Failure:</strong> Send failure notification if payment fails</li>
        <li><strong>Return Result:</strong> Let calling code know if order was processed</li>
      </ol>
    </div>
    
    <h3>The External Service Dependencies</h3>
    <p>Our order processor depends on two external services that are beyond our direct control:</p>
    
    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; margin: 1rem 0;">
      <div style="padding: 1rem; background-color: #e3f2fd; border-radius: 8px;">
        <h4>📧 Email Service Challenges</h4>
        <ul>
          <li><strong>Network dependency:</strong> Requires internet connection</li>
          <li><strong>Rate limits:</strong> Gmail/SendGrid limit emails per minute</li>
          <li><strong>Authentication:</strong> API keys, OAuth tokens can expire</li>
          <li><strong>Delivery delays:</strong> Emails may take seconds or minutes</li>
          <li><strong>Cost per email:</strong> Each email costs money</li>
        </ul>
      </div>
      <div style="padding: 1rem; background-color: #fce4ec; border-radius: 8px;">
        <h4>💳 Payment Service Challenges</h4>
        <ul>
          <li><strong>Financial risk:</strong> Real money is involved</li>
          <li><strong>Compliance:</strong> PCI DSS requirements for card data</li>
          <li><strong>Variable response time:</strong> Bank verification takes time</li>
          <li><strong>Complex error scenarios:</strong> Declined cards, expired cards, etc.</li>
          <li><strong>Transaction fees:</strong> Each charge costs money</li>
        </ul>
      </div>
    </div>
    
    <h3>Why the Tightly Coupled Version Fails</h3>
    <div style="background-color: #ffebee; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
      <h4>⚠️ Problems with Hard-Coded Dependencies:</h4>
      <pre><code class="ruby">
class OrderProcessor
  def initialize
    @email_service = GmailService.new     # ❌ Locked to Gmail
    @payment_processor = StripePayment.new # ❌ Locked to Stripe
  end
end
      </code></pre>
      
      <p><strong>Development Environment Issues:</strong></p>
      <ul>
        <li>🧪 <strong>Testing nightmare:</strong> Every test sends real emails and charges real cards</li>
        <li>💰 <strong>Expensive testing:</strong> Running test suite costs money</li>
        <li>⏱️ <strong>Slow tests:</strong> Network calls make tests take minutes instead of seconds</li>
        <li>🔄 <strong>Unreliable tests:</strong> Tests fail when Gmail is down</li>
        <li>📧 <strong>Spam problem:</strong> Test emails flood your inbox</li>
      </ul>
      
      <p><strong>Production Environment Issues:</strong></p>
      <ul>
        <li>🔒 <strong>Vendor lock-in:</strong> Cannot switch from Stripe to PayPal without code changes</li>
        <li>🔧 <strong>Difficult configuration:</strong> Cannot use different email providers for different environments</li>
        <li>🚨 <strong>Single point of failure:</strong> If Gmail changes API, entire order system breaks</li>
        <li>🌍 <strong>Regional limitations:</strong> Cannot use different payment processors for different countries</li>
      </ul>
    </div>
    
    <h3>How Dependency Injection Transforms Testing</h3>
    <p>The power of DI really shines in testing scenarios. Let's see a detailed comparison:</p>
    
    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; margin: 1rem 0;">
      <div style="padding: 1rem; background-color: #ffebee; border-radius: 8px;">
        <h4>❌ Testing Without DI</h4>
        <pre><code class="ruby">
def test_successful_order
  processor = OrderProcessor.new
  order = create_test_order
  
  # This test will:
  # - Send real email to test@example.com
  # - Charge real credit card $99.99
  # - Take 3-5 seconds to complete
  # - Fail if internet is down
  # - Cost money on each run
  
  result = processor.process_order(order)
  assert result
  
  # How do we verify email was sent?
  # How do we check email content?
  # What if payment fails for external reasons?
end
        </code></pre>
        <p><strong>Test Suite Impact:</strong></p>
        <ul>
          <li>💰 1000 tests = $1000+ in charges</li>
          <li>⏱️ Takes 1+ hours to run</li>
          <li>📧 Generates 1000s of spam emails</li>
          <li>🔄 50% failure rate due to external issues</li>
        </ul>
      </div>
      <div style="padding: 1rem; background-color: #e8f5e8; border-radius: 8px;">
        <h4>✅ Testing With DI</h4>
        <pre><code class="ruby">
def test_successful_order
  mock_email = MockEmailService.new
  mock_payment = MockPayment.new
  
  processor = OrderProcessor.new(
    email_service: mock_email,
    payment_processor: mock_payment
  )
  
  mock_payment.set_success(true)
  order = create_test_order
  
  result = processor.process_order(order)
  
  assert result
  assert_equal 1, mock_email.sent_emails.count
  assert_equal "Order Confirmed", 
               mock_email.sent_emails.first[:subject]
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
  },
  position: 7
)

puts "✅ Enhanced Lesson 2 with detailed Ruby code explanations"

puts "\nEnhancing Lesson 3 with design pattern context and detailed explanations..."

# First, add an introductory content block explaining why we're discussing design patterns
lesson3_intro = lesson3.content_blocks.create!(
  block_type: 'text',
  content: %{
    <h1>Advanced Dependency Injection: From Theory to Mastery</h1>
    <p>Now that you've seen dependency injection in action with practical Ruby examples, you might be wondering: <em>"Where does DI fit in the bigger picture of software design?"</em> This lesson connects DI to fundamental software engineering principles and shows you how to implement it professionally.</p>
    
    <h2>🤔 Why Study Design Patterns and Principles?</h2>
    <p>You've learned that dependency injection solves real problems - testing difficulties, inflexibility, and maintenance headaches. But to truly master DI, you need to understand the deeper principles that make it work.</p>
    
    <div style="background-color: #e3f2fd; padding: 1.5rem; border-left: 4px solid #2196f3; margin: 1rem 0;">
      <h3>🎯 What You'll Gain from This Advanced Study</h3>
      <ul>
        <li><strong>Theoretical Foundation:</strong> Understand WHY DI works, not just HOW to use it</li>
        <li><strong>Design Intuition:</strong> Recognize when and where to apply DI in your own projects</li>
        <li><strong>Communication Skills:</strong> Discuss DI professionally with other developers</li>
        <li><strong>Problem-Solving:</strong> Apply DI principles to solve new, unexpected challenges</li>
        <li><strong>Code Quality:</strong> Write more maintainable, professional-grade code</li>
      </ul>
    </div>
    
    <h2>🏗️ The Architecture Connection</h2>
    <p>Dependency injection isn't just a coding technique - it's part of a family of design principles that have evolved over decades of software engineering experience.</p>
    
    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 1rem; margin: 2rem 0;">
      <div style="padding: 1rem; background-color: #f3e5f5; border-radius: 8px;">
        <h4>📚 Design Principles</h4>
        <p>SOLID principles, IoC, and other foundational concepts that guide good software design</p>
      </div>
      <div style="padding: 1rem; background-color: #e8f5e8; border-radius: 8px;">
        <h4>🛠️ Design Patterns</h4>
        <p>Proven solutions to recurring problems - DI is one of many important patterns</p>
      </div>
      <div style="padding: 1rem; background-color: #fff3e0; border-radius: 8px;">
        <h4>🏛️ Architecture Patterns</h4>
        <p>How DI enables larger architectural decisions like microservices and clean architecture</p>
      </div>
      <div style="padding: 1rem; background-color: #e1f5fe; border-radius: 8px;">
        <h4>🚀 Production Practices</h4>
        <p>Professional techniques for implementing DI in real-world applications</p>
      </div>
    </div>
    
    <h2>🎪 The Big Picture</h2>
    <p>Think of this lesson as connecting the dots. You've learned to juggle individual balls (DI techniques), and now we're learning to juggle as part of a complete circus performance (software architecture).</p>
    
    <p>By the end of this lesson, you'll understand:</p>
    <ul>
      <li>How DI fits into the SOLID principles of object-oriented design</li>
      <li>What "Inversion of Control" really means and why it's revolutionary</li>
      <li>How to implement DI patterns professionally in Ruby applications</li>
      <li>When to use DI containers and how they work</li>
      <li>Production-level techniques for monitoring and maintaining DI systems</li>
    </ul>
  },
  position: 1
)

# Update existing content with more detailed explanations
lesson3.content_blocks.where(position: 1).update_all(position: 2)
lesson3.content_blocks.where(position: 2).update_all(position: 3) 
lesson3.content_blocks.where(position: 3).update_all(position: 4)
lesson3.content_blocks.where(position: 4).update_all(position: 5)

# Add detailed IoC explanation
lesson3.content_blocks.create!(
  block_type: 'text',
  content: %{
    <h2>🔄 Inversion of Control: The Revolutionary Principle</h2>
    <p>Inversion of Control (IoC) is more than just a technique - it's a fundamental shift in how we think about software design. Let's explore why it's considered one of the most important concepts in software engineering.</p>
    
    <h3>Understanding "Control" in Software</h3>
    <p>Before we can invert control, we need to understand what "control" means in the context of software:</p>
    
    <div style="background-color: #f5f5f5; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
      <h4>🎮 Types of Control in Software Systems:</h4>
      <ul>
        <li><strong>Object Creation Control:</strong> Who decides when and how objects are created?</li>
        <li><strong>Dependency Management Control:</strong> Who manages the relationships between objects?</li>
        <li><strong>Lifecycle Control:</strong> Who controls when objects are initialized, used, and destroyed?</li>
        <li><strong>Configuration Control:</strong> Who decides how objects are configured and parameterized?</li>
        <li><strong>Flow Control:</strong> Who controls the sequence of operations and method calls?</li>
      </ul>
    </div>
    
    <h3>Traditional Control: The "Pull" Model</h3>
    <p>In traditional programming, objects actively "pull" their dependencies:</p>
    
    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin: 2rem 0;">
      <div style="padding: 1.5rem; background-color: #ffebee; border-radius: 8px;">
        <h4>❌ Traditional Control Flow</h4>
        <pre><code class="ruby">
class OrderService
  def initialize
    # I control what I need
    @database = Database.connect("production")
    @email = EmailService.new("smtp.gmail.com")
    @payment = PaymentGateway.new("stripe_key")
    @logger = Logger.new("/var/log/orders.log")
  end
  
  def process_order(order)
    # I control the sequence
    @database.save(order)
    result = @payment.charge(order.amount)
    @email.send_confirmation(order) if result.success?
    @logger.info("Order processed: \#{order.id}")
  end
end
        </code></pre>
        
        <p><strong>Characteristics:</strong></p>
        <ul>
          <li>Object knows exactly what it depends on</li>
          <li>Object creates its own dependencies</li>
          <li>Object controls the configuration</li>
          <li>Object manages the lifecycle</li>
          <li>Hard-coded knowledge of implementation details</li>
        </ul>
      </div>
      
      <div style="padding: 1.5rem; background-color: #e8f5e8; border-radius: 8px;">
        <h4>✅ Inverted Control Flow</h4>
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
    # I still control my core logic
    @database.save(order)
    result = @payment.charge(order.amount)
    @email.send_confirmation(order) if result.success?
    @logger.info("Order processed: \#{order.id}")
  end
end
        </code></pre>
        
        <p><strong>Characteristics:</strong></p>
        <ul>
          <li>Object declares what it needs</li>
          <li>External entity provides dependencies</li>
          <li>External entity controls configuration</li>
          <li>External entity manages lifecycle</li>
          <li>No knowledge of implementation details</li>
        </ul>
      </div>
    </div>
    
    <h3>Why Inversion is Revolutionary</h3>
    <p>The shift from "pull" to "push" dependency management creates profound changes in software architecture:</p>
    
    <div style="background-color: #e3f2fd; padding: 1.5rem; border-left: 4px solid #2196f3; margin: 1rem 0;">
      <h4>🚀 The Revolutionary Impact of IoC:</h4>
      
      <h5>1. Separation of Concerns</h5>
      <p>Objects focus on their core responsibility instead of managing dependencies:</p>
      <ul>
        <li><strong>OrderService</strong> focuses on order processing logic</li>
        <li><strong>DatabaseService</strong> focuses on data persistence</li>
        <li><strong>EmailService</strong> focuses on communication</li>
        <li><strong>IoC Container</strong> focuses on object lifecycle and dependencies</li>
      </ul>
      
      <h5>2. Runtime vs. Compile-time Decisions</h5>
      <p>With IoC, many decisions move from compile-time to runtime:</p>
      <ul>
        <li>Which database to use (MySQL, PostgreSQL, SQLite)</li>
        <li>Which email provider to use (Gmail, SendGrid, AWS SES)</li>
        <li>Which logging level to use (debug, info, error)</li>
        <li>Which configuration to use (development, staging, production)</li>
      </ul>
      
      <h5>3. Composition Over Inheritance</h5>
      <p>IoC enables flexible object composition without complex inheritance hierarchies:</p>
      <ul>
        <li>Mix and match components</li>
        <li>Create new combinations without new classes</li>
        <li>Favor composition patterns over inheritance patterns</li>
      </ul>
    </div>
    
    <h3>IoC in Action: A Real-World Scenario</h3>
    <p>Let's see how IoC transforms a complex real-world requirement:</p>
    
    <div style="background-color: #f1f8e9; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
      <h4>📊 Business Requirement: Multi-Region Order Processing</h4>
      <p><strong>Challenge:</strong> Support orders from US, EU, and Asia with different requirements:</p>
      <ul>
        <li><strong>US:</strong> Stripe payments, SendGrid emails, USD currency, English language</li>
        <li><strong>EU:</strong> PayPal payments, Mailgun emails, EUR currency, Multi-language</li>
        <li><strong>Asia:</strong> Local payment gateways, SMS notifications, Local currencies, Local languages</li>
      </ul>
      
      <p><strong>Without IoC:</strong> Would need separate OrderService classes for each region</p>
      <p><strong>With IoC:</strong> Same OrderService, different injected dependencies per region</p>
      
      <pre><code class="ruby">
# Same OrderService works everywhere
class OrderService
  def initialize(payment_gateway:, notification_service:, currency_converter:, translator:)
    @payment_gateway = payment_gateway
    @notification_service = notification_service
    @currency_converter = currency_converter
    @translator = translator
  end
  
  # Core logic remains the same
  def process_order(order)
    local_amount = @currency_converter.convert(order.amount, order.region)
    result = @payment_gateway.charge(local_amount)
    message = @translator.translate("order_confirmed", order.language)
    @notification_service.send(order.customer, message) if result.success?
  end
end

# Different configurations for different regions
us_order_service = OrderService.new(
  payment_gateway: StripeGateway.new,
  notification_service: EmailService.new,
  currency_converter: USDConverter.new,
  translator: EnglishTranslator.new
)

eu_order_service = OrderService.new(
  payment_gateway: PayPalGateway.new,
  notification_service: MultiChannelService.new,
  currency_converter: EURConverter.new,
  translator: MultilingualTranslator.new
)
      </code></pre>
    </div>
  },
  position: 6
)

# Add detailed SOLID principles explanation
lesson3.content_blocks.create!(
  block_type: 'text',
  content: %{
    <h2>🏗️ SOLID Principles: The Foundation of Good Design</h2>
    <p>SOLID is an acronym representing five fundamental principles of object-oriented design. Understanding how DI supports these principles will make you a better software architect.</p>
    
    <h3>Why SOLID Principles Matter</h3>
    <p>These principles aren't academic theory - they solve real problems that plague software projects:</p>
    
    <div style="background-color: #fff3e0; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
      <h4>🎯 What SOLID Principles Prevent:</h4>
      <ul>
        <li><strong>Rigidity:</strong> Hard to change existing functionality</li>
        <li><strong>Fragility:</strong> Changes break unexpected parts of the system</li>
        <li><strong>Immobility:</strong> Hard to reuse code in different contexts</li>
        <li><strong>Viscosity:</strong> Easier to implement hacks than proper solutions</li>
        <li><strong>Complexity:</strong> Unnecessarily complex designs</li>
      </ul>
    </div>
    
    <h3>S - Single Responsibility Principle (SRP)</h3>
    <div style="background-color: #e8f5e8; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
      <h4>📋 Definition: A class should have only one reason to change</h4>
      
      <p><strong>What this means in practice:</strong> Each class should have one primary responsibility and all its methods should support that responsibility.</p>
      
      <h5>❌ Violation Example:</h5>
      <pre><code class="ruby">
class OrderProcessor
  def initialize
    @database = Database.new
    @email_service = EmailService.new
    @payment_gateway = PaymentGateway.new
  end
  
  def process_order(order)
    # Responsibility 1: Order processing logic
    validate_order(order)
    calculate_total(order)
    
    # Responsibility 2: Data persistence
    @database.save_order(order)
    
    # Responsibility 3: Payment processing
    payment_result = @payment_gateway.charge(order.total)
    
    # Responsibility 4: Email formatting and sending
    if payment_result.success?
      email_body = format_confirmation_email(order)
      @email_service.send(order.customer_email, "Order Confirmed", email_body)
    end
  end
  
  private
  
  # Methods mixing different responsibilities
  def validate_order(order)
    # Order validation logic
  end
  
  def format_confirmation_email(order)
    # Email formatting logic
  end
end
      </code></pre>
      
      <p><strong>Problems with this design:</strong></p>
      <ul>
        <li>Changes to email format require modifying OrderProcessor</li>
        <li>Database schema changes affect OrderProcessor</li>
        <li>Payment gateway API changes affect OrderProcessor</li>
        <li>Hard to test individual responsibilities in isolation</li>
      </ul>
      
      <h5>✅ SRP-Compliant Design with DI:</h5>
      <pre><code class="ruby">
# Each class has a single responsibility
class OrderProcessor
  def initialize(order_repository:, payment_service:, email_service:)
    @order_repository = order_repository
    @payment_service = payment_service
    @email_service = email_service
  end
  
  def process_order(order)
    # ONLY responsible for order processing orchestration
    validate_order(order)
    calculate_total(order)
    
    @order_repository.save(order)
    payment_result = @payment_service.process(order)
    @email_service.send_confirmation(order) if payment_result.success?
  end
  
  private
  
  def validate_order(order)
    # Only order validation logic here
  end
  
  def calculate_total(order)
    # Only total calculation logic here  
  end
end

# Separate classes for separate responsibilities
class OrderRepository
  def save(order)
    # ONLY responsible for order data persistence
  end
end

class PaymentService  
  def process(order)
    # ONLY responsible for payment processing
  end
end

class EmailService
  def send_confirmation(order)
    # ONLY responsible for email communication
  end
end
      </code></pre>
      
      <p><strong>Benefits of SRP with DI:</strong></p>
      <ul>
        <li>Email format changes only affect EmailService</li>
        <li>Database changes only affect OrderRepository</li>
        <li>Payment changes only affect PaymentService</li>
        <li>Each class can be tested independently</li>
        <li>Classes are smaller, more focused, and easier to understand</li>
      </ul>
    </div>
    
    <h3>O - Open/Closed Principle (OCP)</h3>
    <div style="background-color: #fff3e0; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
      <h4>📋 Definition: Classes should be open for extension, closed for modification</h4>
      
      <p><strong>What this means:</strong> You should be able to add new functionality without changing existing, working code.</p>
      
      <h5>❌ Violation Example:</h5>
      <pre><code class="ruby">
class PaymentProcessor
  def process_payment(order, payment_type)
    case payment_type
    when "credit_card"
      # Credit card processing logic
      process_credit_card(order)
    when "paypal"  
      # PayPal processing logic
      process_paypal(order)
    when "bitcoin"  # ❌ Had to modify existing class
      # Bitcoin processing logic
      process_bitcoin(order)
    end
  end
  
  # ❌ Keep adding methods to the same class
  def process_credit_card(order); end
  def process_paypal(order); end  
  def process_bitcoin(order); end  # New addition
end
      </code></pre>
      
      <p><strong>Problems:</strong> Every new payment method requires modifying PaymentProcessor class</p>
      
      <h5>✅ OCP-Compliant Design with DI:</h5>
      <pre><code class="ruby">
# Base class is closed for modification
class PaymentProcessor
  def initialize(payment_gateway:)
    @payment_gateway = payment_gateway
  end
  
  def process_payment(order)
    # This method never changes!
    @payment_gateway.charge(order.amount, order.payment_info)
  end
end

# Open for extension through new implementations
class CreditCardGateway
  def charge(amount, payment_info)
    # Credit card specific implementation
  end
end

class PayPalGateway
  def charge(amount, payment_info)
    # PayPal specific implementation
  end
end

class BitcoinGateway  # ✅ New extension - no modification of existing code
  def charge(amount, payment_info)
    # Bitcoin specific implementation
  end
end

# Usage - PaymentProcessor class never changed
credit_processor = PaymentProcessor.new(payment_gateway: CreditCardGateway.new)
paypal_processor = PaymentProcessor.new(payment_gateway: PayPalGateway.new)  
bitcoin_processor = PaymentProcessor.new(payment_gateway: BitcoinGateway.new) # New!
      </code></pre>
      
      <p><strong>Benefits of OCP with DI:</strong></p>
      <ul>
        <li>Add new payment methods without touching existing code</li>
        <li>Existing functionality can't be accidentally broken</li>
        <li>Multiple payment methods can coexist</li>
        <li>Each payment method can evolve independently</li>
      </ul>
    </div>
  },
  position: 7
)

# Add DI container and production practices
lesson3.content_blocks.create!(
  block_type: 'text',
  content: %{
    <h2>📦 Professional DI Implementation: Containers and Best Practices</h2>
    <p>Understanding DI theory is crucial, but implementing it professionally in production systems requires additional techniques and tools.</p>
    
    <h3>Why DI Containers Exist</h3>
    <p>As applications grow, manually wiring dependencies becomes complex and error-prone:</p>
    
    <div style="background-color: #ffebee; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
      <h4>⚠️ The Manual Wiring Problem:</h4>
      <pre><code class="ruby">
# Imagine wiring a complex application manually:
database = PostgreSQLDatabase.new(
  host: ENV['DB_HOST'],
  port: ENV['DB_PORT'],
  username: ENV['DB_USER'],
  password: ENV['DB_PASS']
)

redis = RedisCache.new(
  url: ENV['REDIS_URL'],
  timeout: 5
)

email_service = SendGridService.new(
  api_key: ENV['SENDGRID_KEY'],
  from_email: ENV['FROM_EMAIL']
)

payment_service = StripePayment.new(
  api_key: ENV['STRIPE_KEY'],
  webhook_secret: ENV['STRIPE_WEBHOOK']
)

user_repository = UserRepository.new(database: database, cache: redis)
order_repository = OrderRepository.new(database: database, cache: redis)
notification_service = NotificationService.new(email_service: email_service)

user_service = UserService.new(
  user_repository: user_repository,
  notification_service: notification_service
)

order_service = OrderService.new(
  order_repository: order_repository,
  user_service: user_service,
  payment_service: payment_service,
  notification_service: notification_service
)

# And this is just for a few services!
      </code></pre>
      
      <p><strong>Problems with manual wiring:</strong></p>
      <ul>
        <li>🔄 Repetitive boilerplate code</li>
        <li>🐛 Easy to make mistakes in dependency order</li>
        <li>🔧 Hard to maintain as application grows</li>
        <li>🧪 Difficult to configure differently for tests</li>
        <li>⚡ No lazy loading or lifecycle management</li>
      </ul>
    </div>
    
    <h3>Building a Production-Grade DI Container</h3>
    <p>Let's build a sophisticated DI container that handles real-world requirements:</p>
    
    <div style="background-color: #e8f5e8; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
      <h4>✅ Professional DI Container Implementation:</h4>
      <pre><code class="ruby">
class DIContainer
  def initialize
    @services = {}
    @instances = {}
    @resolving = Set.new  # Detect circular dependencies
  end
  
  # Register a service with lazy instantiation
  def register(name, scope: :transient, &factory)
    @services[name] = {
      factory: factory,
      scope: scope
    }
  end
  
  # Register a singleton service
  def singleton(name, &factory)
    register(name, scope: :singleton, &factory)
  end
  
  # Resolve a service with dependency injection
  def resolve(name)
    service_config = @services[name]
    raise "Service '\#{name}' not registered" unless service_config
    
    # Detect circular dependencies
    if @resolving.include?(name)
      raise "Circular dependency detected: \#{@resolving.to_a.join(' -> ')} -> \#{name}"
    end
    
    @resolving.add(name)
    
    begin
      case service_config[:scope]
      when :singleton
        @instances[name] ||= service_config[:factory].call(self)
      when :transient
        service_config[:factory].call(self)
      else
        raise "Unknown scope: \#{service_config[:scope]}"
      end
    ensure
      @resolving.delete(name)
    end
  end
  
  # Health check for all registered services
  def health_check
    results = {}
    
    @services.each do |name, config|
      begin
        service = resolve(name)
        if service.respond_to?(:health_check)
          results[name] = service.health_check
        else
          results[name] = { status: 'ok', message: 'No health check method' }
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
  
  # Configuration from environment
  def self.configure_from_env
    container = new
    
    # Infrastructure services (singletons)
    container.singleton(:database) do
      case ENV['DATABASE_TYPE']
      when 'postgresql'
        PostgreSQLDatabase.new(
          host: ENV['DB_HOST'],
          port: ENV['DB_PORT']&.to_i || 5432,
          database: ENV['DB_NAME'],
          username: ENV['DB_USER'],
          password: ENV['DB_PASS']
        )
      when 'sqlite'
        SQLiteDatabase.new(ENV['DB_PATH'] || 'db/development.sqlite3')
      else
        raise "Unknown database type: \#{ENV['DATABASE_TYPE']}"
      end
    end
    
    container.singleton(:cache) do
      case ENV['CACHE_TYPE']
      when 'redis'
        RedisCache.new(ENV['REDIS_URL'])
      when 'memory'
        MemoryCache.new
      else
        NullCache.new  # No-op cache for development
      end
    end
    
    container.singleton(:email_service) do |c|
      case ENV['EMAIL_PROVIDER']
      when 'sendgrid'
        SendGridService.new(ENV['SENDGRID_API_KEY'])
      when 'mailgun'
        MailgunService.new(ENV['MAILGUN_API_KEY'])
      when 'development'
        FileEmailService.new('tmp/emails')  # Save emails to files in development
      when 'test'
        MockEmailService.new
      else
        raise "Unknown email provider: \#{ENV['EMAIL_PROVIDER']}"
      end
    end
    
    # Repository services (transient - they might hold state)
    container.register(:user_repository) do |c|
      UserRepository.new(
        database: c.resolve(:database),
        cache: c.resolve(:cache)
      )
    end
    
    container.register(:order_repository) do |c|
      OrderRepository.new(
        database: c.resolve(:database),
        cache: c.resolve(:cache)
      )
    end
    
    # Business services (transient)
    container.register(:user_service) do |c|
      UserService.new(
        user_repository: c.resolve(:user_repository),
        email_service: c.resolve(:email_service)
      )
    end
    
    container.register(:order_service) do |c|
      OrderService.new(
        order_repository: c.resolve(:order_repository),
        user_service: c.resolve(:user_service),
        payment_service: c.resolve(:payment_service),
        email_service: c.resolve(:email_service)
      )
    end
    
    container
  end
end
      </code></pre>
    </div>
    
    <h3>Using the DI Container in Rails</h3>
    <p>Here's how to integrate our DI container into a Rails application:</p>
    
    <div style="background-color: #f5f5f5; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
      <h4>🚀 Rails Integration Example:</h4>
      <pre><code class="ruby">
# config/initializers/di_container.rb
Rails.application.configure do
  config.di_container = DIContainer.configure_from_env
end

# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  private
  
  def container
    Rails.application.config.di_container
  end
  
  def order_service
    container.resolve(:order_service)
  end
  
  def user_service
    container.resolve(:user_service)
  end
end

# app/controllers/orders_controller.rb
class OrdersController < ApplicationController
  def create
    result = order_service.process(order_params)
    
    if result.success?
      render json: { success: true, order_id: result.order.id }
    else
      render json: { error: result.error_message }, status: 422
    end
  end
  
  private
  
  def order_params
    params.require(:order).permit(:product_id, :quantity, :payment_token)
  end
end

# config/routes.rb
Rails.application.routes.draw do
  get '/health', to: 'health#show'
  # ... other routes
end

# app/controllers/health_controller.rb  
class HealthController < ApplicationController
  def show
    health_result = container.health_check
    
    status_code = health_result[:overall] ? 200 : 503
    render json: health_result, status: status_code
  end
end
      </code></pre>
    </div>
    
    <h3>Testing with the DI Container</h3>
    <p>Professional DI containers make testing much easier:</p>
    
    <div style="background-color: #e3f2fd; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
      <h4>🧪 Test-Friendly Container Configuration:</h4>
      <pre><code class="ruby">
# test/support/test_container.rb
class TestContainer
  def self.build
    container = DIContainer.new
    
    # Use fast, in-memory implementations for testing
    container.singleton(:database) { InMemoryDatabase.new }
    container.singleton(:cache) { MockCache.new }
    container.singleton(:email_service) { MockEmailService.new }
    container.singleton(:payment_service) { MockPaymentService.new }
    
    # Real repository and service implementations
    container.register(:user_repository) do |c|
      UserRepository.new(
        database: c.resolve(:database),
        cache: c.resolve(:cache)
      )
    end
    
    container.register(:order_service) do |c|
      OrderService.new(
        order_repository: c.resolve(:order_repository),
        payment_service: c.resolve(:payment_service),
        email_service: c.resolve(:email_service)
      )
    end
    
    container
  end
end

# test/controllers/orders_controller_test.rb
class OrdersControllerTest < ActionController::TestCase
  def setup
    @original_container = Rails.application.config.di_container
    Rails.application.config.di_container = TestContainer.build
  end
  
  def teardown
    Rails.application.config.di_container = @original_container
  end
  
  def test_successful_order_creation
    post :create, params: { 
      order: { product_id: 1, quantity: 2, payment_token: "test_token" }
    }
    
    assert_response :success
    
    # Verify mock services were called
    email_service = Rails.application.config.di_container.resolve(:email_service)
    assert_equal 1, email_service.sent_emails.count
  end
end
      </code></pre>
    </div>
  },
  position: 8
)

puts "✅ Enhanced Lesson 3 with detailed explanations and context"

puts "\n🎉 Course enhancement complete!"
puts "Added detailed explanations to both Lesson 2 and Lesson 3"
puts "Lesson 2: Enhanced with deep code analysis and real-world scenarios"
puts "Lesson 3: Added design pattern context and comprehensive concept explanations"