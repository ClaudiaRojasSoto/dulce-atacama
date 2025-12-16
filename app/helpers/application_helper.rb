module ApplicationHelper
  WHATSAPP_NUMBER = "56996972920"
  
  def whatsapp_order_link(product, quantity: 1)
    return "#" unless user_signed_in? && current_user.profile_complete?
    
    message = "Hola! Me interesa hacer un pedido:\n\n"
    message += "🍰 *#{product.name}*\n"
    message += "💰 Precio: $#{number_with_delimiter(product.price)}\n"
    message += "📦 Cantidad: #{quantity}\n"
    message += "💵 Total: $#{number_with_delimiter(product.price * quantity)}\n\n"
    
    # Agregar datos del cliente
    if user_signed_in?
      message += "📋 *Mis datos:*\n"
      message += "👤 Nombre: #{current_user.full_name}\n"
      message += "📧 Email: #{current_user.email}\n"
      message += "📱 Teléfono: #{current_user.phone}\n\n"
    end
    
    message += "Por favor, necesito más información sobre:\n"
    message += "- Fecha y hora de entrega\n"
    message += "- Dirección de entrega\n"
    message += "- Forma de pago"
    
    "https://wa.me/#{WHATSAPP_NUMBER}?text=#{CGI.escape(message)}"
  end
  
  def whatsapp_contact_link
    message = if user_signed_in?
      "Hola! Soy #{current_user.full_name}. Tengo una consulta sobre los productos de Dulce Atacama"
    else
      "Hola! Tengo una consulta sobre los productos de Dulce Atacama"
    end
    "https://wa.me/#{WHATSAPP_NUMBER}?text=#{CGI.escape(message)}"
  end
  
  def user_can_order?
    user_signed_in? && current_user.profile_complete?
  end
end
