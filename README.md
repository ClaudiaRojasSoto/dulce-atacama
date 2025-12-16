# Dulce Atacama

E-commerce web application for artisan bakery with delivery service in Copiapó, Atacama Region, Chile.

## Features

- 🍰 Product catalog with categories
- 🛒 Order system with 24-hour advance validation
- 📱 WhatsApp integration for notifications
- 👥 Authentication system with roles (admin/customer)
- 🎨 Complete administration panel
- 💰 Price and product management
- 🎉 Promotions system
- 📊 Dashboard with statistics
- 📸 Product image upload
- 🎨 Modern UI with Tailwind CSS

## Tech Stack

- Ruby 3.1.2
- Rails 7.1
- PostgreSQL
- Tailwind CSS
- Stimulus/Hotwire
- Devise (authentication)
- Pundit (authorization)
- Active Storage (images)
- Stripe (payments - basic setup)

## Installation

1. Clone the repository

2. Install dependencies:
```bash
bundle install
yarn install
```

3. Setup database:
```bash
rails db:create
rails db:migrate
rails db:seed
```

4. Start server:
```bash
bin/dev
```

Application will be available at `http://localhost:3000`

## Test Users

**Administrator:**
- Email: admin@dulceatacama.cl
- Password: password123

**Customer:**
- Email: cliente@example.com
- Password: password123

## Admin Panel

Access the admin panel at `/admin` with the administrator user.

From here you can:
- Manage products and categories
- View and update order statuses
- Create promotions
- View business statistics

## WhatsApp Integration

Orders automatically generate a WhatsApp message with order details.
Configure the WhatsApp number in:
- `app/controllers/orders_controller.rb` (line 34)

## Production Setup

For production, configure:
1. Environment variables for database
2. Stripe credentials for payments
3. Configure domain in Devise
4. Configure Active Storage for cloud storage (S3, etc.)
5. Set up email delivery service

## Project Structure

```
app/
├── controllers/
│   ├── admin/          # Admin panel controllers
│   ├── home_controller.rb
│   ├── products_controller.rb
│   └── orders_controller.rb
├── models/
│   ├── user.rb
│   ├── product.rb
│   ├── order.rb
│   ├── category.rb
│   └── promotion.rb
├── policies/           # Authorization policies
└── views/
    ├── admin/          # Admin panel views
    ├── products/
    ├── orders/
    └── home/
```

## SOLID Principles Applied

- **Single Responsibility**: Each model has a clear responsibility
- **Open/Closed**: Use of policies to extend behavior
- **Liskov Substitution**: Proper inheritance in controllers
- **Interface Segregation**: Specific concerns and modules
- **Dependency Inversion**: Use of abstractions (Pundit policies)

## Key Features Implementation

### Order Flow
1. Customer browses products
2. Creates order with delivery details
3. System validates 24-hour advance requirement
4. WhatsApp notification sent to business
5. Admin can track and update order status

### Admin Dashboard
- Real-time statistics
- Order management with status updates
- Product and category CRUD operations
- Promotion management
- Customer database for marketing

### Security
- Role-based access control with Pundit
- Authentication via Devise
- CSRF protection
- Secure password storage

## License

All rights reserved - Dulce Atacama 2024
