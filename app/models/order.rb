class Order < ActiveRecord::Base
  belongs_to :group
  has_many :photos

  def complete!
    AdminMailer.new_order(self).deliver_now
  end
end