CvBuilder::Application.routes.draw do

  root :to => 'home#index'
  get '/about'          =>              'home#about' , :method=>:get , :as => :about

  devise_for :users , :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  devise_scope :user do
#    get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
    get '/user/auth:github'     => 'user/omniauth_callbacks#github'
  end


  get '/dashboard'          =>              'users/dashboard#index' , :method=>:get , :as => :dashboard


  get '/linkedin/auth'      => 'linkedin_user#auth'
  get '/linkedin/callback'  => 'linkedin_user#callback'

  get '/github/authorize'   => 'github_login#authorize'
  get '/github/callback'    => 'github_login#callback'

  get '/user/basic_info/edit'                 =>              'users/basic_info#edit'    , :method=>:get  , :as => :edit_basic_info
  get '/user/basic_info/update'               =>              'users/basic_info#update'  , :method=>:get  , :as => :update_basic_info
  get '/user/basic_info/create'               =>              'users/basic_info#create'  , :method=>:post , :as => :create_basic_info

  get '/user/technologies/edit'                 =>             'users/technologies#edit'    , :method=>:get  , :as => :edit_technologies
  get '/user/technologies/update'               =>             'users/technologies#update'  , :method=>:get  , :as => :update_technologies
  get '/user/technologies/create'               =>             'users/technologies#create'  , :method=>:post , :as => :create_technologies

  get '/user/position/new'                    =>              'users/position#new'    , :method=>:get  , :as => :new_position
  get '/user/position/:id/edit'               =>              'users/position#edit'    , :method=>:get  , :as => :edit_position
  get '/user/position/:id/update'             =>              'users/position#update'  , :method=>:get  , :as => :update_position
  get '/user/position/:id/delete'             =>              'users/position#delete'  , :method=>:get  , :as => :delete_position
  get '/user/position/create'                 =>              'users/position#create'  , :method=>:post , :as => :create_position

  get '/user/education/new'                    =>              'users/education#new'    , :method=>:get  , :as => :new_education
  get '/user/education/:id/edit'               =>              'users/education#edit'    , :method=>:get  , :as => :edit_education
  get '/user/education/:id/update'             =>              'users/education#update'  , :method=>:get  , :as => :update_education
  get '/user/education/:id/delete'             =>              'users/education#delete'  , :method=>:get  , :as => :delete_education
  get '/user/education/create'                 =>              'users/education#create'  , :method=>:post , :as => :create_education

  get '/user/github_details/:id/edit'          =>              'users/github_details#edit'    , :method=>:get  , :as => :edit_github_details
  get '/user/github_details/:id/update'        =>              'users/github_details#update'  , :method=>:get  , :as => :update_github_details
  get '/user/github_details/:id/delete'        =>              'users/github_details#delete'  , :method=>:get  , :as => :delete_github_details

  get '/user/projects/new'                    =>          'users/projects#new'    , :method=>:get  , :as => :new_projects
  get '/user/projects/:id/edit'          =>              'users/projects#edit'    , :method=>:get  , :as => :edit_projects
  get '/user/projects/:id/update'        =>              'users/projects#update'  , :method=>:get  , :as => :update_projects
  get '/user/projects/create'            =>              'users/projects#create'  , :method=>:post  , :as => :create_projects
  get '/user/projects/:id/delete'        =>              'users/projects#delete'  , :method=>:get  , :as => :delete_projects


  get '/download'                              =>              'download#download_cv'  , :method=>:get  , :as => :download_cv
  get '/preview/:id'                               =>           'download#preview'  ,    :method=>:get  , :as => :preview

  get '/users'                                 =>              'list_users#index'  , :method=>:get  , :as => :list_users

  get '/share_cv'                                 =>              'share_cv#share'  , :method=>:get  , :as => :share_cv
  get '/publish_cv'                               =>              'share_cv#publish_cv'  , :method=>:post  , :as => :publish_cv

  get '/profile/:id'                           =>              'profile#show'  , :method=>:get  , :as => :profile


end
