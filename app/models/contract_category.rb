class ContractCategory < ActiveRecord::Base
  has_many :contract_types
end
