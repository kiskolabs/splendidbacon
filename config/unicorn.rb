worker_processes 2

timeout 30

preload_app true

app_dir = File.expand_path("../..", __FILE__)

listen "#{app_dir}/tmp/sockets/unicorn.sock", :backlog => 2048

working_directory app_dir

stderr_path "#{app_dir}/log/unicorn.stderr.log"
stdout_path "#{app_dir}/log/unicorn.stdout.log"

pid "#{app_dir}/tmp/pids/unicorn.pid"

before_fork do |server, worker|
  old_pid = "#{app_dir}/tmp/pids/unicorn.pid.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end
