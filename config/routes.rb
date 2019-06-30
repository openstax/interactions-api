Rails.application.routes.draw do

  namespace :api do
    api_version(
      module: 'V0',
      path: { value: 'v0' },
      defaults: { format: :json },
      default: true
    ) do

      get :swagger, to: 'swagger/docs#json'
    end
  end

end
