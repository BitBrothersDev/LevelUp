json.extract! skill_category, :id, :name, :parent_category_id, :daughter_category_id, :created_at, :updated_at
json.url skill_category_url(skill_category, format: :json)
