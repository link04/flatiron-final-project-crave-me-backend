class User < ApplicationRecord
  has_secure_password
  has_one_attached :image
  belongs_to :gender, optional: true
  has_many :interested_genders
  has_many :liked_genders, through: :interested_genders, source: :gender
  validates :email, uniqueness: true
  validates_inclusion_of :age, :in => 18..99, :message => "must be 18 and over to Crave" 

  def age()
    now = Time.now.utc.to_date
    now.year - date_of_birth.year - ((now.month > date_of_birth.month || (now.month == date_of_birth.month && date_of_birth.day >= date_of_birth.day)) ? 0 : 1)

  end


end
