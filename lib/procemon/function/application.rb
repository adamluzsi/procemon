module Application

  class << self
    attr_accessor :config,
                  :environment,
                  :tmpdir,
                  :daemon_stderr,
                  :log,
                  :pid,
                  :name,
                  :db_init,
                  :db_drop,
                  :daemon,
                  :config_file,
                  :create_documentation,
                  :client
  end

  self.client      ||= Hash.new()
  self.config      ||= Hash.new()
  self.environment ||= String.new()

end

App= Application unless defined?(App)
