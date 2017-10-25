class Cat < ApplicationRecord

  COLORS = %w( White Black Orange Calico Blue )

  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :sex, inclusion: { in: %w(M F) }
  validates :color, inclusion: { in: COLORS }



  def age
    dob = self.birth_date
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

  def self.colors
    COLORS
  end

  has_many :cat_rental_requests

end
