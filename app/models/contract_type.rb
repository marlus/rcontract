class ContractType < ActiveRecord::Base
  belongs_to :contract_category
  has_many :contracts
end
