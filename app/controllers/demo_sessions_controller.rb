class DemoSessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]

  def create
    template = User.find_by(email: ENV.fetch("DEMO_USER_EMAIL").downcase)
    return redirect_to(root_path, alert: "Template démo introuvable. Lance rails db:seed.") if template.nil?

    demo_user = User.create!(
      email: "demo+#{SecureRandom.hex(6)}@demo.local",
      password: SecureRandom.hex(16),
      name: "Utilisateur Démo",
      admin: false,
      blocked: false
    )

    clone_demo_data(from: template, to: demo_user)

    session[:demo_user_id] = demo_user.id
    sign_in(demo_user)

    redirect_to dashboard_path, notice: "Connecté en mode démo."
  end

  def destroy
    demo_user_id = session.delete(:demo_user_id)
    sign_out(current_user) if user_signed_in?

    User.find_by(id: demo_user_id)&.destroy if demo_user_id.present?

    redirect_to root_path, notice: "Démo réinitialisée."
  end

  private

  def clone_demo_data(from:, to:)
    cat_map = {}
    from.categories.find_each do |cat|
      new_cat = to.categories.create!(name: cat.name)
      cat_map[cat.id] = new_cat
    end

    fourn_map = {}
    from.fournitures.find_each do |f|
      new_f = to.fournitures.create!(
        name: f.name,
        category: cat_map[f.category_id],
        quantity: f.quantity,
        unit: f.unit,
        color: f.color,
        price_cents: f.price_cents,
        description: f.description
      )
      fourn_map[f.id] = new_f
    end

    return unless from.liste_achat.present?

    liste = to.create_liste_achat!
    from.liste_achat.liste_achat_items.find_each do |item|
      new_f = fourn_map[item.fourniture_id]
      next unless new_f

      liste.liste_achat_items.create!(
        fourniture: new_f,
        quantity: item.quantity
      )
    end
  end
end
