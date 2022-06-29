# Cosbench

# Requirements

Role ksingh7.cosbench must be installed

#Installation cosbench

``` bat

$ sudo ansible-galaxy install -r tasks/requirements.yml

$ ansible-playbook   tasks/prepare_cosbench.yml

$ ansible-playbook   tasks/installation_cosbench.yml

```

#Version control
``` bat

ansible-playbook tasks/installation_cosbench.yml -e "cosbench_version=0.4.1.0"

```

#Uninstallation cosbench

``` bat

$ ansible-playbook tasks/installation_cosbench.yml -e "uninstall=True"

```

#Customization

Variable file : vars/main.yml If you want to install any other version of COSBench , update the following variable

cosbench_version: v0.4.1.0

