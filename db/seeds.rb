# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# db/seeds.rb

puts "🌱 Seed en cours..."

# --- TEMPLATE DEMO ---
demo_email = ENV.fetch("DEMO_USER_EMAIL").downcase
demo_password = ENV.fetch("DEMO_USER_PASSWORD")

template = User.find_or_initialize_by(email: demo_email)
if template.new_record?
  template.password = demo_password
  template.name = "Utilisateur Démo"
  template.admin = false
  template.blocked = false
  template.save!
  puts "✅ Template démo créé : #{template.email}"
else
  puts "ℹ️ Template démo déjà existant : #{template.email}"
end

# --- DONNÉES DEMO (idempotent) ---

# Catégories (plus complètes)
categories = {
  "Tissus" => %w[Tissus coton lin soie velours],
  "Aiguilles" => %w[Aiguilles main machine épingles],
  "Fils" => %w[Fils coton polyester surjeteuse],
  "Mercerie" => %w[Boutons fermetures élastiques biais],
  "Outils" => %w[Ciseaux découseur mètre craie],
  "Patrons" => %w[Patrons papier calque],
  "Entoilage" => %w[Entoilage thermocollant]
}

cat = {}
categories.keys.each do |name|
  cat[name] = template.categories.find_or_create_by!(name: name)
end

# Fournitures (beaucoup + variées)
items = [
  # Tissus
  { name: "Tissu coton blanc", category: "Tissus", quantity: 10, unit: "m", color: "blanc", description: "Coton polyvalent.", price_cents: 250 },
  { name: "Tissu lin naturel", category: "Tissus", quantity: 4, unit: "m", color: "beige", description: "Lin pour vêtements d’été.", price_cents: 1200 },
  { name: "Tissu jean brut", category: "Tissus", quantity: 2, unit: "m", color: "bleu", description: "Denim épais.", price_cents: 1500 },
  { name: "Tissu satin noir", category: "Tissus", quantity: 1.5, unit: "m", color: "noir", description: "Satin fluide.", price_cents: 900 },
  { name: "Tissu velours vert", category: "Tissus", quantity: 1, unit: "m", color: "vert", description: "Velours pour accessoires.", price_cents: 1800 },

  # Aiguilles
  { name: "Aiguilles à coudre", category: "Aiguilles", quantity: 50, unit: "pcs", color: "—", description: "Lot de base.", price_cents: 400 },
  { name: "Aiguilles machine universelles 80/12", category: "Aiguilles", quantity: 10, unit: "pcs", color: "—", description: "Pour tissus moyens.", price_cents: 350 },
  { name: "Aiguilles machine jean 100/16", category: "Aiguilles", quantity: 5, unit: "pcs", color: "—", description: "Pour tissus épais.", price_cents: 450 },
  { name: "Épingles fines", category: "Aiguilles", quantity: 200, unit: "pcs", color: "argent", description: "Pour tissus délicats.", price_cents: 300 },

  # Fils
  { name: "Fil polyester noir", category: "Fils", quantity: 2, unit: "bobines", color: "noir", description: "Usage général.", price_cents: 250 },
  { name: "Fil polyester blanc", category: "Fils", quantity: 2, unit: "bobines", color: "blanc", description: "Usage général.", price_cents: 250 },
  { name: "Fil coton écru", category: "Fils", quantity: 1, unit: "bobine", color: "écru", description: "Pour finitions naturelles.", price_cents: 350 },
  { name: "Fil surjeteuse (lot)", category: "Fils", quantity: 4, unit: "bobines", color: "gris", description: "Pour surfilage.", price_cents: 900 },

  # Mercerie
  { name: "Fermeture éclair 20cm", category: "Mercerie", quantity: 6, unit: "pcs", color: "noir", description: "Pour pochettes.", price_cents: 180 },
  { name: "Fermeture invisible 40cm", category: "Mercerie", quantity: 2, unit: "pcs", color: "beige", description: "Pour robes/jupes.", price_cents: 250 },
  { name: "Boutons métal 15mm", category: "Mercerie", quantity: 12, unit: "pcs", color: "argent", description: "Pour vestes.", price_cents: 60 },
  { name: "Élastique 10mm", category: "Mercerie", quantity: 3, unit: "m", color: "blanc", description: "Pour taille/poignets.", price_cents: 120 },
  { name: "Biais coton 20mm", category: "Mercerie", quantity: 2, unit: "m", color: "bleu", description: "Pour finitions.", price_cents: 150 },

  # Outils
  { name: "Ciseaux", category: "Outils", quantity: 1, unit: "pcs", color: "noir", description: "Pour découpe textile.", price_cents: 1200 },
  { name: "Découseur", category: "Outils", quantity: 1, unit: "pcs", color: "rouge", description: "Pour découdre proprement.", price_cents: 250 },
  { name: "Mètre ruban", category: "Outils", quantity: 1, unit: "pcs", color: "jaune", description: "Pour mesurer.", price_cents: 300 },
  { name: "Craie tailleur", category: "Outils", quantity: 2, unit: "pcs", color: "blanc", description: "Marquage.", price_cents: 180 },

  # Patrons
  { name: "Papier à patron", category: "Patrons", quantity: 10, unit: "feuilles", color: "—", description: "Pour tracer.", price_cents: 50 },
  { name: "Papier calque", category: "Patrons", quantity: 20, unit: "feuilles", color: "—", description: "Pour copier un patron.", price_cents: 40 },

  # Entoilage
  { name: "Thermocollant léger", category: "Entoilage", quantity: 2, unit: "m", color: "blanc", description: "Pour cols/poignets.", price_cents: 350 },
  { name: "Thermocollant moyen", category: "Entoilage", quantity: 1, unit: "m", color: "blanc", description: "Pour renforts.", price_cents: 450 }
]

items.each do |h|
  template.fournitures.find_or_create_by!(name: h[:name]) do |f|
    f.category = cat[h[:category]]
    f.quantity = h[:quantity]
    f.unit = h[:unit]
    f.price_cents = h[:price_cents]
    f.color = h[:color]
    f.description = h[:description]
  end
end

# Liste d'achats : plusieurs items (immersif)
liste = template.liste_achat || template.create_liste_achat!

wanted = [
  { name: "Tissu lin naturel", quantity: 2 },
  { name: "Fermeture invisible 40cm", quantity: 1 },
  { name: "Thermocollant léger", quantity: 1 },
  { name: "Fil polyester noir", quantity: 1 },
  { name: "Élastique 10mm", quantity: 2 }
]

wanted.each do |w|
  fourniture = template.fournitures.find_by(name: w[:name])
  next unless fourniture

  liste.liste_achat_items.find_or_create_by!(fourniture: fourniture) do |i|
    i.quantity = w[:quantity]
  end
end

puts "📦 Données démo enrichies."
puts "🎯 Seed terminé. Users total : #{User.count}"
puts "   Template: categories=#{template.categories.count}, fournitures=#{template.fournitures.count}, items=#{template.liste_achat&.liste_achat_items&.count || 0}"
