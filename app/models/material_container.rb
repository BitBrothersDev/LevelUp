class MaterialContainer < ApplicationRecord
  belongs_to :job_function
  belongs_to :level

  def to_s
    [level.title, job_function.title].join(' ')
  end
end
