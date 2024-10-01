# ping to all servers [module: ping]
ansible all -m ping

# scan proxy-server [module: setup]
ansible proxy-server -m setup

# shell-command [module: shell] | '-a' - argument
ansible all_VMs -m shell -a "uptime"

# command (no shell, without environment vars[$]) [module: command]
ansible all_VMs -m command -a "ls /var"

# copy file from master to controlled servers [module: copy] | '-b' - become (with sudo)
ansible all_VMs -m copy -a "src=test.txt dest=/home mode=400" -b

# delete file from controlled servers [module: file]
ansible all_VMs -m file -a "path=/home/test.txt state=absent" -b

# wget file to controlled servers [module: get_url]
ansible all_VMs -m get_url -a "url=https://github.com/perc400/aspnet-mvc-WebInvManagement/blob/master/README.md dest=/home" -b

# installing packages [module: yum] | yum - centos, apt - ubuntu
ansible monitoring_vm -m apt -a "name=stress state=latest" -b

# may connect? [module: uri]
ansible monitoring_vm -m uri -a "url=https://yandex.ru"

# content [module: uri] | return_content=yes
ansible monitoring_vm -m uri -a "url=https://yandex.ru return_content=yes"

# start and enable service on controlled servers [module: service]
ansible all_VMs -m service -a "name=httpd state=started enabled=yes" -b

# debugging commands | '-v' - verbose, "-vvv", "-vvvv"
ansible monitoring_vm -m shell -a "ls -la /" -v

# show all modules in ansible
ansible-doc -l
