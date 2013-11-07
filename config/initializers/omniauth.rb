Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "297395903661813", "087df3a0f9b9954b11fe31c919d0406e",
  	:scope => 'email,user_birthday,read_stream', :callback_path => "/api/auth/facebook/callback"
end