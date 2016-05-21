#Vagrant

    vagrant up

After running above command edit /var/lib/pgsql/data/pg_hba.conf file 
on host machine (replace peer method with md5 for local type ),
and create database:

    rake db:migrate

Next, run on host machine in vagrant poject folder:

    vagrant provision

