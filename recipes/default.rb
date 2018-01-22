#
# Cookbook:: docker-machine
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
def install_url
  release = node['docker-machine']['release']
  kernel_name = node['kernel']['name']
  machine_hw_name = node['kernel']['machine']
  "https://github.com/docker/machine/releases/download/v#{release}/docker-machine-#{kernel_name}-#{machine_hw_name}"
end

command_path = node['docker-machine']['command_path']

execute 'install docker-machine' do
  action :run
  command "curl -sSL #{install_url} > #{command_path} && chmod +x #{command_path}"
  user 'root'
  group 'docker'
  umask '0027'
  not_if "#{command_path} --version | grep #{node['kdocker-machine']['release']}"
end
