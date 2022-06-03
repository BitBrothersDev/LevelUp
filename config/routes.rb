Rails.application.routes.draw do
  resources :skill_categories
  resources :learning_materials
  resources :skill_levels do
    resources :learning_materials
  end
  resources :material_containers
  resources :skills
  resources :levels
  resources :job_functions
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
end
