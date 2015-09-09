all: image tag

image:
	@vagrant up
	@vagrant ssh -c "sudo docker build -t nanobox/mysql /vagrant"

tag:
	@vagrant ssh -c "sudo docker tag -f nanobox/mysql nanobox/mysql:5.5"
	@vagrant ssh -c "sudo docker tag -f nanobox/mysql nanobox/mysql:5.5-stable"
	@vagrant ssh -c "sudo docker tag -f nanobox/mysql nanobox/mysql:5.5-beta"
	@vagrant ssh -c "sudo docker tag -f nanobox/mysql nanobox/mysql:5.5-alpha"

publish:
	@vagrant ssh -c "sudo docker push nanobox/mysql"
	@vagrant ssh -c "sudo docker push nanobox/mysql:5.5"
	@vagrant ssh -c "sudo docker push nanobox/mysql:5.5-stable"

push_55_stable:
	@vagrant ssh -c "sudo docker push nanobox/mysql"
	@vagrant ssh -c "sudo docker push nanobox/mysql:5.5"
	@vagrant ssh -c "sudo docker push nanobox/mysql:5.5-stable"

push_55_beta:
	@vagrant ssh -c "sudo docker push nanobox/mysql:5.5-beta"

push_55_alpha:
	@vagrant ssh -c "sudo docker push nanobox/mysql:5.5-alpha"

clean:
	@vagrant destroy -f
