module Procemon
  class << self

    require "tmpdir"
    def tmpdir_init
      begin
        Dir.mkdir File.join(Dir.tmpdir,$0)
      rescue Errno::EEXIST
      end

      Application.tmpdir=         File.join(Dir.tmpdir,$0)

      Application.pid=            File.join(Application.tmpdir,"pid")
      Application.log=            File.join(Application.tmpdir,"log")
      Application.daemon_stderr=  File.join(Application.tmpdir,"daemon_stderr")

    end

  end
end
