class AuthController < ApplicationController
  skip_before_filter :authorize_user!, except: [:logout]

  def login
    redirect_to '/auth/google_oauth2'
  end

  def logout
    logout_user!
    redirect_to root_path
  end

  def callback
    player = Player.find_or_create_by(guid: guid)

    player.update_attributes(email: identity.email,
                           name: [identity.first_name, identity.last_name].join(' '))
                           # access_token: credentials.token,
                           # refresh_token: credentials.refresh_token,
                           # token_expires_at: Time.at(credentials.expires_at))

    login_user!(player)
    redirect_to root_path
  end

  private

  def login_user!(player)
    @current_player = player
    session[:guid] = player.guid
    flash[:notice] = "Hello #{current_player.name}"
  end

  def logout_user!
    @current_player = session[:guid] = nil
  end

  def credentials
    request.env['omniauth.auth'].credentials
  end

  def guid
    request.env['omniauth.auth'].uid
  end

  def identity
    request.env['omniauth.auth'].info
  end
end
