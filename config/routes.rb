Rails.application.routes.draw do
  namespace :api do
    post  :withdraw, to: 'atm#withdraw'
    post  :refill,   to: 'atm#refill'
  end
end
