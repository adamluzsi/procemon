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
                  :doc,
                  :client
  end

  self.client      ||= Hash.new()
  self.config      ||= Hash.new()
  self.environment ||= String.new()

  self.doc ||= false

end

App= Application unless defined?(App)
