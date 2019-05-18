class Crave < ApplicationRecord
  belongs_to :user

  has_many :matched_craves, dependent: :destroy
  has_many :matches, through: :matched_craves, dependent: :destroy

  # attr_accessor :expiration_date

  def self.all_recent
    self.where('created_at > ?', 24.hours.ago)
  end

  def self.user_recent(user_id)
    self.all_recent.where('user_id = ?', user_id)
  end

  def matched_craves_count(crave_to_compare)
    count = 0
    if self.user_id == crave_to_compare.user_id
      return 0
    end
    if self.other == crave_to_compare.other
      count+=1
    end
    if self.main_course_id == crave_to_compare.main_course_id
      count+=1
    end
    if self.dessert_id == crave_to_compare.dessert_id
      count+=1
    end
    if self.drink_id == crave_to_compare.drink_id
      count+=1
    end
    return count
  end

# Method that checks for all the craves filter and creates the appropiate ones

  def self.create_match_craved
    self.all_recent.each do |first_crave|
      self.all_recent.each do |second_crave|
        puts first_crave.user.full_name
        puts second_crave.user.full_name

        if first_crave.user.coordinates != '' && second_crave.user.coordinates != ''
          if Geocoder::Calculations.distance_between([first_crave.user.latitude, first_crave.user.longitude], [second_crave.user.latitude, second_crave.user.longitude]) < 6
            if first_crave.matched_craves_count(second_crave) >= 2 && first_crave.user.verify_matches_uniqueness(second_crave.user)
              if first_crave.user.check_for_gender_match(second_crave.user)
                @new_match = Match.create(status: nil)
                MatchedCrave.create(crave_id: first_crave.id, match_id:  @new_match.id, accepted_match: nil)
                MatchedCrave.create(crave_id: second_crave.id, match_id:  @new_match.id, accepted_match: nil)
              end
            end
          end
        end
      end
    end
  end


end
