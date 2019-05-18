class User < ApplicationRecord

  has_secure_password

  has_one_attached :image
  belongs_to :gender, optional: true
  has_many :interested_genders, dependent: :delete_all
  has_many :liked_genders, through: :interested_genders, source: :gender

  has_many :craves , dependent: :destroy
  has_many :matches, through: :craves
  has_many :matched_craves, through: :matches

  has_many :conversations, through: :matches
  has_many :messages, dependent: :destroy

  validates :email, uniqueness: { case_sensitive: false }
  validates_inclusion_of :age, :in => 18..99, :message => "Must be at least 18"
  validates :password, length: { in: 8..20 }, allow_nil: true

  def latitude
    self.coordinates.split(' ')[0].to_f
  end

  def longitude
    self.coordinates.split(' ')[1].to_f
  end

  def age()
    now = Time.now.utc.to_date
    now.year - date_of_birth.year - ((now.month > date_of_birth.month || (now.month == date_of_birth.month && date_of_birth.day >= date_of_birth.day)) ? 0 : 1)
  end

  def last_crave()
    Crave.user_recent(self.id)[0]
  end

  def check_for_gender_match(other_user)
    if self.interested_genders.where(gender_id: other_user.gender.id ).length > 0 &&  other_user.interested_genders.where(gender_id: self.gender.id ).length > 0
      return true
    else
      return false
    end
  end

  def active_matches()
    return  ActiveModelSerializers::SerializableResource.new(self.matches.where(status: nil).order("created_at DESC"),  each_serializer: MatchSerializer)
  end

  def verify_matches_uniqueness(other_user)
    self.matches.ids.each do |match_id|
      if other_user.matches.ids.include?(match_id)
        return false
      end
    end
    return true
  end

end
