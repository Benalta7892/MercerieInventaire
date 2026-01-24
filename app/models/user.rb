class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_validation :assign_admin_if_owner_email
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :categories, dependent: :destroy
  has_many :fournitures, dependent: :destroy
  has_one :liste_achat, dependent: :destroy
  has_one_attached :avatar

  validate :admin_must_be_owner_email
  validates :name, presence: true

  after_create :initialize_liste_achat

  private

  def initialize_liste_achat
    create_liste_achat unless liste_achat
  end

  def owner_email
    ENV.fetch("ADMIN_EMAIL", "").downcase
  end

  def assign_admin_if_owner_email
    self.admin = (email.to_s.downcase == owner_email)
  end

  def admin_must_be_owner_email
    return unless admin

    errors.add(:admin, "interdit") unless email.to_s.downcase == owner_email
  end
end
