# == Schema Information
#
# Table name: reservations
#
#  id            :integer          not null, primary key
#  restaurant_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  reserve_on    :datetime
#


class Reservation < ActiveRecord::Base
  attr_accessible :restaurant_id, :date, :time, :reserve_on
  belongs_to :restaurant
  apply_simple_captcha
  
  validate :restaurant_is_not_overbooked
  # after_create :reduce_table_qty
  
  scope :during, ->(time_of_day) {
    hour_of_day = time_of_day.change(min: 0) # e.g. 2:15pm -> 2:00pm
    
    where(
      "reserve_on >= ? AND reserve_on <= ?",
      hour_of_day,
      hour_of_day + 59.minutes
    )
  }
  
  # def reduce_table_qty
  #   restaurant.table_qty -= 1
  # end
  # 
  
  protected
  
    def restaurant_is_not_overbooked
      if restaurant.full?(reserve_on)
        errors.add(:restaurant, "is overbooked")
      end
    end

end


