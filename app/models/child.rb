class Child < ApplicationRecord
  belongs_to :user

  enum sex: { boy: 0, girl: 1 }

  def age
    date_format = "%Y%m%d"
    (Date.today.strftime(date_format).to_i - birth_date.strftime(date_format).to_i) / 10000
  end
end
