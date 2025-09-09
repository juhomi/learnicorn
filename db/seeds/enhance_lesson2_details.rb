# Enhance Lesson 2 with missing details about email services, regional payments, and configuration

# Find the course and lesson 2
course = Course.find_by(title: 'Complete Dependency Injection Guide: Theory to Production')
lesson2 = course.lessons.find_by(position: 2)

puts "Enhancing Lesson 2: #{lesson2.title}"

# Add content block about Email Service Switching
lesson2.content_blocks.create!(
  block_type: "text",
  content: %{
    <h2>📧 Example: Email Service Provider Switching</h2>
    <p>Let's see how DI makes it incredibly easy to switch between different email service providers without changing your business logic.</p>
    
    <h3>Multiple Email Service Implementations</h3>
    <pre><code class="ruby">
# Different email service implementations
class GmailService
  def initialize(api_key)
    @api_key = api_key
  end
  
  def send_email(to:, subject:, body:)
    puts "Sending via Gmail API to #{to}"
    # Gmail API implementation
    gmail_client = Gmail::Client.new(@api_key)
    gmail_client.send_email(
      to: to,
      subject: subject,
      html_body: body
    )
  end
  
  def health_check
    # Check Gmail API connectivity
    { status: 'healthy', provider: 'Gmail' }
  end
end

class SendGridService
  def initialize(api_key)
    @api_key = api_key
  end
  
  def send_email(to:, subject:, body:)
    puts "Sending via SendGrid to #{to}"
    # SendGrid API implementation
    sendgrid_client = SendGrid::API.new(api_key: @api_key)
    sendgrid_client.send_mail(
      to: to,
      subject: subject,
      content: body
    )
  end
  
  def health_check
    { status: 'healthy', provider: 'SendGrid' }
  end
end

class MailgunService
  def initialize(api_key, domain)
    @api_key = api_key
    @domain = domain
  end
  
  def send_email(to:, subject:, body:)
    puts "Sending via Mailgun to #{to}"
    # Mailgun API implementation
    mailgun_client = Mailgun::Client.new(@api_key)
    mailgun_client.send_message(@domain, {
      to: to,
      subject: subject,
      html: body
    })
  end
  
  def health_check
    { status: 'healthy', provider: 'Mailgun' }
  end
end

# File-based email for development
class FileEmailService
  def initialize(output_directory)
    @output_dir = output_directory
    FileUtils.mkdir_p(@output_dir)
  end
  
  def send_email(to:, subject:, body:)
    timestamp = Time.current.strftime("%Y%m%d_%H%M%S")
    filename = "#{@output_dir}/email_#{timestamp}_#{to.gsub('@', '_at_')}.html"
    
    File.write(filename, <<~EMAIL)
      <h2>Email to: #{to}</h2>
      <h3>Subject: #{subject}</h3>
      <div>#{body}</div>
      <hr>
      <small>Sent at: #{Time.current}</small>
    EMAIL
    
    puts "Email saved to: #{filename}"
  end
  
  def health_check
    { status: 'healthy', provider: 'File System' }
  end
end
    </code></pre>
    
    <h3>Using DI to Switch Email Providers Easily</h3>
    <pre><code class="ruby">
# Your OrderProcessor remains unchanged!
class OrderProcessor
  def initialize(email_service:, payment_processor:, inventory:)
    @email_service = email_service
    @payment_processor = payment_processor
    @inventory = inventory
  end
  
  def process_order(order)
    # Business logic never changes regardless of email provider
    unless @inventory.available?(order.product_id, order.quantity)
      @email_service.send_email(
        to: order.customer_email,
        subject: "Order Failed - Out of Stock",
        body: "Sorry, #{order.product_name} is out of stock."
      )
      return false
    end
    
    payment_result = @payment_processor.charge(order.amount, order.card_token)
    
    if payment_result.success?
      @email_service.send_email(
        to: order.customer_email,
        subject: "Order Confirmed!",
        body: generate_confirmation_email(order)
      )
      true
    else
      @email_service.send_email(
        to: order.customer_email,
        subject: "Payment Failed",
        body: "Your payment could not be processed: #{payment_result.error}"
      )
      false
    end
  end
  
  private
  
  def generate_confirmation_email(order)
    # Email template logic
    <<~HTML
      <h1>Order Confirmation</h1>
      <p>Thank you for your order!</p>
      <p>Order ID: #{order.id}</p>
      <p>Product: #{order.product_name}</p>
      <p>Total: $#{order.total}</p>
    HTML
  end
end

# Different configurations for different environments
# Production: Use Gmail
production_processor = OrderProcessor.new(
  email_service: GmailService.new(ENV['GMAIL_API_KEY']),
  payment_processor: StripePayment.new(ENV['STRIPE_SECRET_KEY']),
  inventory: DatabaseInventory.new
)

# Staging: Use SendGrid  
staging_processor = OrderProcessor.new(
  email_service: SendGridService.new(ENV['SENDGRID_API_KEY']),
  payment_processor: StripePayment.new(ENV['STRIPE_TEST_KEY']),
  inventory: DatabaseInventory.new
)

# Development: Save emails to files
development_processor = OrderProcessor.new(
  email_service: FileEmailService.new('tmp/emails'),
  payment_processor: MockPayment.new,
  inventory: InMemoryInventory.new
)

# Testing: Use mocks
test_processor = OrderProcessor.new(
  email_service: MockEmailService.new,
  payment_processor: MockPayment.new,
  inventory: MockInventory.new
)
    </code></pre>
    
    <div style="background-color: #e8f5e8; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
      <h4>✅ Benefits of This Approach:</h4>
      <ul>
        <li><strong>🔄 Easy Provider Switching:</strong> Change from Gmail to SendGrid without touching business logic</li>
        <li><strong>💰 Cost Optimization:</strong> Switch to cheaper providers when needed</li>
        <li><strong>🌍 Regional Compliance:</strong> Use different providers for different regions</li>
        <li><strong>🧪 Development Friendly:</strong> Use file-based emails in development</li>
        <li><strong>⚡ Performance:</strong> Switch to faster providers without code changes</li>
        <li><strong>🛡️ Reliability:</strong> Easy to implement fallback providers</li>
      </ul>
    </div>
  },
  position: 5
)

puts "✅ Added email service switching example"

# Add content block about Regional Payment Services
lesson2.content_blocks.create!(
  block_type: "text",
  content: %{
    <h2>🌍 Example: Regional Payment Service Support</h2>
    <p>Real-world applications often need different payment processors for different regions due to local preferences, regulations, and costs. DI makes this seamless.</p>
    
    <h3>Multiple Payment Processor Implementations</h3>
    <pre><code class="ruby">
# US Payment Processor
class StripePaymentProcessor
  def initialize(secret_key)
    @secret_key = secret_key
  end
  
  def charge(amount, card_token)
    puts "Processing $#{amount} via Stripe (US)"
    # Stripe API implementation
    begin
      charge = Stripe::Charge.create(
        amount: (amount * 100).to_i, # Stripe uses cents
        currency: 'usd',
        source: card_token
      )
      
      PaymentResult.new(
        success: true,
        transaction_id: charge.id,
        fee: amount * 0.029 + 0.30 # Stripe's US fee
      )
    rescue Stripe::CardError => e
      PaymentResult.new(success: false, error: e.message)
    end
  end
  
  def supported_currencies
    ['USD', 'CAD']
  end
  
  def health_check
    { status: 'healthy', processor: 'Stripe', region: 'US' }
  end
end

# European Payment Processor
class AdyenPaymentProcessor
  def initialize(api_key, merchant_account)
    @api_key = api_key
    @merchant_account = merchant_account
  end
  
  def charge(amount, card_token)
    puts "Processing €#{amount} via Adyen (EU)"
    # Adyen API implementation
    begin
      payment_request = {
        amount: { currency: 'EUR', value: (amount * 100).to_i },
        reference: "order_#{Time.current.to_i}",
        paymentMethod: card_token,
        merchantAccount: @merchant_account
      }
      
      response = adyen_client.payments.authorise(payment_request)
      
      PaymentResult.new(
        success: response['resultCode'] == 'Authorised',
        transaction_id: response['pspReference'],
        fee: amount * 0.025 + 0.25 # Adyen's EU fee
      )
    rescue StandardError => e
      PaymentResult.new(success: false, error: e.message)
    end
  end
  
  def supported_currencies
    ['EUR', 'GBP', 'CHF']
  end
  
  def health_check
    { status: 'healthy', processor: 'Adyen', region: 'EU' }
  end
end

# Asian Payment Processor
class AlipayPaymentProcessor
  def initialize(app_id, private_key)
    @app_id = app_id
    @private_key = private_key
  end
  
  def charge(amount, payment_token)
    puts "Processing ¥#{amount} via Alipay (Asia)"
    # Alipay API implementation
    begin
      payment_request = {
        out_trade_no: "order_#{Time.current.to_i}",
        total_amount: amount.to_s,
        subject: "Order Payment",
        auth_code: payment_token
      }
      
      response = alipay_client.execute('alipay.trade.pay', payment_request)
      
      PaymentResult.new(
        success: response['code'] == '10000',
        transaction_id: response['trade_no'],
        fee: amount * 0.006 # Alipay's lower fee structure
      )
    rescue StandardError => e
      PaymentResult.new(success: false, error: e.message)
    end
  end
  
  def supported_currencies
    ['CNY', 'HKD', 'JPY']
  end
  
  def health_check
    { status: 'healthy', processor: 'Alipay', region: 'Asia' }
  end
end

# Brazilian Payment Processor
class PagarMePaymentProcessor
  def initialize(api_key)
    @api_key = api_key
  end
  
  def charge(amount, card_token)
    puts "Processing R$#{amount} via PagarMe (Brazil)"
    # PagarMe API implementation
    begin
      transaction = PagarMe::Transaction.new(
        amount: (amount * 100).to_i, # PagarMe uses cents
        card_token: card_token,
        currency: 'BRL'
      )
      
      result = transaction.charge
      
      PaymentResult.new(
        success: result.status == 'paid',
        transaction_id: result.id,
        fee: amount * 0.039 + 0.39 # PagarMe's Brazil fee
      )
    rescue StandardError => e
      PaymentResult.new(success: false, error: e.message)
    end
  end
  
  def supported_currencies
    ['BRL']
  end
  
  def health_check
    { status: 'healthy', processor: 'PagarMe', region: 'Brazil' }
  end
end

# Payment Result class
class PaymentResult
  attr_reader :success, :transaction_id, :error, :fee
  
  def initialize(success:, transaction_id: nil, error: nil, fee: 0)
    @success = success
    @transaction_id = transaction_id
    @error = error
    @fee = fee
  end
  
  def success?
    @success
  end
end
    </code></pre>
    
    <h3>Region-Aware Order Processing</h3>
    <pre><code class="ruby">
# Enhanced OrderProcessor that handles regional differences
class RegionalOrderProcessor
  def initialize(payment_processor:, email_service:, inventory:, region:)
    @payment_processor = payment_processor
    @email_service = email_service
    @inventory = inventory
    @region = region
  end
  
  def process_order(order)
    unless @inventory.available?(order.product_id, order.quantity)
      send_out_of_stock_email(order)
      return false
    end
    
    # Convert amount to local currency if needed
    local_amount = convert_to_local_currency(order.amount, order.currency)
    
    payment_result = @payment_processor.charge(local_amount, order.payment_token)
    
    if payment_result.success?
      # Add regional processing fees to order
      order.processing_fee = payment_result.fee
      @inventory.reduce_stock(order.product_id, order.quantity)
      send_confirmation_email(order, payment_result)
      true
    else
      send_payment_failure_email(order, payment_result)
      false
    end
  end
  
  private
  
  def convert_to_local_currency(amount, from_currency)
    # In a real app, you'd use a currency conversion service
    case @region
    when 'US'
      from_currency == 'USD' ? amount : amount * 1.0 # Placeholder conversion
    when 'EU' 
      from_currency == 'EUR' ? amount : amount * 0.85
    when 'Asia'
      from_currency == 'CNY' ? amount : amount * 6.5
    when 'Brazil'
      from_currency == 'BRL' ? amount : amount * 5.2
    end
  end
  
  def send_confirmation_email(order, payment_result)
    regional_message = case @region
    when 'US'
      "Your order has been processed successfully!"
    when 'EU'
      "Your order has been processed in compliance with GDPR regulations."
    when 'Asia'
      "您的订单已成功处理！" # Chinese confirmation
    when 'Brazil'
      "Seu pedido foi processado com sucesso!" # Portuguese confirmation
    end
    
    @email_service.send_email(
      to: order.customer_email,
      subject: "Order Confirmed - #{order.id}",
      body: regional_message + " Transaction: #{payment_result.transaction_id}"
    )
  end
end

# Different regional configurations
us_processor = RegionalOrderProcessor.new(
  payment_processor: StripePaymentProcessor.new(ENV['STRIPE_US_KEY']),
  email_service: GmailService.new(ENV['GMAIL_KEY']),
  inventory: DatabaseInventory.new,
  region: 'US'
)

eu_processor = RegionalOrderProcessor.new(
  payment_processor: AdyenPaymentProcessor.new(ENV['ADYEN_KEY'], ENV['ADYEN_MERCHANT']),
  email_service: MailgunService.new(ENV['MAILGUN_KEY'], 'eu.example.com'),
  inventory: DatabaseInventory.new,
  region: 'EU'
)

asia_processor = RegionalOrderProcessor.new(
  payment_processor: AlipayPaymentProcessor.new(ENV['ALIPAY_APP_ID'], ENV['ALIPAY_KEY']),
  email_service: SendGridService.new(ENV['SENDGRID_ASIA_KEY']),
  inventory: DatabaseInventory.new,
  region: 'Asia'
)

brazil_processor = RegionalOrderProcessor.new(
  payment_processor: PagarMePaymentProcessor.new(ENV['PAGARME_KEY']),
  email_service: SendGridService.new(ENV['SENDGRID_BRAZIL_KEY']),
  inventory: DatabaseInventory.new,
  region: 'Brazil'
)
    </code></pre>
    
    <div style="background-color: #fff3e0; padding: 1.5rem; border-radius: 8px; margin: 1rem 0;">
      <h4>🌍 Regional Benefits with DI:</h4>
      <ul>
        <li><strong>💳 Optimized Payment Processing:</strong> Use the best processor for each region (lower fees, higher success rates)</li>
        <li><strong>🏛️ Regulatory Compliance:</strong> Different processors handle local regulations (PCI DSS, GDPR, etc.)</li>
        <li><strong>💱 Currency Support:</strong> Native currency processing reduces conversion fees</li>
        <li><strong>🌐 Localization:</strong> Region-specific messaging and communication</li>
        <li><strong>⚡ Performance:</strong> Use local payment processors for faster processing</li>
        <li><strong>🛡️ Risk Management:</strong> Distribute processing across multiple providers</li>
      </ul>
    </div>
  },
  position: 6
)

puts "✅ Added regional payment services example"

# Add content block about Configuration-Based Service Selection
lesson2.content_blocks.create!(
  block_type: "text",
  content: %{
    <h2>⚙️ Configuration-Based Service Selection</h2>
    <p>In production applications, you want to configure services through configuration files rather than hardcoding them. DI makes this elegant and maintainable.</p>
    
    <h3>Service Configuration Files</h3>
    <h4>config/services.yml</h4>
    <pre><code class="yaml">
production:
  email_service:
    provider: sendgrid
    api_key: <%= ENV['SENDGRID_API_KEY'] %>
  payment_service:
    provider: stripe
    secret_key: <%= ENV['STRIPE_SECRET_KEY'] %>
    region: us
  inventory_service:
    provider: database
    connection: primary
  cache_service:
    provider: redis
    url: <%= ENV['REDIS_URL'] %>

staging:
  email_service:
    provider: mailgun
    api_key: <%= ENV['MAILGUN_API_KEY'] %>
    domain: staging.example.com
  payment_service:
    provider: stripe
    secret_key: <%= ENV['STRIPE_TEST_KEY'] %>
    region: us
  inventory_service:
    provider: database
    connection: primary
  cache_service:
    provider: redis
    url: <%= ENV['REDIS_STAGING_URL'] %>

development:
  email_service:
    provider: file
    output_directory: tmp/emails
  payment_service:
    provider: mock
    always_succeed: true
  inventory_service:
    provider: memory
    initial_stock: 1000
  cache_service:
    provider: memory
    max_size: 100

test:
  email_service:
    provider: mock
    capture_emails: true
  payment_service:
    provider: mock
    always_succeed: false
  inventory_service:
    provider: mock
    default_availability: true
  cache_service:
    provider: mock
    </code></pre>
    
    <h3>Service Factory with Configuration</h3>
    <pre><code class="ruby">
# Service factory that creates services based on configuration
class ServiceFactory
  def self.create_email_service(config)
    case config['provider']
    when 'gmail'
      GmailService.new(config['api_key'])
    when 'sendgrid'
      SendGridService.new(config['api_key'])
    when 'mailgun'
      MailgunService.new(config['api_key'], config['domain'])
    when 'file'
      FileEmailService.new(config['output_directory'] || 'tmp/emails')
    when 'mock'
      MockEmailService.new(capture: config['capture_emails'])
    else
      raise "Unknown email service provider: #{config['provider']}"
    end
  end
  
  def self.create_payment_service(config)
    case config['provider']
    when 'stripe'
      case config['region']
      when 'us'
        StripePaymentProcessor.new(config['secret_key'])
      when 'eu'
        StripeEuropePaymentProcessor.new(config['secret_key'])
      else
        StripePaymentProcessor.new(config['secret_key'])
      end
    when 'adyen'
      AdyenPaymentProcessor.new(config['api_key'], config['merchant_account'])
    when 'alipay'
      AlipayPaymentProcessor.new(config['app_id'], config['private_key'])
    when 'pagarme'
      PagarMePaymentProcessor.new(config['api_key'])
    when 'mock'
      MockPaymentProcessor.new(always_succeed: config['always_succeed'])
    else
      raise "Unknown payment service provider: #{config['provider']}"
    end
  end
  
  def self.create_inventory_service(config)
    case config['provider']
    when 'database'
      DatabaseInventory.new(connection: config['connection'])
    when 'memory'
      InMemoryInventory.new(initial_stock: config['initial_stock'])
    when 'redis'
      RedisInventory.new(url: config['url'])
    when 'mock'
      MockInventory.new(default_availability: config['default_availability'])
    else
      raise "Unknown inventory service provider: #{config['provider']}"
    end
  end
end

# Configuration-based service container
class ConfigurableServiceContainer
  def initialize(environment = Rails.env)
    @environment = environment
    @config = Rails.application.config_for(:services)
    @services = {}
  end
  
  def email_service
    @services[:email_service] ||= ServiceFactory.create_email_service(
      @config['email_service']
    )
  end
  
  def payment_service
    @services[:payment_service] ||= ServiceFactory.create_payment_service(
      @config['payment_service']
    )
  end
  
  def inventory_service
    @services[:inventory_service] ||= ServiceFactory.create_inventory_service(
      @config['inventory_service']
    )
  end
  
  def order_processor
    @services[:order_processor] ||= OrderProcessor.new(
      email_service: email_service,
      payment_processor: payment_service,
      inventory: inventory_service
    )
  end
  
  def health_check
    services_health = {}
    
    [:email_service, :payment_service, :inventory_service].each do |service_name|
      service = send(service_name)
      services_health[service_name] = if service.respond_to?(:health_check)
        service.health_check
      else
        { status: 'unknown', message: 'No health check available' }
      end
    rescue StandardError => e
      services_health[service_name] = { status: 'error', message: e.message }
    end
    
    {
      environment: @environment,
      overall_status: services_health.values.all? { |h| h[:status] == 'healthy' },
      services: services_health,
      timestamp: Time.current.iso8601
    }
  end
end
    </code></pre>
    
    <h3>Rails Integration</h3>
    <pre><code class="ruby">
# config/initializers/service_container.rb
Rails.application.configure do
  config.service_container = ConfigurableServiceContainer.new
end

# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  private
  
  def service_container
    Rails.application.config.service_container
  end
  
  def order_processor
    service_container.order_processor
  end
end

# app/controllers/orders_controller.rb
class OrdersController < ApplicationController
  def create
    result = order_processor.process_order(order_params)
    
    if result
      render json: { 
        success: true, 
        message: "Order processed successfully",
        environment: Rails.env 
      }
    else
      render json: { 
        success: false, 
        message: "Order processing failed" 
      }, status: 422
    end
  rescue StandardError => e
    Rails.logger.error "Order processing error: #{e.message}"
    render json: { 
      success: false, 
      message: "Internal error occurred" 
    }, status: 500
  end
end

# Health check endpoint
class HealthController < ApplicationController
  def show
    health_status = service_container.health_check
    status_code = health_status[:overall_status] ? 200 : 503
    
    render json: health_status, status: status_code
  end
end

# config/routes.rb
Rails.application.routes.draw do
  get '/health', to: 'health#show'
  # other routes...
end
    </code></pre>
    
    <h3>Environment-Specific Behavior</h3>
    <pre><code class="ruby">
# Different behavior in each environment

# In Production:
# - Uses SendGrid for emails with real API key
# - Uses Stripe for payments with live keys  
# - Uses Redis for caching
# - All errors logged and monitored

# In Staging:
# - Uses Mailgun for emails (different provider for testing)
# - Uses Stripe test keys for safe payment testing
# - Uses staging database
# - Emails go to staging.example.com domain

# In Development:
# - Saves emails to tmp/emails directory (no real sending)
# - Uses mock payment processor (always succeeds)
# - Uses in-memory inventory (starts with 1000 items)
# - Fast startup, no external dependencies

# In Test:
# - Uses mock services that can be controlled in tests
# - Payment processor can be set to succeed or fail
# - Email service captures emails for test verification
# - Completely isolated from external services
    </code></pre>
    
    <div style="background-color: #e3f2fd; padding: 1.5rem; border-left: 4px solid #2196f3; margin: 1rem 0;">
      <h4>⚙️ Configuration Benefits:</h4>
      <ul>
        <li><strong>🔧 Environment Flexibility:</strong> Different services per environment without code changes</li>
        <li><strong>🚀 Easy Deployment:</strong> Change providers via configuration files</li>
        <li><strong>💰 Cost Management:</strong> Use cheaper services in non-production environments</li>
        <li><strong>🧪 Testing Isolation:</strong> Mock services in test environments</li>
        <li><strong>🔒 Security:</strong> API keys in environment variables, not code</li>
        <li><strong>📊 Monitoring:</strong> Centralized health checks for all services</li>
        <li><strong>⚡ Performance:</strong> Easy A/B testing of different service providers</li>
      </ul>
    </div>
  },
  position: 7
)

puts "✅ Added configuration-based service selection example"

# Update todo status
TodoWrite.new.call(todos: [
  {"id": "1", "content": "Add Gmail/email service switching example to Lesson 2", "status": "completed", "priority": "high"},
  {"id": "2", "content": "Add regional payment service support example", "status": "completed", "priority": "high"}, 
  {"id": "3", "content": "Add configuration-based service selection example", "status": "completed", "priority": "high"},
  {"id": "4", "content": "Ensure examples show practical DI benefits", "status": "completed", "priority": "medium"}
])

puts "\n🎉 Successfully enhanced Lesson 2 with comprehensive details!"
puts "Added #{lesson2.content_blocks.count} total content blocks to Lesson 2"
puts "- Email service provider switching (Gmail, SendGrid, Mailgun, File-based)"
puts "- Regional payment services (Stripe US, Adyen EU, Alipay Asia, PagarMe Brazil)"  
puts "- Configuration-based service selection with YAML configuration"
puts "- Production Rails integration examples"
puts "- Health monitoring and environment-specific behavior"