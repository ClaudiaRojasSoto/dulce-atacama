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
products_data = [
  { name: "Torta de Chocolate", description: "Torta de chocolate con relleno de manjar y cobertura de chocolate", price: 25000, category: categories_created[0], active: true },
  { name: "Torta de Vainilla", description: "Suave torta de vainilla con crema chantilly", price: 22000, category: categories_created[0], active: true },
  { name: "Torta Red Velvet", description: "Exquisita torta red velvet con frosting de queso crema", price: 28000, category: categories_created[0], active: true },
  { name: "Pastel de Lúcuma", description: "Pastel de lúcuma con manjar", price: 3500, category: categories_created[1], active: true },
  { name: "Mil Hojas", description: "Clásico mil hojas con manjar", price: 4000, category: categories_created[1], active: true },
  { name: "Cupcakes Vainilla", description: "Set de 6 cupcakes de vainilla decorados", price: 8000, category: categories_created[2], active: true },
  { name: "Cupcakes Chocolate", description: "Set de 6 cupcakes de chocolate decorados", price: 8000, category: categories_created[2], active: true },
  { name: "Galletas Decoradas", description: "Docena de galletas decoradas personalizadas", price: 12000, category: categories_created[3], active: true },
  { name: "Alfajores", description: "Docena de alfajores caseros", price: 10000, category: categories_created[3], active: true },
  { name: "Mousse de Maracuyá", description: "Delicioso mousse de maracuyá individual", price: 3000, category: categories_created[4], active: true },
  { name: "Cheesecake", description: "Porción de cheesecake con frutos rojos", price: 4500, category: categories_created[4], active: true },
  { name: "Brownie", description: "Brownie de chocolate con nueces", price: 2500, category: categories_created[4], active: true }
]

products_created = products_data.map do |product_data|
  Product.create!(product_data)
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
