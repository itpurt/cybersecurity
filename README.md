## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![ELK STACK](Diagrams/elk-stack/elk-stack.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the playbook file may be used to install only certain pieces of it, such as Filebeat.

  - ![ELK Stack Basic Playbook](Ansible/elk-playbook.yml)
    - Elasticsearch
    - Kibana
    - Logstash
  - ![Filebeat](Ansible/filebeat-playbook.yml) 
  - ![Metricbeat](Ansible/metricbeat-playbook.yml)

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly reliable, in addition to restricting the web-vms to the network.
- As the name suggests, load balancers are used to protect internal resources from overloading and will evenly distribute traffic from the network to each of the web-vms available in the backend pool. The load balancer monitors the health of each resource within the backend pool and will only distribute traffic if a resource meets the health requirements. This reinforces the load balancer's main function to keep internal resources available.
- Jump-box is used to limit external SSH traffic to only one resource within the architecture and allow trusted access to the internal resources (web servers). 

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the and  application and system logs.
- [Filebeat](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-overview.html) monitors the log files or locations that you specify, collects log events, and forwards them either to Elasticsearch or Logstash for indexing.
- [Metricbeat](https://www.elastic.co/beats/metricbeat) monitors system metrics as configured.

The configuration details of each machine may be found below.

| Name     | Function | IP Address | Operating System |
|----------|----------|------------|------------------|
| Jump Box | Gateway  | 10.0.0.4   | Linux            |
| Web-1    | DVWA     | 10.0.0.8   | Linux            |
| Web-2    | DVWA     | 10.0.0.9   | Linux            |
| Web-3    | DVWA     | 10.0.0.10  | Linux            |
| elk-vm   | DVWA     | 10.1.0.4   | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the load balancer (lb-1) machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- 	47.186.115.237

Machines within the network can only be accessed by the jump-box.
- ELK-VM is accessible from the same jump box, 10.0.0.4, used for the web-vms.

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible |  Public IP Allowed |Allowed IP Addresses                 |
|----------|---------------------|--------------------|-------------------------------------|
| Jump Box | Yes                 | 47.186.115.237     |10.0.0.9,10.0.0.8,10.0.0.10,10.1.0.4 |
| Web-1    | No                  |                    |10.0.0.4                             |
| Web-2    | No                  |                    |10.0.0.4                             |
| Web-3    | No                  |                    |10.0.0.4                             |
| ELK-VM   | Yes                 | 47.186.115.237     |10.0.0.4                             |
## Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because it provides a streamlined way of deploying containers to various hosts in a single script; with the same environment to each host. It's also reuseable; if more deployments are necessary in the future, this script can be leaveraged.

The playbook implements the following tasks:
- Install docker
- Install package PIP (installer for python)
- Install python docker module
- Download and launch a docker web container (cyberxsecurity/dvwa)
- Enable docker service

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![Screenshot of docker ps output](Diagrams/elk-stack/docker-ps-elk.JPG)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- Web-1 (10.0.0.8)
- Web-2 (10.0.0.9)
- Web-3 (10.0.0.10)

We have installed the following Beats on these machines:
- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat allows you to specify which system log files you are interested in monitoring and then will help aggregate them in a meaningful way to help your security analyst identify anomalies. For example, if you have configured Filebeat to monitor system logs, /var/log/messages and /var/log/apache2, then Filebeat will concatenate the logs together.
- On the other hand, Metricbeat will silently gather configured metrics such as:
```
 ??? cpu # CPU usage
 ??? load # CPU load averages
 ??? memory # Memory usage
 ??? network # Network IO
 ??? process # Per process metrics
 ??? process_summary # Process summary
 ??? uptime # System Uptime
 ??? socket_summary # Socket summary
```
  and provide a meaningful display to illustrate usage.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the ansible playbook file to /etc/ansible.
- Update the hosts file to include ip addresses of all the web-vms and the elk-stack vm
- Update the ansible.cfg file 
  - remote_user should be set to sysadmin
- Run the playbook, and navigate to Kibana Webpage (http://23.100.122.149:5601/app/kibana) to check that the installation worked as expected.
