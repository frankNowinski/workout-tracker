Rails.application.routes.draw do
  resources :workout_plans, only: [:index, :new] do
    delete '/delete_workout/:id', to: 'workouts#destroy', as: 'destroy_workout'
    resources :exercises, only: [:new, :create]
    resources :workouts, only: [:edit, :update]
  end

  delete '/delete_workout_plan/:id', to: 'workout_plans#destroy', as: 'destroy_workout_plan'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root 'static#home'
end
