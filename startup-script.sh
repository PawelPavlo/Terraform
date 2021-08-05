export HOME=/root
apt-get update && apt-get install -yq ansible git
git clone -b master https://github.com/PawelPavlo/Ansible.git /opt/ansible
cd /opt/ansible/ansibleproject && ansible-playbook playbook.yml

