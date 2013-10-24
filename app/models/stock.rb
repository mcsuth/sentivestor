class Stock < ActiveRecord::Base

  attr_accessible :tickersymbol, :company, :user_id

  belongs_to :user

end