Rails.application.config.middleware.use OmniAuth::Builder do
  provider :vkontakte, ENV['API_KEY'], ENV['API_SECRET']
   {
      :scope => 'name',
      :display => 'popup',
      :lang => 'ru',
      :https => 1,
      :image_size => 'original'
    }
end