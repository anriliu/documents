# documents
ansible roles for daily jobs  
you will see  

if your inventory file path is /etc/ansible/hosts  	
then you can create below file for group and host variables definition  
/etc/ansible/group_vars/raleigh # can optionally end in '.yml', '.yaml', or '.json'  
/etc/ansible/group_vars/webservers  
/etc/ansible/host_vars/foosball  
ansible-vault can only encrypt any file even binary file  
As of version 2.3, Ansible also supports encrypting single values inside a YAML file, using the !vault tag to let YAML and Ansible know it uses special processing  
You can use ansible-vault encrypt_string to generate the encrypted strings  
use ansible-vault encrypt group_vars/hzx  to encrypt sensitive data variables such as passwd and user name  
then run ansbile or ansible-playbook with --vault-password-file=/opt/vault-password  to specify vault password file where you saved the encrypt passwd  

use debug module to be useful for debugging variables or expressions  
- shell: /usr/bin/uptime  
  register: result  
  
- debug:  
    var: result  
    verbosity: 2  
  
- name: Display all variables/facts known for a host  
  debug:  
    var: hostvars[inventory_hostname]  
    verbosity: 4  

In CentOS, if the action is successful and if the registered variable result is set, then a user can see these dict variables for ex: result.rc being 0, result.stdout = "something\nsomethingEsle\netc etc etc" and/or result.stdout_lines = "...same as above..." and result.results in some cases. If the action was failed, then I couldn't see result.stdout getting set in my case for using yum module if that failed due to connection reset or other reason. In that case, the only dict variable available for a failed action was result.rc != 0. Thus, in the until loop, until: result.rc == 0 condition worked for both successful/failed case for CentOS.  
In Ubuntu, if the apt module action was successful, I got result.stdout and result.stdout_lines variables set but no result.rc dict variable set. For a failed operation, there's was no result.stdout or result.stdout_lines or result.rc dict variables set. SO, in case of Ubuntu, I couldn't use until loop using one of these dictionary variables.  
Then we can use Jinja2 filters for both 
until: result|succeeded  

tasks:  

  - shell: /usr/bin/foo  
    register: result  
    ignore_errors: True  
  
  - debug: msg="it failed"  
    when: result|failed  

  # in most cases you'll want a handler, but if you want to do something right now, this is nice  
  - debug: msg="it changed"  
    when: result|changed  
  
  - debug: msg="it succeeded in Ansible >= 2.1"  
    when: result|succeeded  
  
  - debug: msg="it succeeded"  
    when: result|success  
  
  - debug: msg="it was skipped"  
    when: result|skipped  
  
handlers notified within pre_tasks, tasks, and post_tasks sections are automatically flushed in the end of section where they were notified;  
handlers notified within roles section are automatically flushed in the end of tasks section, but before any tasks handlers.  
If you ever want to flush all the handler commands immediately though, in 1.2 and later, you can:  
   
tasks:   
   - shell: some tasks go here  
   - meta: flush_handlers  
   - shell: some other tasks  
In the above example any queued up handlers would be processed early when the meta statement was reached. This is a bit of a niche case but can come in handy from time to time.

template:
{% for port in service_port %}
  server localhost:{{ port }};
{% endfor %}

gfw  
通过dnsmsq+ipset 获取并设置gfwlist ip  
Firewall modify src in gfwlist via vpn_gw  

Dnsmasq 设置gfwlist 的domain全部由127.0.0.1:1053 解析  
127.0.0.1:1053是pdns 又指向8.8.8.8，8.8.8.4  

dnsmsq可以设置根据域名指定dns，同时也可以设置本地dns解析  
Pdns 可以通过tcp设置只发送dns请求，因此来得到无污染的dns解析。（dns污染是通过修改udp方式的dns请求  
Redsocks允许将所有TCP连接重定到tcpspeed,实现透明代理 . 
Iptables 主要用来将不需要代理的流量return,其他所有的tcp流量redirect到redsocks监听的端口 . 


china ip range	
wget -O- 'http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest' | awk -F\| '/CN\|ipv4/ { printf("%s/%d\n", $4, 32-log($5)/log(2)) }' > /etc/chinadns_chnroute.txt

Blueprint is a simple configuration management tool that reverse-engineers servers. It figures out what you’ve done manually, stores it locally in a Git repository, generates code that’s able to recreate your efforts, and helps you deploy those changes to production.  
https://github.com/devstructure/blueprint  
it needs dpkg even you run from centos  
