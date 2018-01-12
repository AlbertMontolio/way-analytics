Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "sessions" }
  # sessions request should be handle by sessins controller
  root to: 'pages#home'

  get "analytics", to: "pages#analytics"
end
