SocialSearchRailsExample::Application.routes.draw do

  namespace 'api' do
    match 'auth/:provider/callback' => 'contacts#auth', :via => :get
    match 'contacts/:name' => 'contacts#search', :via => :get
  end

end
