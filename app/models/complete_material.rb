class CompleteMaterial < ApplicationRecord
  belongs_to :user
  belongs_to :learning_material
end
