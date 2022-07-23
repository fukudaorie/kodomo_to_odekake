class Child < ApplicationRecord
  belongs_to :user

  enum sex: { boy: 0, girl: 1 }
end
