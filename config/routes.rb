Rails.application.routes.draw do
  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
             },
             controllers: {
               sessions: 'sessions',
               registrations: 'registrations'
             }  
  scope '/user' do 
    get 'me', to: 'users#me'
    put '', to: 'users#update'
  end
end