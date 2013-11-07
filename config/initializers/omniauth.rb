require 'omniauth'
require 'omniauth-facebook'

providers = %w(facebook).inject([]) do |providers, provider|
  fpath = Rails.root.join('config', "#{provider}.yml")
 
  if File.exists?(fpath)
    config = YAML.load_file(fpath)
    providers << [ provider, config['consumer_key'], config['consumer_secret'], :callback_path => "/api/auth/facebook/callback" ]
  end
 
  providers
end
 
raise 'You have not created config/twitter.yml or config/facebook.yml' if providers.empty?
 
Rails.application.config.middleware.use OmniAuth::Builder do
  providers.each do |p|
    provider *p
  end
end
# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :facebook, "297395903661813", "087df3a0f9b9954b11fe31c919d0406e",
#   	:scope => 'email,user_birthday,read_stream', :callback_path => "/api/auth/facebook/callback"
# end