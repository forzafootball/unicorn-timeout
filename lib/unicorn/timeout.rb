module Unicorn
  class Timeout
    @timeout = 15
    @handler = lambda { |backtrace| STDERR.puts("Unicorn::Timeout is killing worker ##{Process.pid} with backtrace:\n#{backtrace.inspect}") }
    @signal = "TERM"
    MUTEX_FOR_TIMEOUT = Mutex.new

    class << self
      attr_accessor :timeout
      attr_accessor :handler
      attr_accessor :signal
    end

    def initialize(app)
      @app = app
    end

    def call(env)
      t = setup_mon_thread

      begin
        @app.call(env)
      ensure
        kill_mon_thread(t)
      end
    end

    private
      def setup_mon_thread
        main_thread = Thread.current

        Thread.new do
          sleep(self.class.timeout)
          kill_main_thread(main_thread)
        end
      end

      def kill_main_thread(t)
        MUTEX_FOR_TIMEOUT.synchronize do
          begin
            self.class.handler.call(t.backtrace)
          ensure
            Process.kill(self.class.signal, Process.pid)
          end
        end
      end

      def kill_mon_thread(t)
        MUTEX_FOR_TIMEOUT.synchronize do
          t.kill
          t.join
        end
      end

  end
end
