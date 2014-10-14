monitoring-bag
==============

A playbook that sets up sensu client+ server and other tools such as logstash.

This playbook should be used in multiple stages:

Stage 1

Deploy the Deployer, Reaper, etc using the Bindle 2.0 playbook on a new cloud (AWS) instance.

Stage 2

Checkout the "monitoring-bag" playbook from Github, configure SSL and add the Deployer's IP in the [sensu-server] inventory group.
Run the script in ssl (bash ssl/script.sh) to generate a unique set of SSL certificates for your Sensu install.

Stage 3

Deploy the Sensu playbook to install Sensu server on the Deployer.
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory site.yml --limit sensu-server

NOTE: Make sure that ports are open between your instances. The Sensu server accepts Rabbitmq SSL connections on port 5671, Sensu API listens on port 4567, and Uchiwa Dashboard uses port 3000. Clients and the server will need  to connect to Rabbitmq on port 5671. Uchiwa needs access to Sensu API (4567). You need access to Uchiwa (port 3000).


Stage 4

If you are using the Deployer to deploy single-node Seqware nodes in AWS, add their IP addresses in the inventory file in the [single-node] Ansible group. This will make sure that some of the checks (e.g. glusterfs related checks) will not be deployed on these nodes.

Stage 5

Run this playbook via:

    ansible-playbook -i inventory site.yml --limit single-node

or without key checking

    ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory site.yml --limit single-node

Stage 6

Change the security group for the Central Sensu server to allow incoming TCP connections on port 2003 from the new Sensu server running on the Deployer. This will allow the metrics received by the Sensu server from the single-node Server clients to be forwarded to the Graphite server running on the Central Sensu server.

Stage 7

If you want to see the status of all checks and Sensu clients in a single Dashboard, you will have to allow access from the Sensu Central to the Sensu API (port 4567) running on the AWS Deployer.

Then, ssh into the Sensu Central and add a new section in "/etc/sensu/uchiwa.json" like below and restart the uchiwa service:

 "sensu": [
        {
            "name": "Sensu AWS Ireland",
            "host": "1.2.3.4",
            "ssl": false,
            "port": 4567,
            "user": "admin",
            "pass": "seqware",
            "path": "",
            "timeout": 5000
        }
    ],
 


