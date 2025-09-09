# Focused Dependency Injection Course with Detailed Ruby Examples
# A practical, focused course covering DI fundamentals with comprehensive code examples

# Find or create instructor user
instructor = User.where(role: 'instructor').first
if instructor.nil?
  instructor = User.create!(
    email: 'focused.di.instructor@example.com',
    password: 'password123',
    password_confirmation: 'password123',
    role: 'instructor',
    name: 'Alex Johnson'
  )
end

# Create Focused Dependency Injection Course
focused_di_course = Course.create!(
  title: 'Mastering Dependency Injection: From Theory to Practice',
  description: 'A focused, practical course that teaches dependency injection through real Ruby code examples. Learn the fundamentals, see the problems DI solves, and master implementation with car manufacturing and restaurant systems.',
  duration: 6, # 6 hours total - more focused
  instructor: instructor,
  published: true
)

puts "✅ Created focused DI course: #{focused_di_course.title}"
puts "Course ID: #{focused_di_course.id}"

# Create 3 comprehensive, detailed lessons
lessons_data = [
  {
    title: 'Understanding Dependency Injection: Theory and Real-World Examples',
    content: 'Complete introduction to dependency injection with car manufacturing and restaurant examples, covering the theory behind DI.',
    position: 1
  },
  {
    title: 'Ruby Code Examples: Problems Without DI and Solutions With DI',
    content: 'Detailed Ruby code examples showing real problems solved by dependency injection, with before and after comparisons.',
    position: 2
  },
  {
    title: 'Advanced Concepts: Inversion of Control, Design Patterns, and Best Practices',
    content: 'Deep dive into IoC principles, SOLID design patterns, testing strategies, and production implementation best practices.',
    position: 3
  }
]

created_lessons = []
lessons_data.each do |lesson_data|
  lesson = focused_di_course.lessons.create!(lesson_data)
  created_lessons << lesson
  puts "✅ Created lesson #{lesson.position}: #{lesson.title}"
end

puts "\n📝 Adding comprehensive content blocks to lessons..."

# Lesson 1: Understanding Dependency Injection with Real Examples
lesson1 = created_lessons[0]
lesson1.content_blocks.create!([
  {
    block_type: "text",
    content: "<h1>Understanding Dependency Injection: Theory and Real-World Examples</h1><p>Dependency Injection (DI) is one of the most important design patterns in software development. This lesson will teach you exactly what it is, why it matters, and how it works through practical examples you can relate to.</p><div style='background-color: #e3f2fd; padding: 1.5rem; border-left: 4px solid #2196f3; margin: 1rem 0;'><h3>🎯 Learning Objectives</h3><ul><li>Understand what dependencies are and why they matter</li><li>Learn the core principles of dependency injection</li><li>See real-world examples through car manufacturing and restaurant systems</li><li>Identify problems that DI solves in software development</li></ul></div>",
    position: 1
  },
  {
    block_type: "text", 
    content: "<h2>What is a Dependency?</h2><p>Before understanding dependency injection, we need to understand dependencies themselves.</p><div style='background-color: #f5f5f5; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;'><h3>📋 Definition: Dependency</h3><p><strong>A dependency is something that your object/class needs to function properly.</strong></p></div><p>Think of dependencies like ingredients in cooking:</p><ul><li>🍝 <strong>To make pasta:</strong> You depend on noodles, sauce, and water</li><li>🚗 <strong>To build a car:</strong> You depend on an engine, wheels, transmission, and electronics</li><li>💻 <strong>In software:</strong> Your class depends on other classes, databases, APIs, or services</li></ul>",
    position: 2
  },
  {
    block_type: "image",
    file_url: "https://images.unsplash.com/photo-1558618047-3c8c76ca7d13?w=800&h=500&fit=crop",
    alt_text: "Car manufacturing assembly line showing complex dependencies",
    position: 3
  },
  {
    block_type: "text",
    content: "<h2>🚗 Car Manufacturing Example: Understanding Dependencies</h2><p>Let's use car manufacturing to understand how dependencies work in the real world:</p><h3>Traditional Car Assembly (Without DI)</h3><div style='background-color: #ffebee; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;'><h4>❌ The Old Way - Each Worker Builds Everything</h4><p>Imagine if each car assembly worker had to:</p><ul><li><strong>Build their own engine</strong> from scratch</li><li><strong>Manufacture their own tires</strong> from raw rubber</li><li><strong>Create their own electronics</strong> from silicon chips</li><li><strong>Forge their own tools</strong> for assembly</li></ul><h4>Problems with this approach:</h4><ul><li>⏱️ <strong>Extremely slow:</strong> Each worker spends 90% of time making parts, 10% assembling cars</li><li>💰 <strong>Expensive:</strong> Duplicate equipment and materials for each worker</li><li>🔧 <strong>Inconsistent quality:</strong> Each worker's engine performs differently</li><li>📚 <strong>Impossible to maintain:</strong> If engine design changes, every worker must learn new process</li><li>🧪 <strong>Can't test assembly:</strong> Must build real engines to test car assembly process</li></ul></div>",
    position: 4
  },
  {
    block_type: "text",
    content: "<h3>Modern Car Assembly (With DI Principles)</h3><div style='background-color: #e8f5e8; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;'><h4>✅ The Smart Way - Dependencies are Provided</h4><p>In modern car manufacturing:</p><ul><li><strong>Engine specialists</strong> build engines in dedicated facilities</li><li><strong>Tire specialists</strong> manufacture tires optimized for different cars</li><li><strong>Electronics specialists</strong> create infotainment and control systems</li><li><strong>Assembly workers</strong> focus only on putting pieces together</li></ul><h4>Benefits of this approach:</h4><ul><li>⚡ <strong>Fast and efficient:</strong> Each specialist focuses on their expertise</li><li>💰 <strong>Cost effective:</strong> Shared resources, bulk production</li><li>🎯 <strong>Consistent quality:</strong> Specialized teams perfect their components</li><li>🔄 <strong>Easy updates:</strong> Engine improvements automatically benefit all car models</li><li>🧪 <strong>Easy testing:</strong> Can test assembly with mock engines or different engine types</li><li>🔀 <strong>Flexibility:</strong> Different car models can use different engines without changing assembly process</li></ul></div>",
    position: 5
  },
  {
    block_type: "text",
    content: "<h2>🍽️ Restaurant System: Another Real-World Example</h2><p>Let's see how the same principles apply to restaurant management:</p><div style='display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin: 2rem 0;'><div style='padding: 1.5rem; background-color: #ffebee; border-radius: 8px;'><h3>❌ Without DI</h3><h4>Each Waiter Manages Everything:</h4><ul><li>Creates own menu with prices</li><li>Sets up own payment system</li><li>Manages own inventory tracking</li><li>Builds own communication system with kitchen</li></ul><h4>Problems:</h4><ul><li>Inconsistent pricing</li><li>Duplicate systems</li><li>Hard to train new staff</li><li>Difficult to update processes</li></ul></div><div style='padding: 1.5rem; background-color: #e8f5e8; border-radius: 8px;'><h3>✅ With DI</h3><h4>Restaurant Provides Shared Services:</h4><ul><li>Central menu system for all waiters</li><li>Shared payment processing</li><li>Unified inventory management</li><li>Common kitchen communication system</li></ul><h4>Benefits:</h4><ul><li>Consistent customer experience</li><li>Cost-effective operations</li><li>Easy staff training</li><li>Simple system updates</li></ul></div></div>",
    position: 6
  },
  {
    block_type: "text",
    content: "<h2>🔗 Connecting to Software Development</h2><p>These real-world principles directly apply to software:</p><table style='width: 100%; border-collapse: collapse; margin: 2rem 0;'><thead><tr style='background-color: #f5f5f5;'><th style='padding: 1rem; border: 1px solid #ddd; text-align: left;'>Real World</th><th style='padding: 1rem; border: 1px solid #ddd; text-align: left;'>Software Equivalent</th><th style='padding: 1rem; border: 1px solid #ddd; text-align: left;'>Purpose</th></tr></thead><tbody><tr><td style='padding: 1rem; border: 1px solid #ddd;'>Car Assembly Worker</td><td style='padding: 1rem; border: 1px solid #ddd;'>Ruby Class/Controller</td><td style='padding: 1rem; border: 1px solid #ddd;'>Coordinates main functionality</td></tr><tr style='background-color: #f9f9f9;'><td style='padding: 1rem; border: 1px solid #ddd;'>Engine Supplier</td><td style='padding: 1rem; border: 1px solid #ddd;'>Service Class</td><td style='padding: 1rem; border: 1px solid #ddd;'>Provides specific business logic</td></tr><tr><td style='padding: 1rem; border: 1px solid #ddd;'>Parts Warehouse</td><td style='padding: 1rem; border: 1px solid #ddd;'>Database/Repository</td><td style='padding: 1rem; border: 1px solid #ddd;'>Stores and retrieves data</td></tr><tr style='background-color: #f9f9f9;'><td style='padding: 1rem; border: 1px solid #ddd;'>Quality Control</td><td style='padding: 1rem; border: 1px solid #ddd;'>Validation Service</td><td style='padding: 1rem; border: 1px solid #ddd;'>Ensures data integrity</td></tr><tr><td style='padding: 1rem; border: 1px solid #ddd;'>Factory Manager</td><td style='padding: 1rem; border: 1px solid #ddd;'>DI Container</td><td style='padding: 1rem; border: 1px solid #ddd;'>Provides dependencies to objects</td></tr></tbody></table>",
    position: 7
  },
  {
    block_type: "text",
    content: "<h2>📋 Formal Definition of Dependency Injection</h2><div style='background-color: #e3f2fd; padding: 2rem; border-left: 5px solid #2196f3; margin: 2rem 0;'><h3>🎯 Dependency Injection is:</h3><p><strong>A design pattern where objects receive their dependencies from external sources rather than creating them internally.</strong></p><h4>Key Components:</h4><ul><li><strong>Client:</strong> The object that needs dependencies (car assembly worker)</li><li><strong>Service:</strong> The dependency that provides functionality (engine, payment system)</li><li><strong>Injector:</strong> The system that provides the service to the client (factory manager, restaurant owner)</li></ul></div><h3>🔄 Three Types of Dependency Injection:</h3><ol><li><strong>Constructor Injection:</strong> Dependencies provided when object is created (most common)</li><li><strong>Setter Injection:</strong> Dependencies provided through setter methods</li><li><strong>Interface Injection:</strong> Dependencies provided through interface methods (rarely used)</li></ol>",
    position: 8
  },
  {
    block_type: "text",
    content: "<h2>🎯 Core Benefits of Dependency Injection</h2><div style='display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 1rem; margin: 2rem 0;'><div style='padding: 1rem; background-color: #e8f5e8; border-radius: 8px;'><h4>🧪 Testability</h4><p>Easy to replace real dependencies with mock objects for testing. Test your car assembly process with fake engines!</p></div><div style='padding: 1rem; background-color: #fff3e0; border-radius: 8px;'><h4>🔄 Flexibility</h4><p>Switch implementations without changing client code. Use different engines for different car models!</p></div><div style='padding: 1rem; background-color: #f3e5f5; border-radius: 8px;'><h4>🛠 Maintainability</h4><p>Changes to dependencies don't affect clients. Engine improvements automatically benefit all cars!</p></div><div style='padding: 1rem; background-color: #e1f5fe; border-radius: 8px;'><h4>🎯 Separation of Concerns</h4><p>Each class focuses on its primary responsibility. Assembly workers focus on assembly, not engine building!</p></div><div style='padding: 1rem; background-color: #fce4ec; border-radius: 8px;'><h4>🔀 Loose Coupling</h4><p>Reduced interdependence between components. Changes in one area don't break others!</p></div><div style='padding: 1rem; background-color: #f1f8e9; border-radius: 8px;'><h4>📦 Reusability</h4><p>Dependencies can be shared across multiple clients. One payment system serves all waiters!</p></div></div>",
    position: 9
  }
])

puts "✅ Added comprehensive content to Lesson 1"

# Lesson 2: Ruby Code Examples showing problems and solutions
lesson2 = created_lessons[1]
lesson2.content_blocks.create!([
  {
    block_type: "text",
    content: "<h1>Ruby Code Examples: Problems Without DI and Solutions With DI</h1><p>Now let's see dependency injection in action with real Ruby code. We'll look at three practical examples: a car manufacturing system, an order processing system, and an email notification system. Each example shows the problems without DI and the elegant solutions with DI.</p><div style='background-color: #e3f2fd; padding: 1.5rem; border-left: 4px solid #2196f3; margin: 1rem 0;'><h3>🎯 What You'll Learn</h3><ul><li>Real Ruby code showing DI problems and solutions</li><li>How to identify tight coupling in your code</li><li>Practical techniques for implementing DI in Ruby</li><li>Testing strategies with dependency injection</li></ul></div>",
    position: 1
  },
  {
    block_type: "text",
    content: "<h2>🚗 Example 1: Car Manufacturing System</h2><h3>❌ Without Dependency Injection (Problematic Code)</h3><p>Here's how most developers initially write code - with tight coupling:</p><pre><code class='ruby'># BAD EXAMPLE - Tight Coupling\nclass CarManufacturer\n  def initialize\n    # Creating dependencies internally - this is the problem!\n    @engine_builder = V8Engine.new\n    @tire_manufacturer = MichelinTires.new  \n    @electronics = BasicRadio.new\n    @quality_checker = BasicInspection.new\n  end\n  \n  def build_car(car_type)\n    puts \"Building \#{car_type}...\"\n    \n    # Using hardcoded dependencies\n    engine = @engine_builder.build_engine\n    tires = @tire_manufacturer.create_tires(4)\n    radio = @electronics.install_system\n    \n    # Quality check\n    @quality_checker.inspect_car(engine, tires, radio)\n    \n    Car.new(engine: engine, tires: tires, electronics: radio)\n  end\nend\n\n# Supporting classes (tightly coupled)\nclass V8Engine\n  def build_engine\n    puts \"Building V8 engine with 400HP\"\n    { type: \"V8\", horsepower: 400 }\n  end\nend\n\nclass MichelinTires\n  def create_tires(count)\n    puts \"Creating \#{count} Michelin performance tires\"\n    Array.new(count, { brand: \"Michelin\", type: \"Performance\" })\n  end\nend\n\nclass BasicRadio\n  def install_system\n    puts \"Installing basic AM/FM radio\"\n    { type: \"Basic Radio\", features: [\"AM\", \"FM\"] }\n  end\nend\n\nclass BasicInspection\n  def inspect_car(engine, tires, radio)\n    puts \"Basic inspection: Engine OK, Tires OK, Radio OK\"\n    true\n  end\nend\n\n# Usage\nfactory = CarManufacturer.new\nsedan = factory.build_car(\"Sedan\")\n</code></pre>",
    position: 2
  },
  {
    block_type: "text",
    content: '<h3>🚨 Problems with the Above Code</h3><div style="background-color: #ffebee; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;"><h4>1. 🧪 Testing Nightmare</h4><pre><code class="ruby"># How do you test this? You can\'t!\nclass TestCarManufacturer < Minitest::Test\n  def test_build_car\n    factory = CarManufacturer.new\n    car = factory.build_car("Sedan")\n    \n    # ❌ This test will:\n    # - Actually create a real V8Engine (slow/expensive)\n    # - Order real Michelin tires (external API calls)\n    # - Install real radio system (hardware dependencies)\n    # - Run real quality inspection (might fail for external reasons)\n    \n    # You can\'t test JUST the car building logic!\n  end\nend</code></pre></div><div style="background-color: #fff3e0; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;"><h4>2. 🔒 Vendor Lock-in</h4><pre><code class="ruby"># What if you want to support different engines?\n# You\'d have to modify CarManufacturer class every time!\n\nclass CarManufacturer\n  def initialize(engine_type = "v8")\n    case engine_type\n    when "v8"\n      @engine_builder = V8Engine.new      # ❌ Hardcoded\n    when "electric"\n      @engine_builder = ElectricMotor.new # ❌ Hardcoded  \n    when "hybrid"\n      @engine_builder = HybridSystem.new  # ❌ Hardcoded\n    end\n    # This violates Open/Closed Principle!\n  end\nend</code></pre></div><div style="background-color: #f3e5f5; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;"><h4>3. 🛠 Maintenance Hell</h4><pre><code class="ruby"># If V8Engine constructor changes, CarManufacturer breaks\nclass V8Engine\n  def initialize(displacement, fuel_type) # ❌ Added parameters\n    @displacement = displacement\n    @fuel_type = fuel_type\n  end\nend\n\n# Now CarManufacturer.new crashes because:\n# @engine_builder = V8Engine.new # ❌ Missing required parameters\n</code></pre></div>',
    position: 3
  },
  {
    block_type: "text",
    content: "<h3>✅ With Dependency Injection (Clean Solution)</h3><p>Here's the same functionality using dependency injection:</p><pre><code class='ruby'># GOOD EXAMPLE - Dependency Injection\nclass CarManufacturer\n  def initialize(engine_builder:, tire_manufacturer:, electronics:, quality_checker:)\n    # Dependencies are injected, not created internally\n    @engine_builder = engine_builder\n    @tire_manufacturer = tire_manufacturer\n    @electronics = electronics\n    @quality_checker = quality_checker\n  end\n  \n  def build_car(car_type)\n    puts \"Building #{car_type}...\"\n    \n    # Using injected dependencies - same interface, different implementations\n    engine = @engine_builder.build_engine\n    tires = @tire_manufacturer.create_tires(4)\n    radio = @electronics.install_system\n    \n    # Quality check with injected checker\n    @quality_checker.inspect_car(engine, tires, radio)\n    \n    Car.new(engine: engine, tires: tires, electronics: radio)\n  end\nend\n\n# Multiple implementations can now be used\nclass V8Engine\n  def build_engine\n    puts \"Building V8 engine with 400HP\"\n    { type: \"V8\", horsepower: 400 }\n  end\nend\n\nclass ElectricMotor\n  def build_engine\n    puts \"Building electric motor with 500HP instant torque\"\n    { type: \"Electric\", horsepower: 500, torque: \"instant\" }\n  end\nend\n\nclass MichelinTires\n  def create_tires(count)\n    puts \"Creating #{count} Michelin performance tires\"\n    Array.new(count, { brand: \"Michelin\", type: \"Performance\" })\n  end\nend\n\nclass BridgestoneTires\n  def create_tires(count)\n    puts \"Creating #{count} Bridgestone eco tires\"\n    Array.new(count, { brand: \"Bridgestone\", type: \"Eco\" })\n  end\nend\n\n# Usage - Now we can mix and match!\nluxury_factory = CarManufacturer.new(\n  engine_builder: V8Engine.new,\n  tire_manufacturer: MichelinTires.new,\n  electronics: PremiumStereo.new,\n  quality_checker: PremiumInspection.new\n)\n\neco_factory = CarManufacturer.new(\n  engine_builder: ElectricMotor.new,\n  tire_manufacturer: BridgestoneTires.new,\n  electronics: BasicRadio.new,\n  quality_checker: BasicInspection.new\n)\n\nluxury_sedan = luxury_factory.build_car(\"Luxury Sedan\")\neco_car = eco_factory.build_car(\"Eco Car\")\n</code></pre>",
    position: 4
  },
  {
    block_type: "text",
    content: "<h3>🧪 Easy Testing with Dependency Injection</h3><pre><code class='ruby'># Now testing is easy!\nclass TestCarManufacturer < Minitest::Test\n  def test_build_car_with_mocks\n    # Create mock dependencies for testing\n    mock_engine = MockEngine.new\n    mock_tires = MockTires.new\n    mock_electronics = MockElectronics.new\n    mock_quality = MockQuality.new\n    \n    # Inject the mocks\n    factory = CarManufacturer.new(\n      engine_builder: mock_engine,\n      tire_manufacturer: mock_tires,\n      electronics: mock_electronics,\n      quality_checker: mock_quality\n    )\n    \n    # Test the car building logic in isolation\n    car = factory.build_car(\"Test Car\")\n    \n    # Verify interactions without external dependencies\n    assert_equal \"Mock Engine\", car.engine[:type]\n    assert_equal 4, car.tires.length\n    assert mock_quality.inspection_called\n  end\nend\n\n# Mock classes for testing\nclass MockEngine\n  def build_engine\n    { type: \"Mock Engine\", horsepower: 100 }\n  end\nend\n\nclass MockTires\n  def create_tires(count)\n    Array.new(count, { brand: \"Mock\", type: \"Test\" })\n  end\nend\n\nclass MockElectronics\n  def install_system\n    { type: \"Mock Radio\" }\n  end\nend\n\nclass MockQuality\n  attr_reader :inspection_called\n  \n  def inspect_car(engine, tires, radio)\n    @inspection_called = true\n    true\n  end\nend\n</code></pre>",
    position: 5
  },
  {
    block_type: "text",
    content: "<h2>📧 Example 2: Order Processing with Email Notifications</h2><h3>❌ Without Dependency Injection</h3><pre><code class='ruby'># BAD EXAMPLE - Tight Coupling\nclass OrderProcessor\n  def initialize\n    # Hard-coded email service - problematic!\n    @email_service = GmailService.new\n    @payment_processor = StripePayment.new\n    @inventory = DatabaseInventory.new\n  end\n  \n  def process_order(order)\n    # Check inventory\n    unless @inventory.available?(order.product_id, order.quantity)\n      @email_service.send_email(\n        to: order.customer_email,\n        subject: \"Order Failed - Out of Stock\",\n        body: \"Sorry, #{order.product_name} is out of stock.\"\n      )\n      return false\n    end\n    \n    # Process payment\n    payment_result = @payment_processor.charge(\n      amount: order.total,\n      card_token: order.card_token\n    )\n    \n    unless payment_result.success?\n      @email_service.send_email(\n        to: order.customer_email,\n        subject: \"Payment Failed\",\n        body: \"Your payment could not be processed: #{payment_result.error}\"\n      )\n      return false\n    end\n    \n    # Update inventory\n    @inventory.reduce_stock(order.product_id, order.quantity)\n    \n    # Send success email\n    @email_service.send_email(\n      to: order.customer_email,\n      subject: \"Order Confirmed!\",\n      body: \"Your order for #{order.product_name} has been confirmed!\"\n    )\n    \n    true\n  end\nend\n\nclass GmailService\n  def send_email(to:, subject:, body:)\n    puts \"Sending email via Gmail to #{to}: #{subject}\"\n    # Real Gmail API call here - slow and requires internet!\n    sleep(2) # Simulating API call\n  end\nend\n</code></pre>",
    position: 6
  },
  {
    block_type: "text",
    content: "<h3>🚨 Problems with Tight Coupling</h3><div style='background-color: #ffebee; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;'><h4>Testing Problems:</h4><pre><code class='ruby'># This test has major problems!\nclass TestOrderProcessor < Minitest::Test\n  def test_process_order\n    processor = OrderProcessor.new\n    order = create_test_order\n    \n    # ❌ This test will:\n    # - Make real Gmail API calls (slow, requires internet)\n    # - Charge real credit cards via Stripe (expensive!)\n    # - Hit real database (requires setup, data cleanup)\n    # - Fail if Gmail is down (unreliable)\n    # - Send spam emails during testing\n    \n    result = processor.process_order(order)\n    assert result\n  end\nend</code></pre></div>",
    position: 7
  },
  {
    block_type: "text",
    content: "<h3>✅ With Dependency Injection (Clean Solution)</h3><pre><code class='ruby'># GOOD EXAMPLE - Clean dependency injection\nclass OrderProcessor\n  def initialize(email_service:, payment_processor:, inventory:)\n    @email_service = email_service\n    @payment_processor = payment_processor\n    @inventory = inventory\n  end\n  \n  def process_order(order)\n    # Check inventory\n    unless @inventory.available?(order.product_id, order.quantity)\n      @email_service.send_email(\n        to: order.customer_email,\n        subject: \"Order Failed - Out of Stock\",\n        body: \"Sorry, #{order.product_name} is out of stock.\"\n      )\n      return false\n    end\n    \n    # Process payment\n    payment_result = @payment_processor.charge(\n      amount: order.total,\n      card_token: order.card_token\n    )\n    \n    unless payment_result.success?\n      @email_service.send_email(\n        to: order.customer_email,\n        subject: \"Payment Failed\",\n        body: \"Your payment could not be processed: #{payment_result.error}\"\n      )\n      return false\n    end\n    \n    # Update inventory\n    @inventory.reduce_stock(order.product_id, order.quantity)\n    \n    # Send success email\n    @email_service.send_email(\n      to: order.customer_email,\n      subject: \"Order Confirmed!\",\n      body: \"Your order for #{order.product_name} has been confirmed!\"\n    )\n    \n    true\n  end\nend\n\n# Multiple email service implementations\nclass GmailService\n  def send_email(to:, subject:, body:)\n    # Real Gmail implementation\n    puts \"Sending via Gmail to #{to}: #{subject}\"\n  end\nend\n\nclass SendGridService\n  def send_email(to:, subject:, body:)\n    # SendGrid implementation\n    puts \"Sending via SendGrid to #{to}: #{subject}\"\n  end\nend\n\nclass MockEmailService\n  attr_reader :sent_emails\n  \n  def initialize\n    @sent_emails = []\n  end\n  \n  def send_email(to:, subject:, body:)\n    @sent_emails << { to: to, subject: subject, body: body }\n    puts \"Mock: Email logged for #{to}\"\n  end\nend\n\n# Usage in production\nproduction_processor = OrderProcessor.new(\n  email_service: GmailService.new,\n  payment_processor: StripePayment.new,\n  inventory: DatabaseInventory.new\n)\n\n# Usage in testing\ntest_processor = OrderProcessor.new(\n  email_service: MockEmailService.new,\n  payment_processor: MockPayment.new,\n  inventory: MockInventory.new\n)\n</code></pre>",
    position: 8
  },
  {
    block_type: "text",
    content: "<h3>🧪 Perfect Testing with Mocks</h3><pre><code class='ruby'># Now testing is fast, reliable, and controlled!\nclass TestOrderProcessor < Minitest::Test\n  def setup\n    @mock_email = MockEmailService.new\n    @mock_payment = MockPayment.new\n    @mock_inventory = MockInventory.new\n    \n    @processor = OrderProcessor.new(\n      email_service: @mock_email,\n      payment_processor: @mock_payment,\n      inventory: @mock_inventory\n    )\n  end\n  \n  def test_successful_order\n    order = create_test_order\n    @mock_inventory.set_available(true)\n    @mock_payment.set_success(true)\n    \n    result = @processor.process_order(order)\n    \n    assert result\n    assert_equal 1, @mock_email.sent_emails.length\n    assert_includes @mock_email.sent_emails.first[:subject], \"Confirmed\"\n  end\n  \n  def test_out_of_stock_scenario\n    order = create_test_order\n    @mock_inventory.set_available(false) # Simulate out of stock\n    \n    result = @processor.process_order(order)\n    \n    refute result\n    assert_equal 1, @mock_email.sent_emails.length\n    assert_includes @mock_email.sent_emails.first[:subject], \"Out of Stock\"\n  end\n  \n  def test_payment_failure_scenario\n    order = create_test_order\n    @mock_inventory.set_available(true)\n    @mock_payment.set_success(false) # Simulate payment failure\n    \n    result = @processor.process_order(order)\n    \n    refute result\n    assert_equal 1, @mock_email.sent_emails.length\n    assert_includes @mock_email.sent_emails.first[:subject], \"Payment Failed\"\n  end\nend\n\n# Mock implementations for testing\nclass MockPayment\n  def initialize\n    @success = true\n  end\n  \n  def set_success(success)\n    @success = success\n  end\n  \n  def charge(amount:, card_token:)\n    if @success\n      OpenStruct.new(success?: true)\n    else\n      OpenStruct.new(success?: false, error: \"Card declined\")\n    end\n  end\nend\n\nclass MockInventory\n  def initialize\n    @available = true\n  end\n  \n  def set_available(available)\n    @available = available\n  end\n  \n  def available?(product_id, quantity)\n    @available\n  end\n  \n  def reduce_stock(product_id, quantity)\n    # Mock implementation - just log the action\n  end\nend\n</code></pre>",
    position: 9
  },
  {
    block_type: "text",
    content: "<h2>🍽️ Example 3: Restaurant Order System</h2><h3>❌ Without Dependency Injection</h3><pre><code class='ruby'># BAD EXAMPLE - Tight coupling in restaurant system\nclass RestaurantOrder\n  def initialize(customer_name, table_number)\n    @customer_name = customer_name\n    @table_number = table_number\n    @items = []\n    \n    # Hard-coded dependencies - this is the problem!\n    @menu = PizzaMenu.new          # Only works with pizza!\n    @kitchen = ItalianKitchen.new  # Only Italian food!\n    @payment = CashRegister.new    # Only cash payments!\n    @notification = WaiterNotification.new # Only waiter alerts!\n  end\n  \n  def add_item(item_name, quantity = 1)\n    item = @menu.find_item(item_name)\n    if item.nil?\n      puts \"#{item_name} not available\"\n      return false\n    end\n    \n    @items << { item: item, quantity: quantity }\n    puts \"Added #{quantity} #{item_name} to order\"\n    true\n  end\n  \n  def submit_order\n    total = calculate_total\n    \n    # Send to kitchen\n    ticket = @kitchen.create_ticket(@items, @table_number)\n    \n    # Process payment\n    payment_result = @payment.charge(total)\n    unless payment_result\n      puts \"Payment failed\"\n      return false\n    end\n    \n    # Notify when ready\n    @notification.alert_ready(@table_number, @customer_name)\n    \n    puts \"Order submitted for table #{@table_number}\"\n    ticket\n  end\n  \n  private\n  \n  def calculate_total\n    @items.sum { |item_data| item_data[:item][:price] * item_data[:quantity] }\n  end\nend\n\n# Tightly coupled implementations\nclass PizzaMenu\n  def find_item(name)\n    menu = {\n      \"Margherita\" => { name: \"Margherita\", price: 12.99 },\n      \"Pepperoni\" => { name: \"Pepperoni\", price: 14.99 }\n    }\n    menu[name]\n  end\nend\n\nclass ItalianKitchen\n  def create_ticket(items, table_number)\n    puts \"Italian Kitchen: Preparing #{items.length} items for table #{table_number}\"\n    \"ITALIAN-#{table_number}-#{Time.now.to_i}\"\n  end\nend\n\n# Usage - very limited!\norder = RestaurantOrder.new(\"John\", 5)\norder.add_item(\"Margherita\", 2)\norder.submit_order\n</code></pre>",
    position: 10
  },
  {
    block_type: "text",
    content: "<h3>🚨 Problems with Restaurant Code</h3><div style='background-color: #ffebee; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;'><ul><li>❌ <strong>Limited to pizza:</strong> Can't handle burgers, sushi, or other cuisines</li><li>❌ <strong>Single payment method:</strong> No credit cards, mobile payments, or restaurant tabs</li><li>❌ <strong>One kitchen style:</strong> Can't support different cooking processes</li><li>❌ <strong>Fixed notifications:</strong> Can't send SMS, mobile app alerts, or kitchen displays</li><li>❌ <strong>Impossible to test:</strong> Must have real menu, kitchen, and payment system</li><li>❌ <strong>Hard to maintain:</strong> Menu changes break the order system</li></ul></div>",
    position: 11
  },
  {
    block_type: "text",
    content: "<h3>✅ With Dependency Injection (Flexible Solution)</h3><pre><code class='ruby'># GOOD EXAMPLE - Flexible restaurant system with DI\nclass RestaurantOrder\n  def initialize(customer_name, table_number, menu:, kitchen:, payment:, notification:)\n    @customer_name = customer_name\n    @table_number = table_number\n    @items = []\n    \n    # Dependencies injected - now flexible!\n    @menu = menu\n    @kitchen = kitchen\n    @payment = payment\n    @notification = notification\n  end\n  \n  def add_item(item_name, quantity = 1)\n    item = @menu.find_item(item_name)\n    if item.nil?\n      puts \"#{item_name} not available\"\n      return false\n    end\n    \n    @items << { item: item, quantity: quantity }\n    puts \"Added #{quantity} #{item_name} to order\"\n    true\n  end\n  \n  def submit_order\n    total = calculate_total\n    \n    # Send to kitchen (any kitchen type)\n    ticket = @kitchen.create_ticket(@items, @table_number)\n    \n    # Process payment (any payment method)\n    payment_result = @payment.charge(total)\n    unless payment_result\n      puts \"Payment failed\"\n      return false\n    end\n    \n    # Notify when ready (any notification method)\n    @notification.alert_ready(@table_number, @customer_name)\n    \n    puts \"Order submitted for table #{@table_number}\"\n    ticket\n  end\n  \n  private\n  \n  def calculate_total\n    @items.sum { |item_data| item_data[:item][:price] * item_data[:quantity] }\n  end\nend\n\n# Multiple menu implementations\nclass PizzaMenu\n  def find_item(name)\n    menu = {\n      \"Margherita\" => { name: \"Margherita\", price: 12.99 },\n      \"Pepperoni\" => { name: \"Pepperoni\", price: 14.99 },\n      \"Quattro Stagioni\" => { name: \"Quattro Stagioni\", price: 16.99 }\n    }\n    menu[name]\n  end\nend\n\nclass BurgerMenu\n  def find_item(name)\n    menu = {\n      \"Classic Burger\" => { name: \"Classic Burger\", price: 8.99 },\n      \"Cheeseburger\" => { name: \"Cheeseburger\", price: 9.99 },\n      \"Veggie Burger\" => { name: \"Veggie Burger\", price: 10.99 }\n    }\n    menu[name]\n  end\nend\n\nclass SushiMenu\n  def find_item(name)\n    menu = {\n      \"California Roll\" => { name: \"California Roll\", price: 7.99 },\n      \"Salmon Sashimi\" => { name: \"Salmon Sashimi\", price: 12.99 },\n      \"Dragon Roll\" => { name: \"Dragon Roll\", price: 15.99 }\n    }\n    menu[name]\n  end\nend\n\n# Multiple kitchen implementations\nclass PizzaKitchen\n  def create_ticket(items, table_number)\n    puts \"Pizza Kitchen: Wood-fired oven preparing #{items.length} items for table #{table_number}\"\n    \"PIZZA-#{table_number}-#{Time.now.to_i}\"\n  end\nend\n\nclass BurgerKitchen\n  def create_ticket(items, table_number)\n    puts \"Grill Kitchen: Flame-grilling #{items.length} items for table #{table_number}\"\n    \"GRILL-#{table_number}-#{Time.now.to_i}\"\n  end\nend\n\n# Multiple payment implementations\nclass CreditCardPayment\n  def charge(amount)\n    puts \"Processing credit card payment: $#{amount}\"\n    true # Simulate successful payment\n  end\nend\n\nclass MobilePayment\n  def charge(amount)\n    puts \"Processing mobile payment: $#{amount}\"\n    true # Simulate successful payment\n  end\nend\n\n# Multiple notification implementations\nclass SMSNotification\n  def alert_ready(table_number, customer_name)\n    puts \"SMS: #{customer_name}, your order for table #{table_number} is ready!\"\n  end\nend\n\nclass AppNotification\n  def alert_ready(table_number, customer_name)\n    puts \"App Push: Order ready for #{customer_name} at table #{table_number}\"\n  end\nend\n\n# Now we can create different restaurant types!\n\n# Italian Pizza Restaurant\npizza_order = RestaurantOrder.new(\n  \"Maria\", 3,\n  menu: PizzaMenu.new,\n  kitchen: PizzaKitchen.new,\n  payment: CreditCardPayment.new,\n  notification: SMSNotification.new\n)\npizza_order.add_item(\"Margherita\", 1)\npizza_order.add_item(\"Pepperoni\", 2)\npizza_order.submit_order\n\n# Modern Burger Joint\nburger_order = RestaurantOrder.new(\n  \"Jake\", 7,\n  menu: BurgerMenu.new,\n  kitchen: BurgerKitchen.new,\n  payment: MobilePayment.new,\n  notification: AppNotification.new\n)\nburger_order.add_item(\"Classic Burger\", 2)\nburger_order.add_item(\"Veggie Burger\", 1)\nburger_order.submit_order\n</code></pre>",
    position: 12
  },
  {
    block_type: "text",
    content: "<h2>📊 Summary: Before vs After DI</h2><table style='width: 100%; border-collapse: collapse; margin: 2rem 0;'><thead><tr style='background-color: #f5f5f5;'><th style='padding: 1rem; border: 1px solid #ddd;'>Aspect</th><th style='padding: 1rem; border: 1px solid #ddd; background-color: #ffebee;'>❌ Without DI</th><th style='padding: 1rem; border: 1px solid #ddd; background-color: #e8f5e8;'>✅ With DI</th></tr></thead><tbody><tr><td style='padding: 1rem; border: 1px solid #ddd; font-weight: bold;'>Testing</td><td style='padding: 1rem; border: 1px solid #ddd;'>Slow, expensive, unreliable. Must use real dependencies</td><td style='padding: 1rem; border: 1px solid #ddd;'>Fast, free, reliable. Use mocks and controlled test doubles</td></tr><tr style='background-color: #f9f9f9;'><td style='padding: 1rem; border: 1px solid #ddd; font-weight: bold;'>Flexibility</td><td style='padding: 1rem; border: 1px solid #ddd;'>Locked to specific implementations. Hard to change</td><td style='padding: 1rem; border: 1px solid #ddd;'>Easy to swap implementations. Multiple options available</td></tr><tr><td style='padding: 1rem; border: 1px solid #ddd; font-weight: bold;'>Maintenance</td><td style='padding: 1rem; border: 1px solid #ddd;'>Changes ripple through system. High coupling</td><td style='padding: 1rem; border: 1px solid #ddd;'>Isolated changes. Low coupling between components</td></tr><tr style='background-color: #f9f9f9;'><td style='padding: 1rem; border: 1px solid #ddd; font-weight: bold;'>Code Reuse</td><td style='padding: 1rem; border: 1px solid #ddd;'>Hard to reuse. Dependencies baked in</td><td style='padding: 1rem; border: 1px solid #ddd;'>Highly reusable. Same logic, different dependencies</td></tr><tr><td style='padding: 1rem; border: 1px solid #ddd; font-weight: bold;'>Scalability</td><td style='padding: 1rem; border: 1px solid #ddd;'>Becomes unwieldy as system grows</td><td style='padding: 1rem; border: 1px solid #ddd;'>Scales well. Easy to add new implementations</td></tr></tbody></table>",
    position: 13
  }
])

puts "✅ Added comprehensive Ruby code examples to Lesson 2"

# Continue with lesson 3...
lesson3 = created_lessons[2]
lesson3.content_blocks.create!([
  {
    block_type: "text",
    content: "<h1>Advanced Concepts: Inversion of Control, Design Patterns, and Best Practices</h1><p>Now that you understand dependency injection through practical examples, let's dive deeper into the theoretical foundations and advanced concepts. This lesson covers Inversion of Control (IoC), SOLID principles, design patterns, and production best practices.</p><div style='background-color: #e3f2fd; padding: 1.5rem; border-left: 4px solid #2196f3; margin: 1rem 0;'><h3>🎯 Advanced Learning Objectives</h3><ul><li>Master Inversion of Control (IoC) principles</li><li>Understand how DI relates to SOLID principles</li><li>Learn various DI patterns and when to use them</li><li>Explore DI containers and framework integration</li><li>Implement testing strategies with DI</li><li>Apply best practices in production systems</li></ul></div>",
    position: 1
  },
  {
    block_type: "text",
    content: "<h2>🔄 Inversion of Control (IoC) - The Foundation of DI</h2><h3>What is Inversion of Control?</h3><div style='background-color: #f5f5f5; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;'><h4>📋 Definition:</h4><p><strong>Inversion of Control is a principle where the control of object creation and dependency management is inverted from the object itself to an external entity.</strong></p></div><p>Think of it like this:</p><div style='display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin: 2rem 0;'><div style='padding: 1.5rem; background-color: #ffebee; border-radius: 8px;'><h4>❌ Traditional Control</h4><p><strong>\"I'll handle everything myself\"</strong></p><ul><li>Object creates its own dependencies</li><li>Object controls its lifecycle</li><li>Object manages initialization</li><li>Like a chef who grows vegetables, raises cattle, and builds cooking equipment</li></ul></div><div style='padding: 1.5rem; background-color: #e8f5e8; border-radius: 8px;'><h4>✅ Inverted Control</h4><p><strong>\"Someone else will provide what I need\"</strong></p><ul><li>External entity creates dependencies</li><li>External entity manages lifecycle</li><li>External entity handles initialization</li><li>Like a chef who focuses on cooking while suppliers provide ingredients</li></ul></div></div>",
    position: 2
  },
  {
    block_type: "text",
    content: "<h3>🏭 IoC in Real Manufacturing</h3><p>Let's see how IoC works in car manufacturing:</p><h4>Traditional Approach (No IoC):</h4><pre><code class='ruby'># Each car assembly station does everything\nclass CarAssemblyStation\n  def build_car\n    # Station must handle everything itself\n    engine = build_engine_from_raw_materials\n    tires = vulcanize_rubber_into_tires\n    electronics = manufacture_radio_from_silicon\n    paint = mix_chemicals_into_paint\n    \n    assemble_car(engine, tires, electronics, paint)\n  end\n  \n  private\n  \n  def build_engine_from_raw_materials\n    # Hundreds of lines of engine building code\n  end\n  \n  def vulcanize_rubber_into_tires\n    # Complex tire manufacturing process\n  end\n  \n  # ... more complex manufacturing processes\nend</code></pre><h4>IoC Approach (Modern Manufacturing):</h4><pre><code class='ruby'># Assembly station focuses on assembly, parts are provided\nclass CarAssemblyStation\n  def initialize(parts_supplier:)\n    @parts_supplier = parts_supplier\n  end\n  \n  def build_car(car_spec)\n    # Station focuses only on assembly\n    engine = @parts_supplier.get_engine(car_spec.engine_type)\n    tires = @parts_supplier.get_tires(car_spec.tire_type)\n    electronics = @parts_supplier.get_electronics(car_spec.radio_type)\n    paint = @parts_supplier.get_paint(car_spec.color)\n    \n    assemble_car(engine, tires, electronics, paint)\n  end\n  \n  private\n  \n  def assemble_car(engine, tires, electronics, paint)\n    # Focus on what this station does best - assembly!\n  end\nend\n\n# Specialized suppliers handle component creation\nclass PartsSupplier\n  def get_engine(type)\n    case type\n    when :v8 then V8Engine.new\n    when :electric then ElectricMotor.new\n    when :hybrid then HybridSystem.new\n    end\n  end\n  \n  def get_tires(type)\n    TireFactory.create(type)\n  end\n  \n  def get_electronics(type)\n    ElectronicsFactory.create(type)\n  end\n  \n  def get_paint(color)\n    PaintShop.mix_color(color)\n  end\nend</code></pre>",
    position: 3
  },
  {
    block_type: "text",
    content: "<h2>🏗️ SOLID Principles and Dependency Injection</h2><p>DI directly supports all five SOLID principles. Let's examine each:</p><h3>1. Single Responsibility Principle (SRP)</h3><div style='background-color: #e8f5e8; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;'><h4>✅ How DI Helps:</h4><p><strong>Each class has one reason to change.</strong></p><pre><code class='ruby'># With DI, each class has a single, focused responsibility\nclass OrderService\n  def initialize(email_service:, payment_processor:)\n    @email_service = email_service\n    @payment_processor = payment_processor\n  end\n  \n  def process_order(order)\n    # ONLY responsible for order processing logic\n    # NOT responsible for email sending or payment processing\n    \n    if @payment_processor.charge(order.amount)\n      @email_service.send_confirmation(order)\n      true\n    else\n      @email_service.send_failure_notice(order)\n      false\n    end\n  end\nend\n\n# Email responsibility is separate\nclass EmailService\n  def send_confirmation(order)\n    # ONLY responsible for email composition and sending\n  end\nend\n\n# Payment responsibility is separate  \nclass PaymentProcessor\n  def charge(amount)\n    # ONLY responsible for payment processing\n  end\nend</code></pre></div>",
    position: 4
  },
  {
    block_type: "text",
    content: "<h3>2. Open/Closed Principle (OCP)</h3><div style='background-color: #fff3e0; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;'><h4>✅ How DI Helps:</h4><p><strong>Open for extension, closed for modification.</strong></p><pre><code class='ruby'># The OrderService is closed for modification...\nclass OrderService\n  def initialize(payment_processor:)\n    @payment_processor = payment_processor\n  end\n  \n  def process_order(order)\n    # This code never changes\n    @payment_processor.charge(order.amount)\n  end\nend\n\n# ...but open for extension through new payment implementations\nclass StripePaymentProcessor\n  def charge(amount)\n    # Stripe-specific implementation\n  end\nend\n\nclass PayPalPaymentProcessor\n  def charge(amount)\n    # PayPal-specific implementation  \n  end\nend\n\nclass BitcoinPaymentProcessor\n  def charge(amount)\n    # Bitcoin-specific implementation\n  end\nend\n\n# Add new payment methods without changing OrderService!\norder_service = OrderService.new(payment_processor: BitcoinPaymentProcessor.new)</code></pre></div>",
    position: 5
  },
  {
    block_type: "text",
    content: "<h3>3. Liskov Substitution Principle (LSP)</h3><div style='background-color: #f3e5f5; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;'><h4>✅ How DI Helps:</h4><p><strong>Objects of a superclass should be replaceable with objects of a subclass without breaking functionality.</strong></p><pre><code class='ruby'># All payment processors must follow the same contract\nclass PaymentProcessor\n  def charge(amount)\n    raise NotImplementedError, \"Subclasses must implement charge\"\n  end\nend\n\nclass StripeProcessor < PaymentProcessor\n  def charge(amount)\n    # Returns boolean - success/failure\n    stripe_api.charge(amount * 100) # Stripe uses cents\n  rescue StandardError\n    false\n  end\nend\n\nclass PayPalProcessor < PaymentProcessor\n  def charge(amount)\n    # Same return type and behavior contract\n    paypal_sdk.process_payment(amount)\n  rescue StandardError\n    false\n  end\nend\n\n# Any processor can be substituted without breaking the system\nclass OrderService\n  def initialize(payment_processor:)\n    @payment_processor = payment_processor\n  end\n  \n  def process_order(order)\n    # Works with ANY payment processor that follows the contract\n    success = @payment_processor.charge(order.amount)\n    success ? handle_success(order) : handle_failure(order)\n  end\nend\n\n# These are completely interchangeable\nOrderService.new(payment_processor: StripeProcessor.new)\nOrderService.new(payment_processor: PayPalProcessor.new)</code></pre></div>",
    position: 6
  },
  {
    block_type: "text",
    content: "<h3>4. Interface Segregation Principle (ISP)</h3><div style='background-color: #e1f5fe; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;'><h4>✅ How DI Helps:</h4><p><strong>Classes shouldn't depend on interfaces they don't use.</strong></p><pre><code class='ruby'># BAD - Fat interface that violates ISP\nclass BadNotificationService\n  def send_email(message)\n    # Email implementation\n  end\n  \n  def send_sms(message)\n    # SMS implementation\n  end\n  \n  def send_push_notification(message)\n    # Push notification implementation\n  end\n  \n  def send_slack_message(message)\n    # Slack implementation\n  end\nend\n\n# Problem: Classes that only need email must depend on SMS, push, etc.\nclass EmailOnlyService\n  def initialize(notification_service:)\n    @notification_service = notification_service # Depends on methods it doesn't use!\n  end\nend\n\n# GOOD - Segregated interfaces with DI\nclass EmailNotifier\n  def send_email(message)\n    # Only email-related functionality\n  end\nend\n\nclass SMSNotifier  \n  def send_sms(message)\n    # Only SMS-related functionality\n  end\nend\n\n# Classes only depend on what they actually use\nclass EmailService\n  def initialize(email_notifier:)\n    @email_notifier = email_notifier # Only depends on email interface\n  end\nend\n\nclass SMSService\n  def initialize(sms_notifier:)\n    @sms_notifier = sms_notifier # Only depends on SMS interface\n  end\nend\n\n# Clean, focused dependencies\nEmailService.new(email_notifier: EmailNotifier.new)\nSMSService.new(sms_notifier: SMSNotifier.new)</code></pre></div>",
    position: 7
  },
  {
    block_type: "text",
    content: "<h3>5. Dependency Inversion Principle (DIP) - The Heart of DI</h3><div style='background-color: #fce4ec; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;'><h4>✅ The Most Important Principle for DI:</h4><p><strong>High-level modules should not depend on low-level modules. Both should depend on abstractions.</strong></p><pre><code class='ruby'># BAD - High-level OrderService depends on low-level MySQL implementation\nclass OrderService # High-level\n  def initialize\n    @database = MySQLDatabase.new # Direct dependency on low-level implementation\n  end\n  \n  def create_order(order_data)\n    @database.execute_sql(\"INSERT INTO orders...\") # Coupled to SQL\n  end\nend\n\nclass MySQLDatabase # Low-level\n  def execute_sql(query)\n    # MySQL-specific implementation\n  end\nend\n\n# GOOD - Both depend on abstraction\nclass OrderService # High-level\n  def initialize(order_repository:) # Depends on abstraction\n    @order_repository = order_repository\n  end\n  \n  def create_order(order_data)\n    @order_repository.save(order_data) # Abstract interface\n  end\nend\n\n# Abstraction - what both high and low level depend on\nclass OrderRepository\n  def save(order_data)\n    raise NotImplementedError\n  end\nend\n\n# Low-level implementations depend on abstraction\nclass MySQLOrderRepository < OrderRepository # Low-level\n  def save(order_data)\n    # MySQL-specific implementation\n  end\nend\n\nclass PostgreSQLOrderRepository < OrderRepository # Low-level\n  def save(order_data)\n    # PostgreSQL-specific implementation\n  end\nend\n\nclass MongoOrderRepository < OrderRepository # Low-level\n  def save(order_data)\n    # MongoDB-specific implementation\n  end\nend\n\n# High-level code is independent of low-level implementations\nOrderService.new(order_repository: MySQLOrderRepository.new)\nOrderService.new(order_repository: PostgreSQLOrderRepository.new)\nOrderService.new(order_repository: MongoOrderRepository.new)</code></pre></div>",
    position: 8
  },
  {
    block_type: "text",
    content: "<h2>🏗️ DI Patterns and Implementation Techniques</h2><h3>1. Constructor Injection (Most Common)</h3><pre><code class='ruby'>class OrderService\n  def initialize(payment_service:, email_service:, logger:)\n    @payment_service = payment_service\n    @email_service = email_service\n    @logger = logger\n  end\n  \n  def process_order(order)\n    @logger.info(\"Processing order #{order.id}\")\n    # Use injected dependencies\n  end\nend\n\n# Usage\nservice = OrderService.new(\n  payment_service: StripePayment.new,\n  email_service: GmailService.new,\n  logger: Logger.new\n)</code></pre><h3>2. Setter Injection</h3><pre><code class='ruby'>class OrderService\n  attr_writer :payment_service, :email_service, :logger\n  \n  def process_order(order)\n    @logger&.info(\"Processing order #{order.id}\")\n    # Use dependencies if they're set\n  end\nend\n\n# Usage\nservice = OrderService.new\nservice.payment_service = StripePayment.new\nservice.email_service = GmailService.new\nservice.logger = Logger.new</code></pre><h3>3. Method Injection</h3><pre><code class='ruby'>class OrderService\n  def process_order(order, payment_service:, email_service:)\n    # Dependencies passed per method call\n    if payment_service.charge(order.amount)\n      email_service.send_confirmation(order)\n    end\n  end\nend\n\n# Usage\nservice = OrderService.new\nservice.process_order(order,\n  payment_service: StripePayment.new,\n  email_service: GmailService.new\n)</code></pre>",
    position: 9
  },
  {
    block_type: "text",
    content: "<h2>📦 DI Containers and Frameworks</h2><p>As applications grow, manually wiring dependencies becomes complex. DI containers automate this process:</p><h3>Simple Ruby DI Container Example</h3><pre><code class='ruby'>class SimpleDIContainer\n  def initialize\n    @services = {}\n    @singletons = {}\n  end\n  \n  # Register a service\n  def register(name, &block)\n    @services[name] = block\n  end\n  \n  # Register a singleton service\n  def register_singleton(name, &block)\n    register(name, &block)\n    @singletons[name] = true\n  end\n  \n  # Resolve a service\n  def resolve(name)\n    if @singletons[name]\n      @singleton_instances ||= {}\n      @singleton_instances[name] ||= @services[name].call(self)\n    else\n      @services[name]&.call(self)\n    end\n  end\nend\n\n# Register services\ncontainer = SimpleDIContainer.new\n\n# Register dependencies\ncontainer.register(:email_service) { GmailService.new }\ncontainer.register(:payment_service) { StripePayment.new }\ncontainer.register_singleton(:logger) { Logger.new(STDOUT) }\n\n# Register main service with automatic dependency resolution\ncontainer.register(:order_service) do |c|\n  OrderService.new(\n    email_service: c.resolve(:email_service),\n    payment_service: c.resolve(:payment_service),\n    logger: c.resolve(:logger)\n  )\nend\n\n# Use the container\norder_service = container.resolve(:order_service)\norder_service.process_order(order)</code></pre>",
    position: 10
  },
  {
    block_type: "text",
    content: "<h3>Production DI with Rails</h3><pre><code class='ruby'># In Rails, you can create a simple service locator\nclass ServiceContainer\n  class << self\n    def email_service\n      @email_service ||= if Rails.env.production?\n        SendGridService.new\n      elsif Rails.env.development?\n        MailHogService.new\n      else\n        MockEmailService.new\n      end\n    end\n    \n    def payment_service\n      @payment_service ||= if Rails.env.production?\n        StripePayment.new\n      else\n        MockPayment.new\n      end\n    end\n    \n    def order_service\n      @order_service ||= OrderService.new(\n        email_service: email_service,\n        payment_service: payment_service,\n        logger: Rails.logger\n      )\n    end\n  end\nend\n\n# Usage in controllers\nclass OrdersController < ApplicationController\n  def create\n    service = ServiceContainer.order_service\n    if service.process_order(order_params)\n      render json: { success: true }\n    else\n      render json: { error: 'Processing failed' }\n    end\n  end\nend\n\n# Usage in background jobs\nclass ProcessOrderJob < ApplicationJob\n  def perform(order_id)\n    order = Order.find(order_id)\n    ServiceContainer.order_service.process_order(order)\n  end\nend</code></pre>",
    position: 11
  },
  {
    block_type: "text",
    content: "<h2>🧪 Advanced Testing Strategies with DI</h2><h3>Test Doubles and Mocking</h3><pre><code class='ruby'>require 'minitest/autorun'\nrequire 'mocha/minitest'\n\nclass OrderServiceTest < Minitest::Test\n  def setup\n    @mock_payment = mock('payment_service')\n    @mock_email = mock('email_service')\n    @mock_logger = mock('logger')\n    \n    @service = OrderService.new(\n      payment_service: @mock_payment,\n      email_service: @mock_email,\n      logger: @mock_logger\n    )\n  end\n  \n  def test_successful_order_processing\n    order = create_test_order\n    \n    # Set up expectations\n    @mock_logger.expects(:info).with(\"Processing order #{order.id}\")\n    @mock_payment.expects(:charge).with(order.amount).returns(true)\n    @mock_email.expects(:send_confirmation).with(order)\n    \n    # Execute\n    result = @service.process_order(order)\n    \n    # Verify\n    assert result\n  end\n  \n  def test_failed_payment_handling\n    order = create_test_order\n    \n    # Set up failure scenario\n    @mock_logger.expects(:info).with(\"Processing order #{order.id}\")\n    @mock_payment.expects(:charge).with(order.amount).returns(false)\n    @mock_email.expects(:send_failure_notice).with(order)\n    \n    # Execute\n    result = @service.process_order(order)\n    \n    # Verify\n    refute result\n  end\n  \n  private\n  \n  def create_test_order\n    OpenStruct.new(id: 123, amount: 99.99)\n  end\nend</code></pre>",
    position: 12
  },
  {
    block_type: "text",
    content: "<h3>Integration Testing with Real Dependencies</h3><pre><code class='ruby'>class OrderServiceIntegrationTest < Minitest::Test\n  def setup\n    # Use real services but in test mode\n    @service = OrderService.new(\n      payment_service: StripeTestPayment.new, # Real Stripe in test mode\n      email_service: TestEmailService.new,    # Real email but to test addresses\n      logger: Logger.new(StringIO.new)        # Real logger to string buffer\n    )\n  end\n  \n  def test_end_to_end_order_processing\n    order = create_real_test_order\n    \n    result = @service.process_order(order)\n    \n    assert result\n    # Verify real side effects occurred\n    assert_payment_processed(order)\n    assert_email_sent(order)\n  end\n  \n  private\n  \n  def create_real_test_order\n    # Create order with real test data\n  end\n  \n  def assert_payment_processed(order)\n    # Check real payment system\n  end\n  \n  def assert_email_sent(order)\n    # Check real email service\n  end\nend</code></pre>",
    position: 13
  },
  {
    block_type: "text",
    content: "<h2>🚀 Production Best Practices</h2><h3>1. Configuration-Based DI</h3><pre><code class='ruby'># config/services.yml\nproduction:\n  email_service: SendGridService\n  payment_service: StripePayment\n  cache_service: RedisCache\n  \ndevelopment:\n  email_service: MailHogService\n  payment_service: MockPayment\n  cache_service: MemoryCache\n  \ntest:\n  email_service: MockEmailService\n  payment_service: MockPayment\n  cache_service: MockCache\n\n# lib/service_factory.rb\nclass ServiceFactory\n  def self.create_services\n    config = Rails.application.config_for(:services)\n    \n    services = {}\n    config.each do |name, class_name|\n      services[name.to_sym] = class_name.constantize.new\n    end\n    \n    services\n  end\nend\n\n# app/services/order_service.rb\nclass OrderService\n  def self.create\n    services = ServiceFactory.create_services\n    new(\n      email_service: services[:email_service],\n      payment_service: services[:payment_service],\n      cache_service: services[:cache_service]\n    )\n  end\nend</code></pre>",
    position: 14
  },
  {
    block_type: "text",
    content: "<h3>2. Health Checks and Monitoring</h3><pre><code class='ruby'>class HealthCheckService\n  def initialize(dependencies:)\n    @dependencies = dependencies\n  end\n  \n  def check_health\n    results = {}\n    \n    @dependencies.each do |name, service|\n      results[name] = check_service_health(service)\n    end\n    \n    {\n      status: all_healthy?(results) ? 'healthy' : 'unhealthy',\n      services: results,\n      timestamp: Time.current\n    }\n  end\n  \n  private\n  \n  def check_service_health(service)\n    if service.respond_to?(:health_check)\n      service.health_check\n    else\n      { status: 'unknown', message: 'No health check available' }\n    end\n  rescue StandardError => e\n    { status: 'error', message: e.message }\n  end\n  \n  def all_healthy?(results)\n    results.all? { |_, result| result[:status] == 'healthy' }\n  end\nend\n\n# Add health checks to your services\nclass StripePayment\n  def health_check\n    # Try a simple API call\n    Stripe::Account.retrieve\n    { status: 'healthy', message: 'Stripe API accessible' }\n  rescue StandardError => e\n    { status: 'unhealthy', message: \"Stripe error: #{e.message}\" }\n  end\nend\n\n# Health check endpoint\nclass HealthController < ApplicationController\n  def show\n    health_check = HealthCheckService.new(\n      dependencies: {\n        payment: ServiceContainer.payment_service,\n        email: ServiceContainer.email_service,\n        database: ActiveRecord::Base.connection\n      }\n    )\n    \n    result = health_check.check_health\n    render json: result, status: result[:status] == 'healthy' ? 200 : 503\n  end\nend</code></pre>",
    position: 15
  },
  {
    block_type: "text",
    content: "<h2>📚 Summary: Key Takeaways</h2><div style='background-color: #e3f2fd; padding: 2rem; border-left: 5px solid #2196f3; margin: 2rem 0;'><h3>🎯 Mastery Checklist</h3><h4>✅ Theory Mastered:</h4><ul><li><strong>Inversion of Control:</strong> External entities manage dependencies</li><li><strong>SOLID Principles:</strong> DI supports all five principles</li><li><strong>Design Patterns:</strong> DI is a fundamental architectural pattern</li></ul><h4>✅ Practical Skills:</h4><ul><li><strong>Identify tight coupling</strong> in existing code</li><li><strong>Refactor to DI</strong> using constructor injection</li><li><strong>Create testable code</strong> with mock dependencies</li><li><strong>Build flexible systems</strong> that support multiple implementations</li></ul><h4>✅ Advanced Techniques:</h4><ul><li><strong>DI containers</strong> for complex dependency graphs</li><li><strong>Configuration-driven</strong> service selection</li><li><strong>Health monitoring</strong> of injected dependencies</li><li><strong>Testing strategies</strong> for unit and integration tests</li></ul></div><div style='background-color: #f1f8e9; padding: 1.5rem; border-radius: 8px; margin: 2rem 0;'><h3>🚀 Next Steps</h3><ol><li><strong>Practice:</strong> Refactor existing code to use DI</li><li><strong>Experiment:</strong> Try different injection patterns</li><li><strong>Build:</strong> Create a simple DI container</li><li><strong>Test:</strong> Write comprehensive tests with mocks</li><li><strong>Deploy:</strong> Implement DI in a production system</li></ol></div>",
    position: 16
  }
])

puts "✅ Added comprehensive advanced concepts to Lesson 3"

# Mark todos as completed
TodoWrite.new.call(todos: [
  {"id": "1", "content": "Analyze existing DI course structure and understand current lessons", "status": "completed", "priority": "high"},
  {"id": "2", "content": "Create streamlined DI course with 2-3 focused lessons", "status": "completed", "priority": "high"},
  {"id": "3", "content": "Add detailed Ruby code examples showing problems without DI", "status": "completed", "priority": "high"},
  {"id": "4", "content": "Add Ruby code examples showing solutions with DI", "status": "completed", "priority": "high"},
  {"id": "5", "content": "Include car manufacturing example as requested", "status": "completed", "priority": "medium"},
  {"id": "6", "content": "Add comprehensive chapter on Inversion of Control and design patterns", "status": "completed", "priority": "medium"},
  {"id": "7", "content": "Create practical assignment with detailed questions", "status": "in_progress", "priority": "medium"}
])

# Create a comprehensive assignment
puts "\n📋 Creating focused practical assessment..."

assignment = focused_di_course.assignments.create!(
  title: "Dependency Injection Mastery Assessment",
  assignment_type: "quiz",
  published: true,
  max_score: 100
)

# Create comprehensive questions covering all aspects
questions_data = [
  {
    question_text: "What is the core principle of Dependency Injection?",
    question_type: "multiple_choice",
    points: 10,
    correct_answer: "1",
    options: {
      choices: [
        "Objects should create all dependencies internally for better control",
        "Objects should receive dependencies from external sources rather than creating them internally",
        "Dependencies should be hardcoded to ensure consistent behavior",
        "Objects should use global variables to share dependencies"
      ]
    }
  },
  {
    question_text: "In the car manufacturing example, what problem occurs when each assembly worker builds their own engine?",
    question_type: "multiple_choice", 
    points: 10,
    correct_answer: "3",
    options: {
      choices: [
        "Cars are built faster because workers are self-sufficient",
        "Quality improves because each worker controls their own parts",
        "Time is wasted, costs increase, quality becomes inconsistent, and maintenance is difficult",
        "The assembly process becomes more streamlined and efficient"
      ]
    }
  },
  {
    question_text: "Which Ruby code example correctly demonstrates dependency injection?",
    question_type: "multiple_choice",
    points: 15,
    correct_answer: "1",
    options: {
      choices: [
        "class OrderService\n  def initialize\n    @payment = StripePayment.new\n  end\nend",
        "class OrderService\n  def initialize(payment_service:)\n    @payment = payment_service\n  end\nend", 
        "class OrderService\n  PAYMENT = StripePayment.new\nend",
        "class OrderService\n  def payment\n    StripePayment.new\n  end\nend"
      ]
    }
  },
  {
    question_text: "What is Inversion of Control (IoC)?",
    question_type: "multiple_choice",
    points: 15,
    correct_answer: "2",
    options: {
      choices: [
        "A method of controlling program flow with conditional statements",
        "A principle where object creation control is moved to external entities",
        "A way to invert the order of method calls in a program", 
        "A technique for reversing string values in Ruby"
      ]
    }
  },
  {
    question_text: "How does DI help with testing?",
    question_type: "multiple_choice",
    points: 15,
    correct_answer: "1",
    options: {
      choices: [
        "It makes tests slower but more thorough",
        "It allows replacing real dependencies with fast, controlled mock objects",
        "It eliminates the need to write any tests",
        "It automatically generates test cases"
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
        "Single Responsibility Principle",
        "Open/Closed Principle",
        "Liskov Substitution Principle", 
        "Dependency Inversion Principle"
      ]
    }
  },
  {
    question_text: "In the restaurant example, what advantage does DI provide when switching from pizza to burger restaurant?",
    question_type: "multiple_choice",
    points: 10,
    correct_answer: "1",
    options: {
      choices: [
        "You must rewrite the entire order system from scratch",
        "You can reuse the order processing logic with different menu, kitchen, and payment implementations",
        "The restaurant automatically becomes more profitable",
        "Customer service improves without any code changes"
      ]
    }
  },
  {
    question_text: "What problem does tight coupling create in software?",
    question_type: "multiple_choice", 
    points: 10,
    correct_answer: "2",
    options: {
      choices: [
        "It makes code run faster by reducing abstraction layers",
        "Changes in one component often require changes in dependent components",
        "It reduces memory usage by eliminating interface overhead",
        "It improves security by limiting component access"
      ]
    }
  },
  {
    question_text: "True or False: With dependency injection, you can test your OrderService without making real payment API calls or sending actual emails.",
    question_type: "true_false",
    points: 5,
    correct_answer: "1", 
    options: {}
  },
  {
    question_text: "True or False: Dependency Injection makes code more complex and harder to understand.",
    question_type: "true_false",
    points: 5,
    correct_answer: "0",
    options: {}
  }
]

# Create all questions
questions_data.each_with_index do |question_data, index|
  assignment.assignment_questions.create!(question_data)
  puts "✅ Created question #{index + 1}: #{question_data[:question_text][0..50]}..."
end

# Mark final todo as completed
TodoWrite.new.call(todos: [
  {"id": "1", "content": "Analyze existing DI course structure and understand current lessons", "status": "completed", "priority": "high"},
  {"id": "2", "content": "Create streamlined DI course with 2-3 focused lessons", "status": "completed", "priority": "high"},
  {"id": "3", "content": "Add detailed Ruby code examples showing problems without DI", "status": "completed", "priority": "high"},
  {"id": "4", "content": "Add Ruby code examples showing solutions with DI", "status": "completed", "priority": "high"},
  {"id": "5", "content": "Include car manufacturing example as requested", "status": "completed", "priority": "medium"},
  {"id": "6", "content": "Add comprehensive chapter on Inversion of Control and design patterns", "status": "completed", "priority": "medium"},
  {"id": "7", "content": "Create practical assignment with detailed questions", "status": "completed", "priority": "medium"}
])

puts "✅ Created practical assessment with #{assignment.assignment_questions.count} focused questions"

puts "\n🎉 Focused Dependency Injection Course creation complete!"
puts "Course: #{focused_di_course.title}"
puts "Lessons: #{focused_di_course.lessons.count} comprehensive lessons with detailed Ruby examples"
puts "Assignment: #{assignment.title} with #{assignment.assignment_questions.count} practical questions"
puts "Total course duration: #{focused_di_course.duration} hours"
puts "File location: /vagrant/db/seeds/courses/create_focused_dependency_injection_course.rb"