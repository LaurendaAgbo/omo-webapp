class Recall < ApplicationRecord
  has_many :admins_recall, dependent: :destroy
end
