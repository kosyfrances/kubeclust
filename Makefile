cluster:
		ansible-playbook playbook.kubecluster.yml -i inventory.ini

clean:
		ansible-playbook playbook.deletecluster.yml -i inventory.ini
