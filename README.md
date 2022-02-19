# Setup scripts

This project is used as my attempt to properly create things in ansible. Previously I did a setup which is kind of broken
but helped me to learn the basics for it.

Initially everything was set up with broken bash scripts: https://github.com/daviskregers/old-dotfiles

# Resources

- https://docs.ansible.com/ansible/2.3/playbooks_best_practices.html

# Commands

```
ansible-playbook site.yml --limit nas
ansible-playbook nas.yml -K
ansible-playbook -i production site.yml --tags ntp
ansible-playbook -i production webservers.yml --limit boston
ansible-playbook foo.yml --check
ansible-playbook foo.yml --check --diff --limit foo.example.com
```

# Dependencies

```
ansible-galaxy collection install geerlingguy.mac
```

## Virtualization on mac

- https://computingforgeeks.com/install-macos-big-sur-catalina-on-virtualbox/
- https://github.com/myspaghetti/macos-virtualbox


### Fix for running macOS on AMD

```
vboxmanage modifyvm macOS --cpu-profile "Intel Xeon X5482 3.20GHz"
```
