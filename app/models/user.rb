class User < ApplicationRecord
    has_secure_password
    has_many :ideas, dependent: :nullify
    has_many :reviews, dependent: :nullify

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, uniqueness: true, format: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

    def full_name
        "#{first_name} #{last_name}"
    end
end
