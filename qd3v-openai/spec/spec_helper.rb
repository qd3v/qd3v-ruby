ENV['APP_ENV']           = 'test'
ENV['APP_LOG_LEVEL']     = 'debug'
ENV['APP_TEST_COVERAGE'] = 'yes'

require 'benchmark'

$stderr.puts("[\u23F3] Require and start: %.3fms\n" % [Benchmark.realtime {
  require 'qd3v/openai'
  require 'qd3v/testing/core'

  Qd3v::DI.register_provider(:logger, from: :qd3v_core) do
    configure do
      it.log_to_stdout = false
    end
  end

  Qd3v::DI.register_provider(:webmock, from: :qd3v_testing_core)
  Qd3v::DI.finalize!
  Qd3v::OpenAI.eager_load! if ENV![:APP_TEST_COVERAGE]
}])
