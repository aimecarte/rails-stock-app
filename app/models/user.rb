class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, presence: true     
  validates :email, presence: true, uniqueness: true 

  has_many :stocks
  has_many :transactions

  attribute :isAdmin, :boolean, default: false
  attribute :isApproved, :boolean, default: false
  
end
