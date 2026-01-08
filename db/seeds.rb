puts "Limpando banco de dados..."
OrderItem.destroy_all
Order.destroy_all
Product.destroy_all
User.destroy_all

puts "Criando usuário padrão..."
User.create!(
  email: "admin@amazon.pro",
  password: "password123",
  password_confirmation: "password123"
)

puts "Criando produtos..."
products = [
  { name: "Echo Dot (5ª Geração) | Som vibrante com Alexa", description: "O Echo Dot com o melhor som já lançado.", price: 429.00 },
  { name: "Kindle 11ª Geração", description: "O Kindle mais leve e compacto, agora com tela de 300 ppi.", price: 499.00 },
  { name: "Apple iPhone 15 (128 GB) — Preto", description: "Superpotente. Supersimpático.", price: 4699.00 },
  { name: "Fone de Ouvido Sony WH-1000XM5", description: "Cancelamento de ruído líder da indústria.", price: 2199.00 }
]

products.each do |p|
  Product.create!(p)
end

puts "Finalizado! Criados #{Product.count} produtos."
