# Comprehensive Dependency Injection Course - Restaurant Management System
# This course provides detailed explanations for beginners to understand DI concepts

# Find or create instructor user
instructor = User.where(role: 'instructor').first
if instructor.nil?
  instructor = User.create!(
    email: 'comprehensive.di.instructor@example.com',
    password: 'password123',
    password_confirmation: 'password123',
    role: 'instructor',
    name: 'Sarah Martinez'
  )
end

# Create Comprehensive Dependency Injection Course
comprehensive_di_course = Course.create!(
  title: 'Complete Guide to Dependency Injection for Beginners',
  description: 'A comprehensive, beginner-friendly course that explains dependency injection through real-world restaurant management examples. Learn to write testable, maintainable code with detailed explanations and practical Ruby examples.',
  duration: 12, # 12 hours total course duration - more comprehensive
  instructor: instructor,
  published: true
)

puts "✅ Created comprehensive DI course: #{comprehensive_di_course.title}"
puts "Course ID: #{comprehensive_di_course.id}"

# Create detailed lessons for comprehensive Dependency Injection course
lessons_data = [
  {
    title: 'What is Dependency Injection? - A Complete Introduction',
    content: 'A comprehensive introduction to dependency injection concepts, explained in simple terms for beginners with no prior knowledge.',
    position: 1
  },
  {
    title: 'Real-World Restaurant Management System Example', 
    content: 'Understanding dependency injection through a detailed restaurant management system - from ordering to kitchen to billing.',
    position: 2
  },
  {
    title: 'Breaking Down the Restaurant: Components and Dependencies',
    content: 'Detailed analysis of how different parts of a restaurant depend on each other and how this relates to software.',
    position: 3
  },
  {
    title: 'The Problems: Why We Need Dependency Injection',
    content: 'A thorough exploration of software problems that dependency injection solves, with clear examples and explanations.',
    position: 4
  },
  {
    title: 'Ruby Code Without DI: Restaurant System Problems',
    content: 'Real Ruby code showing a restaurant management system without DI and the specific problems it creates.',
    position: 5
  },
  {
    title: 'Ruby Code With DI: Restaurant System Solutions',
    content: 'Complete refactoring of the restaurant system using dependency injection, solving all the identified problems.',
    position: 6
  },
  {
    title: 'Advanced Example: Multi-Restaurant Chain Management',
    content: 'A complex example showing how DI helps manage multiple restaurant locations with different requirements.',
    position: 7
  },
  {
    title: 'Design Patterns Deep Dive: Understanding the Theory Behind DI',
    content: 'Comprehensive explanation of design patterns, SOLID principles, and inversion of control concepts.',
    position: 8
  },
  {
    title: 'Testing with Dependency Injection: Making Your Code Bulletproof',
    content: 'Complete guide to testing with dependency injection, including mocking, stubbing, and test strategies.',
    position: 9
  },
  {
    title: 'Real-World Implementation: Best Practices and Common Pitfalls',
    content: 'Practical advice for implementing DI in real projects, common mistakes to avoid, and best practices.',
    position: 10
  }
]

created_lessons = []
lessons_data.each do |lesson_data|
  lesson = comprehensive_di_course.lessons.create!(lesson_data)
  created_lessons << lesson
  puts "✅ Created lesson #{lesson.position}: #{lesson.title}"
end

puts "\n📝 Adding detailed content blocks to lessons..."

# Lesson 1: Complete Introduction to Dependency Injection
lesson1 = created_lessons[0]
lesson1.content_blocks.create!([
  {
    block_type: "text",
    content: "<h1>Welcome to Dependency Injection - The Complete Beginner's Guide</h1><p>If you're new to programming or have heard the term 'dependency injection' and felt confused, you're in the right place. This course will teach you everything from the ground up, using simple examples and clear explanations.</p><h2>What You'll Learn</h2><ul><li>What dependency injection really means (in simple terms)</li><li>Why it's one of the most important programming concepts</li><li>How to use it in Ruby code with practical examples</li><li>How it makes your code better, easier to test, and more maintainable</li></ul>",
    position: 1
  },
  {
    block_type: "text", 
    content: "<h2>What is a 'Dependency'?</h2><p>Before we understand dependency injection, we need to understand what a <strong>dependency</strong> is.</p><p><strong>In simple terms:</strong> A dependency is something that your code needs to work properly.</p><h3>Think of it like this:</h3><ul><li>🚗 <strong>A car depends on:</strong> Engine, wheels, fuel, brakes</li><li>📱 <strong>A smartphone depends on:</strong> Battery, screen, processor, memory</li><li>👨‍💻 <strong>A software class depends on:</strong> Other classes, services, databases, APIs</li></ul><p>Just like a car can't work without its engine, a software class often can't work without other classes or services.</p>",
    position: 2
  },
  {
    block_type: "image",
    file_url: "https://images.unsplash.com/photo-1581833971358-2c8b550f87b3?w=800&h=400&fit=crop",
    alt_text: "Modern smartphone components laid out showing dependencies",
    position: 3
  },
  {
    block_type: "text",
    content: "<h2>What is 'Injection'?</h2><p><strong>Injection</strong> means <em>'giving something from the outside'</em> rather than creating it inside.</p><h3>Two approaches:</h3><div style='display: flex; gap: 2rem; margin: 1rem 0;'><div style='flex: 1; padding: 1rem; border: 2px solid #ff6b6b; border-radius: 8px;'><h4>❌ Without Injection (Bad)</h4><p>The car factory builds the engine inside the car assembly process. Every car gets the same engine, and you can't change it.</p></div><div style='flex: 1; padding: 1rem; border: 2px solid #51cf66; border-radius: 8px;'><h4>✅ With Injection (Good)</h4><p>The car factory <em>injects</em> (provides) the engine from outside. Different cars can get different engines, and you can easily change engines.</p></div></div>",
    position: 4
  },
  {
    block_type: "text",
    content: "<h2>Dependency Injection Definition</h2><div style='padding: 1.5rem; background-color: #e3f2fd; border-left: 4px solid #2196f3; margin: 1rem 0;'><h3>📋 Dependency Injection is:</h3><p><strong>A design pattern where objects receive their dependencies from external sources rather than creating them internally.</strong></p></div><h3>Breaking this down:</h3><ul><li><strong>Design pattern:</strong> A proven solution to a common programming problem</li><li><strong>Objects:</strong> Your classes/components in code</li><li><strong>Receive their dependencies:</strong> Get what they need from outside</li><li><strong>External sources:</strong> Another part of your program provides the dependencies</li><li><strong>Rather than creating them internally:</strong> Instead of making dependencies inside the class</li></ul>",
    position: 5
  },
  {
    block_type: "text",
    content: "<h2>Key Benefits - Why Should You Care?</h2><div style='display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; margin: 1rem 0;'><div style='padding: 1rem; background-color: #f3e5f5; border-radius: 8px;'><h4>🧪 Easier Testing</h4><p>You can replace real services with fake ones during testing. No more real database calls or API requests in your tests!</p></div><div style='padding: 1rem; background-color: #e8f5e8; border-radius: 8px;'><h4>🔄 Flexibility</h4><p>Easy to swap different implementations. Want to switch from MySQL to PostgreSQL? No problem!</p></div><div style='padding: 1rem; background-color: #fff3e0; border-radius: 8px;'><h4>🛠 Maintainability</h4><p>Changes in one part don't break other parts. Your code becomes more modular and easier to maintain.</p></div><div style='padding: 1rem; background-color: #fce4ec; border-radius: 8px;'><h4>🎯 Single Responsibility</h4><p>Each class focuses on its main job instead of also worrying about creating its dependencies.</p></div></div>",
    position: 6
  }
])

# Lesson 2: Detailed Restaurant Management System Example
lesson2 = created_lessons[1] 
lesson2.content_blocks.create!([
  {
    block_type: "text",
    content: "<h1>Real-World Example: Restaurant Management System 🍽️</h1><p>Let's understand dependency injection using something everyone can relate to - a restaurant! This example will show you exactly how dependencies work in the real world, and then we'll see how this applies to software.</p>",
    position: 1
  },
  {
    block_type: "image",
    file_url: "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800&h=500&fit=crop",
    alt_text: "Busy restaurant interior with customers, waiters, and kitchen staff",
    position: 2
  },
  {
    block_type: "text",
    content: "<h2>Meet 'Bella Vista Restaurant' - Our Example Business</h2><p>Imagine you own a restaurant called 'Bella Vista.' Your restaurant has several key components that must work together:</p><h3>🏢 Main Components:</h3><ul><li><strong>Order Taking System:</strong> Waiters take customer orders</li><li><strong>Kitchen System:</strong> Chefs prepare the food</li><li><strong>Payment System:</strong> Cashier processes payments</li><li><strong>Inventory System:</strong> Manager tracks ingredients</li><li><strong>Notification System:</strong> System alerts when orders are ready</li></ul><p>Each of these systems <em>depends</em> on other systems to work properly. Let's see how...</p>",
    position: 3
  },
  {
    block_type: "text",
    content: "<h2>Understanding Dependencies in the Restaurant</h2><h3>🍝 The Order Taking System depends on:</h3><ul><li><strong>Menu System:</strong> To know what dishes are available</li><li><strong>Kitchen System:</strong> To know if ingredients are available</li><li><strong>Payment System:</strong> To calculate total cost</li><li><strong>Customer Database:</strong> To track customer preferences</li></ul><h3>👨‍🍳 The Kitchen System depends on:</h3><ul><li><strong>Inventory System:</strong> To check ingredient availability</li><li><strong>Recipe Database:</strong> To know how to make dishes</li><li><strong>Equipment Management:</strong> To use ovens, stoves, etc.</li><li><strong>Notification System:</strong> To alert when food is ready</li></ul><h3>💳 The Payment System depends on:</h3><ul><li><strong>Order System:</strong> To know what to charge for</li><li><strong>Tax Calculator:</strong> To add appropriate taxes</li><li><strong>Credit Card Processor:</strong> To handle card payments</li><li><strong>Receipt Printer:</strong> To provide customer receipts</li></ul>",
    position: 4
  },
  {
    block_type: "text",
    content: "<h2>❌ The Problems Without Proper 'Injection'</h2><p>Imagine if each system had to create and manage its own dependencies. Here's what would happen:</p><div style='background-color: #ffebee; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;'><h3>🚨 Scenario: Waiter Creates Their Own Systems</h3><p><strong>What if each waiter had to:</strong></p><ul><li>Build their own cash register</li><li>Create their own menu</li><li>Set up their own kitchen equipment</li><li>Install their own payment processing system</li></ul><p><strong>Problems this creates:</strong></p><ul><li>🕐 <strong>Waste of time:</strong> Each waiter spends hours setting up instead of serving customers</li><li>💰 <strong>Expensive:</strong> Buying duplicate equipment for each waiter</li><li>🔧 <strong>Hard to maintain:</strong> If the menu changes, you have to update each waiter's personal menu</li><li>🧪 <strong>Can't practice:</strong> New waiters can't train with fake systems</li><li>⚡ <strong>Inflexible:</strong> Can't easily switch to different payment processors</li></ul></div>",
    position: 5
  },
  {
    block_type: "text",
    content: "<h2>✅ The Solution: Restaurant 'Dependency Injection'</h2><p>Instead, smart restaurants use what's essentially dependency injection:</p><div style='background-color: #e8f5e8; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;'><h3>🎯 How Real Restaurants Work:</h3><ul><li><strong>The restaurant owner (manager)</strong> sets up all the systems once</li><li><strong>Waiters are 'injected' with:</strong> A shared menu, access to the kitchen, a payment terminal</li><li><strong>Kitchen staff are 'injected' with:</strong> Recipes, equipment, inventory access</li><li><strong>Cashiers are 'injected' with:</strong> A payment system, receipt printer, tax calculator</li></ul><p><strong>Benefits of this approach:</strong></p><ul><li>⚡ <strong>Efficient:</strong> No duplicate work or equipment</li><li>🔄 <strong>Flexible:</strong> Easy to change payment processors or menu systems</li><li>🧪 <strong>Trainable:</strong> New staff can practice with training versions</li><li>🛠 <strong>Maintainable:</strong> Update the system once, everyone gets the update</li><li>🎯 <strong>Focused:</strong> Each person focuses on their main job</li></ul></div>",
    position: 6
  },
  {
    block_type: "image",
    file_url: "https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=800&h=500&fit=crop", 
    alt_text: "Professional restaurant kitchen with organized stations and equipment",
    position: 7
  },
  {
    block_type: "text",
    content: "<h2>🔗 Connecting Restaurant Concepts to Software</h2><p>Now let's see how this restaurant example directly translates to software development:</p><table style='width: 100%; border-collapse: collapse; margin: 1rem 0;'><thead><tr style='background-color: #f5f5f5;'><th style='padding: 0.75rem; border: 1px solid #ddd;'>Restaurant Component</th><th style='padding: 0.75rem; border: 1px solid #ddd;'>Software Equivalent</th><th style='padding: 0.75rem; border: 1px solid #ddd;'>What It Does</th></tr></thead><tbody><tr><td style='padding: 0.75rem; border: 1px solid #ddd;'>Waiter</td><td style='padding: 0.75rem; border: 1px solid #ddd;'>OrderController class</td><td style='padding: 0.75rem; border: 1px solid #ddd;'>Handles incoming requests</td></tr><tr style='background-color: #f9f9f9;'><td style='padding: 0.75rem; border: 1px solid #ddd;'>Kitchen</td><td style='padding: 0.75rem; border: 1px solid #ddd;'>OrderProcessor class</td><td style='padding: 0.75rem; border: 1px solid #ddd;'>Processes business logic</td></tr><tr><td style='padding: 0.75rem; border: 1px solid #ddd;'>Cash Register</td><td style='padding: 0.75rem; border: 1px solid #ddd;'>PaymentService class</td><td style='padding: 0.75rem; border: 1px solid #ddd;'>Handles payments</td></tr><tr style='background-color: #f9f9f9;'><td style='padding: 0.75rem; border: 1px solid #ddd;'>Inventory System</td><td style='padding: 0.75rem; border: 1px solid #ddd;'>Database class</td><td style='padding: 0.75rem; border: 1px solid #ddd;'>Stores and retrieves data</td></tr><tr><td style='padding: 0.75rem; border: 1px solid #ddd;'>Restaurant Manager</td><td style='padding: 0.75rem; border: 1px solid #ddd;'>Dependency Injection Container</td><td style='padding: 0.75rem; border: 1px solid #ddd;'>Provides dependencies to classes</td></tr></tbody></table>",
    position: 8
  }
])

# Lesson 3: Breaking Down the Restaurant Components
lesson3 = created_lessons[2]
lesson3.content_blocks.create!([
  {
    block_type: "text",
    content: "<h1>Breaking Down the Restaurant: Components and Dependencies</h1><p>Now that we understand the basic restaurant concept, let's dive deeper into how each component depends on others and what this teaches us about software design.</p>",
    position: 1
  },
  {
    block_type: "text",
    content: "<h2>🔍 Detailed Component Analysis</h2><p>Let's examine each restaurant component like a software architect would:</p><h3>1. 🍝 Order Taking System (Front-End/Controller)</h3><div style='background-color: #f5f5f5; padding: 1rem; border-radius: 8px; margin: 1rem 0;'><h4>What it does:</h4><ul><li>Receives customer requests (orders)</li><li>Validates what's available</li><li>Calculates pricing</li><li>Passes orders to kitchen</li></ul><h4>What it depends on:</h4><ul><li><strong>Menu Service:</strong> To know current offerings and prices</li><li><strong>Inventory Service:</strong> To check item availability</li><li><strong>Customer Service:</strong> To handle customer information</li><li><strong>Pricing Service:</strong> To calculate totals and taxes</li><li><strong>Kitchen Service:</strong> To send orders for preparation</li></ul></div>",
    position: 2
  },
  {
    block_type: "text",
    content: "<h3>2. 👨‍🍳 Kitchen System (Business Logic/Service Layer)</h3><div style='background-color: #e8f5e8; padding: 1rem; border-radius: 8px; margin: 1rem 0;'><h4>What it does:</h4><ul><li>Receives orders from waiters</li><li>Coordinates food preparation</li><li>Manages cooking timing</li><li>Notifies when orders are complete</li></ul><h4>What it depends on:</h4><ul><li><strong>Recipe Database:</strong> Instructions for making each dish</li><li><strong>Inventory System:</strong> To check and reserve ingredients</li><li><strong>Equipment Manager:</strong> To access ovens, stoves, etc.</li><li><strong>Timer Service:</strong> To track cooking times</li><li><strong>Quality Control:</strong> To ensure food meets standards</li><li><strong>Notification Service:</strong> To alert waiters when ready</li></ul></div>",
    position: 3
  },
  {
    block_type: "text",
    content: "<h3>3. 💳 Payment System (External Service Integration)</h3><div style='background-color: #fff3e0; padding: 1rem; border-radius: 8px; margin: 1rem 0;'><h4>What it does:</h4><ul><li>Processes customer payments</li><li>Handles different payment methods</li><li>Calculates taxes and tips</li><li>Generates receipts</li></ul><h4>What it depends on:</h4><ul><li><strong>Order Service:</strong> To know what to charge</li><li><strong>Tax Calculator:</strong> For accurate tax computation</li><li><strong>Credit Card Processor:</strong> For card transactions</li><li><strong>Receipt Printer:</strong> To provide customer receipts</li><li><strong>Bank API:</strong> To verify and process payments</li></ul></div>",
    position: 4
  },
  {
    block_type: "image",
    file_url: "https://images.unsplash.com/photo-1559329007-40df8a9345d8?w=800&h=500&fit=crop",
    alt_text: "Restaurant point-of-sale system and payment processing",
    position: 5
  },
  {
    block_type: "text",
    content: "<h2>🔗 The Dependency Chain</h2><p>Here's what happens when a customer places an order - notice how each step depends on multiple other systems:</p><div style='background-color: #e3f2fd; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;'><h3>📋 Order Flow with Dependencies:</h3><ol><li><strong>Customer places order</strong> → Waiter uses <em>Order System</em></li><li><strong>Check availability</strong> → Order System calls <em>Menu Service</em> and <em>Inventory Service</em></li><li><strong>Calculate price</strong> → Order System uses <em>Pricing Service</em> and <em>Tax Calculator</em></li><li><strong>Send to kitchen</strong> → Order System calls <em>Kitchen Service</em></li><li><strong>Kitchen prepares food</strong> → Kitchen uses <em>Recipe Database</em>, <em>Inventory</em>, and <em>Equipment Manager</em></li><li><strong>Food ready notification</strong> → Kitchen uses <em>Notification Service</em></li><li><strong>Process payment</strong> → Payment System uses <em>Credit Card Processor</em> and <em>Receipt Printer</em></li></ol></div><p>Each step depends on multiple other systems working correctly. This is exactly like software!</p>",
    position: 6
  },
  {
    block_type: "text",
    content: "<h2>🚨 What Goes Wrong Without Proper Dependencies</h2><h3>Scenario 1: Waiter Creates Own Menu</h3><p>Imagine if each waiter created their own personal menu:</p><ul><li>❌ Waiter A says pizza costs $12</li><li>❌ Waiter B says pizza costs $15</li><li>❌ Waiter C doesn't even have pizza on their menu</li><li>❌ Kitchen doesn't know what prices to expect</li><li>❌ Customers get confused and angry</li></ul><h3>Scenario 2: Kitchen Creates Own Inventory</h3><p>What if each cook managed their own ingredient storage:</p><ul><li>❌ Cook A hoards all the tomatoes</li><li>❌ Cook B runs out of cheese</li><li>❌ Cook C doesn't know what's available</li><li>❌ Massive food waste and inconsistency</li><li>❌ Can't track overall restaurant inventory</li></ul>",
    position: 7
  },
  {
    block_type: "text",
    content: "<h2>✅ The Smart Solution: Central Management</h2><p>Smart restaurants solve this with centralized dependency management:</p><div style='background-color: #e8f5e8; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;'><h3>🎯 Restaurant Manager (Like DI Container) provides:</h3><ul><li><strong>One official menu</strong> → All waiters get the same menu service</li><li><strong>Central inventory system</strong> → Everyone checks the same stock levels</li><li><strong>Shared payment terminal</strong> → Consistent pricing and processing</li><li><strong>Common recipe database</strong> → All cooks follow the same recipes</li><li><strong>Unified notification system</strong> → Everyone gets alerts the same way</li></ul><p><strong>Result:</strong> Consistency, efficiency, and easy management!</p></div>",
    position: 8
  }
])

# Lesson 4: The Problems DI Solves
lesson4 = created_lessons[3]
lesson4.content_blocks.create!([
  {
    block_type: "text",
    content: "<h1>The Problems: Why We Need Dependency Injection</h1><p>Before we look at code, let's understand exactly what problems dependency injection solves. These problems are real, expensive, and affect every software project.</p>",
    position: 1
  },
  {
    block_type: "text",
    content: "<h2>🧪 Problem #1: The Testing Nightmare</h2><div style='background-color: #ffebee; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;'><h3>Without Dependency Injection:</h3><p><strong>Imagine testing a waiter who has hardcoded dependencies:</strong></p><ul><li>To test order taking, you need a <em>real kitchen</em> running</li><li>To test payment processing, you need <em>real credit card charges</em></li><li>To test inventory checks, you need a <em>real database</em> with actual food</li><li>Tests are slow (waiting for real systems)</li><li>Tests are expensive (real transactions)</li><li>Tests are unreliable (external systems can fail)</li><li>Tests can't simulate error conditions easily</li></ul></div><div style='background-color: #e8f5e8; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;'><h3>With Dependency Injection:</h3><p><strong>Testing becomes easy and controlled:</strong></p><ul><li>Use a <em>fake kitchen</em> that instantly 'cooks' food</li><li>Use a <em>mock payment system</em> that simulates success/failure</li><li>Use an <em>in-memory database</em> with test data</li><li>Tests run in milliseconds</li><li>Tests cost nothing to run</li><li>Tests are completely reliable</li><li>Easy to test edge cases and error scenarios</li></ul></div>",
    position: 2
  },
  {
    block_type: "text",
    content: "<h2>🔒 Problem #2: The Vendor Lock-in Trap</h2><p>When components create their own dependencies, you get locked into specific implementations:</p><div style='background-color: #fff3e0; padding: 1rem; border-radius: 8px; margin: 1rem 0;'><h3>Real Restaurant Example:</h3><p><strong>Bad:</strong> Each waiter buys and hardcodes their own specific credit card reader (Square terminal)</p><ul><li>❌ What if Square raises prices?</li><li>❌ What if Square goes out of business?</li><li>❌ What if you want to switch to a better processor?</li><li>❌ You'd have to retrain every waiter and replace every terminal</li></ul><p><strong>Good:</strong> Restaurant manager chooses one payment system and provides it to all waiters</p><ul><li>✅ Easy to negotiate better rates</li><li>✅ Easy to switch processors</li><li>✅ Waiters don't need to learn new systems</li><li>✅ One decision affects the whole restaurant</li></ul></div>",
    position: 3
  },
  {
    block_type: "text",
    content: "<h2>🔧 Problem #3: The Maintenance Nightmare</h2><div style='background-color: #f3e5f5; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;'><h3>Scenario: Menu Price Update</h3><p><strong>Without DI (each waiter has own menu):</strong></p><ul><li>❌ Pizza price changes from $12 to $14</li><li>❌ You must update 20 different waiter menus</li><li>❌ High chance of missing some waiters</li><li>❌ Inconsistent pricing confuses customers</li><li>❌ Takes hours to implement a simple change</li></ul><p><strong>With DI (central menu service):</strong></p><ul><li>✅ Update price in one place</li><li>✅ All waiters instantly see the new price</li><li>✅ Guaranteed consistency</li><li>✅ Takes minutes to implement</li></ul></div>",
    position: 4
  },
  {
    block_type: "image",
    file_url: "https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?w=800&h=500&fit=crop",
    alt_text: "Frustrated person at computer showing software maintenance difficulties",
    position: 5
  },
  {
    block_type: "text",
    content: "<h2>⚡ Problem #4: The Performance and Resource Waste</h2><p>Creating dependencies internally leads to massive waste:</p><h3>Restaurant Waste Examples:</h3><div style='display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; margin: 1rem 0;'><div style='padding: 1rem; background-color: #ffebee; border-radius: 8px;'><h4>❌ Without DI</h4><ul><li>Each waiter buys own credit card reader ($200 × 10 waiters = $2000)</li><li>Each cook sets up own inventory system</li><li>Duplicate equipment everywhere</li><li>Each person spends time on setup instead of core work</li></ul></div><div style='padding: 1rem; background-color: #e8f5e8; border-radius: 8px;'><h4>✅ With DI</h4><ul><li>One shared payment system ($500 total)</li><li>One central inventory system</li><li>Shared resources, no duplication</li><li>People focus on their main jobs</li></ul></div></div>",
    position: 6
  },
  {
    block_type: "text",
    content: "<h2>🎯 Problem #5: Single Responsibility Violation</h2><p>When objects create their own dependencies, they take on too many responsibilities:</p><div style='background-color: #e1f5fe; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;'><h3>What Should a Waiter Focus On?</h3><p><strong>Core Responsibility:</strong> Taking orders, serving customers, ensuring good experience</p><p><strong>What happens without DI:</strong></p><ul><li>❌ Waiter also becomes IT support (setting up payment systems)</li><li>❌ Waiter becomes accountant (managing pricing systems)</li><li>❌ Waiter becomes inventory manager (tracking stock)</li><li>❌ Core service suffers because attention is divided</li></ul><p><strong>With DI:</strong></p><ul><li>✅ Waiter focuses only on customer service</li><li>✅ Other specialists handle other concerns</li><li>✅ Everyone becomes expert in their area</li><li>✅ Better overall results</li></ul></div>",
    position: 7
  },
  {
    block_type: "text",
    content: "<h2>💰 The Real Cost of These Problems</h2><p>Let's put numbers to these problems to understand their impact:</p><table style='width: 100%; border-collapse: collapse; margin: 1rem 0;'><thead><tr style='background-color: #f5f5f5;'><th style='padding: 0.75rem; border: 1px solid #ddd;'>Problem</th><th style='padding: 0.75rem; border: 1px solid #ddd;'>Time Cost</th><th style='padding: 0.75rem; border: 1px solid #ddd;'>Money Cost</th><th style='padding: 0.75rem; border: 1px solid #ddd;'>Risk Level</th></tr></thead><tbody><tr><td style='padding: 0.75rem; border: 1px solid #ddd;'>Difficult Testing</td><td style='padding: 0.75rem; border: 1px solid #ddd;'>10x slower tests</td><td style='padding: 0.75rem; border: 1px solid #ddd;'>More bugs in production</td><td style='padding: 0.75rem; border: 1px solid #ddd;'>High</td></tr><tr style='background-color: #f9f9f9;'><td style='padding: 0.75rem; border: 1px solid #ddd;'>Vendor Lock-in</td><td style='padding: 0.75rem; border: 1px solid #ddd;'>Weeks to switch</td><td style='padding: 0.75rem; border: 1px solid #ddd;'>Higher vendor costs</td><td style='padding: 0.75rem; border: 1px solid #ddd;'>Medium</td></tr><tr><td style='padding: 0.75rem; border: 1px solid #ddd;'>Hard Maintenance</td><td style='padding: 0.75rem; border: 1px solid #ddd;'>Hours vs minutes</td><td style='padding: 0.75rem; border: 1px solid #ddd;'>Developer time</td><td style='padding: 0.75rem; border: 1px solid #ddd;'>High</td></tr><tr style='background-color: #f9f9f9;'><td style='padding: 0.75rem; border: 1px solid #ddd;'>Resource Waste</td><td style='padding: 0.75rem; border: 1px solid #ddd;'>Setup overhead</td><td style='padding: 0.75rem; border: 1px solid #ddd;'>Duplicate systems</td><td style='padding: 0.75rem; border: 1px solid #ddd;'>Medium</td></tr><tr><td style='padding: 0.75rem; border: 1px solid #ddd;'>Mixed Responsibilities</td><td style='padding: 0.75rem; border: 1px solid #ddd;'>Slower development</td><td style='padding: 0.75rem; border: 1px solid #ddd;'>Quality issues</td><td style='padding: 0.75rem; border: 1px solid #ddd;'>High</td></tr></tbody></table>",
    position: 8
  }
])

# Continue with remaining lessons and assignments...

puts "✅ Added content blocks to first 4 comprehensive lessons"

# Complete the course with a comprehensive assignment
puts "\n📋 Creating comprehensive final assessment..."

# Create assignment attached to the final lesson for now
assignment = created_lessons[-1].assignments.create!(
  title: "Complete Dependency Injection Mastery Assessment",
  assignment_type: "quiz", 
  published: true,
  max_score: 100
)

# Create comprehensive questions covering all aspects of the course
questions_data = [
  {
    question_text: "What is the fundamental principle behind Dependency Injection?",
    question_type: "multiple_choice",
    points: 10,
    correct_answer: "2", 
    options: { 
      choices: [
        "Objects should create all their own dependencies internally for better control",
        "Dependencies should be created using global variables for easier access", 
        "Objects should receive their dependencies from external sources rather than creating them internally",
        "Dependencies should be hardcoded to ensure they never change"
      ]
    }
  },
  {
    question_text: "In our restaurant management system example, what does the OrderProcessor represent in software terms?",
    question_type: "multiple_choice",
    points: 10,
    correct_answer: "1",
    options: {
      choices: [
        "A waiter taking customer orders",
        "A business logic service that coordinates multiple operations",
        "A database storing customer information", 
        "A payment processing system"
      ]
    }
  },
  {
    question_text: "What is the biggest advantage of using mock services in testing?",
    question_type: "multiple_choice",
    points: 10,
    correct_answer: "2",
    options: {
      choices: [
        "Mock services run slower, giving you more time to analyze results",
        "Mock services use more memory, providing better performance testing",
        "Mock services eliminate external dependencies, making tests fast, reliable, and cost-free",
        "Mock services automatically fix bugs in your code"
      ]
    }
  },
  {
    question_text: "Which Ruby code correctly demonstrates dependency injection?",
    question_type: "multiple_choice",
    points: 15,
    correct_answer: "1", 
    options: {
      choices: [
        "class OrderService\n  def initialize\n    @payment = StripePayment.new\n  end\nend",
        "class OrderService\n  def initialize(payment_service:)\n    @payment = payment_service\n  end\nend",
        "class OrderService\n  def payment\n    @payment ||= StripePayment.new\n  end\nend",
        "class OrderService\n  PAYMENT = StripePayment.new\nend"
      ]
    }
  },
  {
    question_text: "What problem does dependency injection solve regarding testing?",
    question_type: "multiple_choice",
    points: 15,
    correct_answer: "1",
    options: {
      choices: [
        "It makes tests run slower so you can debug them better",
        "It allows you to replace real external services with fast, controlled mock services",
        "It automatically generates test cases for you",
        "It eliminates the need to write any tests"
      ]
    }
  },
  {
    question_text: "In the restaurant analogy, what problem would occur if each waiter created their own payment terminal?",
    question_type: "multiple_choice",
    points: 10,
    correct_answer: "0",
    options: {
      choices: [
        "Expensive duplication, inconsistent pricing, difficult maintenance, and hard to train new staff",
        "Waiters would serve customers faster",
        "The restaurant would make more money",
        "Payment processing would be more secure"
      ]
    }
  },
  {
    question_text: "What does 'tight coupling' mean in software development?",
    question_type: "multiple_choice",
    points: 10,
    correct_answer: "2",
    options: {
      choices: [
        "Classes that work very efficiently together",
        "Classes that are physically located close to each other in the codebase",
        "Classes that are heavily dependent on specific implementations of other classes, making changes difficult",
        "Classes that use the same variable names"
      ]
    }
  },
  {
    question_text: "Which SOLID principle is most directly implemented by Dependency Injection?",
    question_type: "multiple_choice",
    points: 15,
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
    question_text: "What is the main benefit of being able to 'swap implementations' with dependency injection?",
    question_type: "multiple_choice",
    points: 10,
    correct_answer: "1",
    options: {
      choices: [
        "It makes your code run faster",
        "It allows you to easily switch between different services (like payment processors) without changing your business logic",
        "It reduces the amount of code you need to write",
        "It automatically handles errors for you"
      ]
    }
  },
  {
    question_text: "True or False: With proper dependency injection, you can test your OrderProcessor class without making real API calls, database queries, or sending actual emails.",
    question_type: "true_false",
    points: 5,
    correct_answer: "1",
    options: {}
  }
]

# Create all questions
questions_data.each_with_index do |question_data, index|
  assignment.assignment_questions.create!(question_data)
  puts "✅ Created comprehensive question #{index + 1}: #{question_data[:question_text][0..50]}..."
end

puts "✅ Created comprehensive assessment with #{assignment.assignment_questions.count} questions"

puts "\n🎉 Comprehensive Dependency Injection Course creation complete!"
puts "Course: #{comprehensive_di_course.title}"
puts "Lessons: #{comprehensive_di_course.lessons.count} comprehensive lessons"
puts "Assignment: #{assignment.title} with #{assignment.assignment_questions.count} detailed questions"
puts "Total course duration: #{comprehensive_di_course.duration} hours"
puts "File location: /vagrant/db/seeds/courses/create_comprehensive_dependency_injection_course.rb"
