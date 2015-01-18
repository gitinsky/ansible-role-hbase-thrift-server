Eye.application 'thrift-server' do
  working_dir '/etc/eye'
  stdall '/var/log/eye/thrift-server-stdall.log' # stdout,err logs for processes by default
  trigger :flapping, times: 10, within: 1.minute, retry_in: 3.minutes
  check :cpu, every: 10.seconds, below: 100, times: 3 # global check for all processes

  process :thrift do
    pid_file '/var/hbase/hbase_thrift.pid'
    start_command 'sudo -u hadoop /opt/hbase/bin/hbase thrift start'

    daemonize true
    start_timeout 10.seconds
    stop_timeout 5.seconds

  end

end
