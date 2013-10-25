module Procemon
  class << self


    def process_parameters
      ARGV.each do |one_param|

        case one_param.downcase

          when "--debug","-deb"
            $DEBUG= true

          when "--test","-test"
            $TEST= true

          when "--database_init","-init"
            Application.db_init= true

          when "--daemon","-d"
            Application.daemon= "start"

          when "--kill","-kill"
            Application.daemon= "stop"


          when "--config","-c"
            Application.config_file= ARGV[(ARGV.index(one_param)+1)]

          when "--environment","-e"
            Application.environment= ARGV[(ARGV.index(one_param)+1)]

          when "--documentation","--generate_documentation","-doc"
            Application.create_documentation= true

          when "--db_drop","--drop_database","-dbdrop"
            Application.db_drop= true

          when "-log","--log"
            Application.log= ARGV[(ARGV.index(one_param)+1)]
            Application.daemon_stderr= ARGV[(ARGV.index(one_param)+1)]+"_stderr"

          when "-pid","--pid"
            Application.log= ARGV[(ARGV.index(one_param)+1)]

          when "--help","-h","-help","help"
            puts "",["This are trigger a documentation generation and than exit the application:",
                     "--documentation",
                     "--generate_documentation",
                     "-doc","",
                     "This is for set target ENV to the Application by name",
                     "--environment","-e","",
                     "this is for target a config file:",
                     "--config","-c","",
                     "This is for start application as a forked background process",
                     "--daemon","-d","",
                     "This is for drop database data",
                     "--db_drop","--drop_database","-dbdrop","",
                     "This is for send init command at start up for database",
                     "--database_init","-init","",
                     "This is for start in debug mode",
                     "--debug","-deb","",
                     "This is for set pid file location by path",
                     "-pid","--pid","",
                     "This is for set log file location by path",
                     "-log","--log","",
                     "This is for to stop daemonized application",
                     "--kill","-kill",""

            ].each{|element| element.include?('--') ? element.gsub!('--',"\t--") : element.gsub!('-',"\t -")}.join("\n"),""
            Process.exit!


        end

      end

    end
  end
end
