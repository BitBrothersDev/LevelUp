Rails.application.routes.draw do
  devise_for :users
  resources :skill_level_items
  resources :skill_categories
  resources :learning_materials
  resources :skill_levels do
    resources :skill_level_items
    resources :learning_materials
  end
  resources :estimation_skills
  resources :material_containers
  resources :skills do
    resources :estimation_skills
  end
  resources :levels
  resources :job_functions
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "skills#index"
end
