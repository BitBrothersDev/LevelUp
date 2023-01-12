Rails.application.routes.draw do
  resources :estimation_skill_level_items
  devise_for :users
  resources :skill_level_items do
    resources :estimation_skill_level_items
    resources :questions
    collection do
      get :random_skill_level_item
    end
  end
  resources :skill_categories
  resources :learning_materials do
    resources :complete_materials
  end
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
  resources :questions
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "skills#index"
end
