puts "Cleaning database..."
OrderItem.destroy_all
Order.destroy_all
Product.destroy_all
Category.destroy_all
Promotion.destroy_all
User.destroy_all

puts "Creating admin user..."
admin = User.create!(
  email: "admin@dulceatacama.cl",
  password: "password123",
  password_confirmation: "password123",
  role: :admin
)

puts "Creating customer user..."
customer = User.create!(
  email: "cliente@example.com",
  password: "password123",
  password_confirmation: "password123",
  role: :customer
)

puts "Creating categories..."
categories = [
  { name: "Tortas", description: "Deliciosas tortas artesanales para toda ocasión" },
  { name: "Pasteles", description: "Pasteles individuales y familiares" },
  { name: "Cupcakes", description: "Cupcakes decorados con diseños únicos" },
  { name: "Galletas", description: "Galletas caseras y decoradas" },
  { name: "Postres", description: "Variedad de postres y dulces" }
]

categories_created = categories.map do |cat|
  Category.create!(cat)
end

puts "Creating products..."
require 'open-uri'

products_data = [
  { 
    name: "Torta de Chocolate", 
    description: "Torta de chocolate con relleno de manjar y cobertura de chocolate", 
    price: 25000, 
    category: categories_created[0], 
    active: true,
    image_url: "https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=800"
  },
  { 
    name: "Torta de Vainilla", 
    description: "Suave torta de vainilla con crema chantilly", 
    price: 22000, 
    category: categories_created[0], 
    active: true,
    image_url: "https://images.unsplash.com/photo-1464349095431-e9a21285b5f3?w=800"
  },
  { 
    name: "Torta Red Velvet", 
    description: "Exquisita torta red velvet con frosting de queso crema", 
    price: 28000, 
    category: categories_created[0], 
    active: true,
    image_url: "https://images.unsplash.com/photo-1586985289688-ca3cf47d3e6e?w=800"
  },
  { 
    name: "Pastel de Lúcuma", 
    description: "Pastel de lúcuma con manjar", 
    price: 3500, 
    category: categories_created[1], 
    active: true,
    image_url: "https://images.unsplash.com/photo-1563805042-7684c019e1cb?w=800"
  },
  { 
    name: "Mil Hojas", 
    description: "Clásico mil hojas con manjar", 
    price: 4000, 
    category: categories_created[1], 
    active: true,
    image_url: "https://images.unsplash.com/photo-1565958011703-44f9829ba187?w=800"
  },
  { 
    name: "Cupcakes Vainilla", 
    description: "Set de 6 cupcakes de vainilla decorados", 
    price: 8000, 
    category: categories_created[2], 
    active: true,
    image_url: "https://images.unsplash.com/photo-1614707267537-b85aaf00c4b7?w=800"
  },
  { 
    name: "Cupcakes Chocolate", 
    description: "Set de 6 cupcakes de chocolate decorados", 
    price: 8000, 
    category: categories_created[2], 
    active: true,
    image_url: "https://images.unsplash.com/photo-1599785209796-786432b228bc?w=800"
  },
  { 
    name: "Galletas Decoradas", 
    description: "Docena de galletas decoradas personalizadas", 
    price: 12000, 
    category: categories_created[3], 
    active: true,
    image_url: "https://images.unsplash.com/photo-1558961363-fa8fdf82db35?w=800"
  },
  { 
    name: "Alfajores", 
    description: "Docena de alfajores caseros", 
    price: 10000, 
    category: categories_created[3], 
    active: true,
    image_url: "https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=800"
  },
  { 
    name: "Mousse de Maracuyá", 
    description: "Delicioso mousse de maracuyá individual", 
    price: 3000, 
    category: categories_created[4], 
    active: true,
    image_url: "https://images.unsplash.com/photo-1488477181946-6428a0291777?w=800"
  },
  { 
    name: "Cheesecake", 
    description: "Porción de cheesecake con frutos rojos", 
    price: 4500, 
    category: categories_created[4], 
    active: true,
    image_url: "https://images.unsplash.com/photo-1533134486753-c833f0ed4866?w=800"
  },
  { 
    name: "Brownie", 
    description: "Brownie de chocolate con nueces", 
    price: 2500, 
    category: categories_created[4], 
    active: true,
    image_url: "https://images.unsplash.com/photo-1607920591413-4ec007e70023?w=800"
  }
]

products_created = products_data.map do |product_data|
  puts "Creating product: #{product_data[:name]}"
  image_url = product_data[:image_url]
  product = Product.create!(product_data.except(:image_url))
  
  if image_url
    begin
      URI.open(image_url) do |file|
        product.images.attach(io: file, filename: "#{product.name.parameterize}.jpg")
        puts "  ✓ Image attached"
      end
    rescue => e
      puts "  ✗ Error attaching image: #{e.message}"
    end
  end
  
  product
end

puts "Creating promotions..."
Promotion.create!([
  {
    title: "Descuento de Bienvenida",
    description: "¡15% de descuento en tu primer pedido!",
    discount_percentage: 15,
    active: true,
    valid_from: Date.today,
    valid_until: 1.month.from_now
  },
  {
    title: "Especial Fin de Semana",
    description: "20% de descuento en tortas grandes",
    discount_percentage: 20,
    active: true,
    valid_from: Date.today,
    valid_until: 2.weeks.from_now
  }
])

puts "Creating sample order..."
order = Order.create!(
  user: customer,
  phone: "+56 9 1234 5678",
  delivery_address: "Av. Copayapu 123, Copiapó",
  delivery_date: 2.days.from_now + 14.hours,
  status: :pending,
  notes: "Por favor incluir velas",
  total: 0
)

OrderItem.create!([
  { order: order, product: products_created[0], quantity: 1, price: products_created[0].price },
  { order: order, product: products_created[5], quantity: 2, price: products_created[5].price }
])

order.save!

puts "Seed data created successfully!"
puts "Admin user: admin@dulceatacama.cl / password123"
puts "Customer user: cliente@example.com / password123"
