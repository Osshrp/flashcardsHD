## Vagrant

    vagrant up

After running above command edit /var/lib/pgsql/data/pg_hba.conf file 
on host machine (replace peer method with md5 for local type ),
and create database:

    rake db:migrate

Next, run on host machine in vagrant poject folder:

    vagrant provision

## Integrating Flickr into app

Visit this page (http://www.flickr.com/services/api/misc.api_keys.html)

 and follow the instructions to get a key and write it down somewhere safe. Of course you are going to need a Flickr account to do this as well!

## Example config/flickr.yml

	--- !map:HashWithIndifferentAccess
 	key: "YOUR KEY"
	secret: "YOUR SECRET"
	token_cache: "token_cache.yml"