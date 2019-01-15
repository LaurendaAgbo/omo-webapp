class AdminsRecall < ApplicationRecord
  belongs_to :recall
  belongs_to :admin

  accepts_nested_attributes_for :recall
end
