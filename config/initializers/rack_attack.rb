# config/initializers/rack_attack.rb
class Rack::Attack
  # Où Rack::Attack stocke les compteurs
  Rack::Attack.cache.store = Rails.cache

  # Réponse quand c'est bloqué
  Rack::Attack.throttled_responder = lambda do |_req|
    [429, { "Content-Type" => "text/plain" }, ["Trop de tentatives, réessaie plus tard."]]
  end

  # 5 envois / minute par IP sur POST /contact
  throttle("contact/ip", limit: 5, period: 1.minute) do |req|
    req.ip if req.post? && req.path == "/contact"
  end
end
