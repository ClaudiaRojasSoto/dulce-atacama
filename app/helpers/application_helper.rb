module ApplicationHelper
  WHATSAPP_NUMBER = "56996972920"
  
  def whatsapp_order_link(product, quantity: 1)
    message = "Hola! Me interesa hacer un pedido:\n\n"
    message += "🍰 *#{product.name}*\n"
    message += "💰 Precio: $#{number_with_delimiter(product.price)}\n"
    message += "📦 Cantidad: #{quantity}\n"
    message += "💵 Total: $#{number_with_delimiter(product.price * quantity)}\n\n"
    message += "Por favor, necesito más información sobre:\n"
    message += "- Fecha y hora de entrega\n"
    message += "- Dirección de entrega\n"
    message += "- Forma de pago"
    
    "https://wa.me/#{WHATSAPP_NUMBER}?text=#{CGI.escape(message)}"
  end
  
  def whatsapp_contact_link
    message = "Hola! Tengo una consulta sobre los productos de Dulce Atacama"
    "https://wa.me/#{WHATSAPP_NUMBER}?text=#{CGI.escape(message)}"
  end
end
