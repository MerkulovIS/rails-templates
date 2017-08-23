  devise :ldap_authenticatable, :trackable, :timeoutable #, authentication_keys: [:login]

  def timeout_in
    15.minutes
  end

  def get_ldap_param(param)
    res = Devise::LDAP::Adapter.get_ldap_param(self.login, param)
    res.first.force_encoding('utf-8') unless res.nil?
  end

  def after_ldap_authentication
    self.mail = get_ldap_param('mail')
    self.username = get_ldap_param('displayname')
    self.save
  end