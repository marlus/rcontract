class Contract < ActiveRecord::Base
  belongs_to :contract_category
  belongs_to :contract_type
end
