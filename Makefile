all: image tag

image:
	@vagrant up
	@vagrant ssh -c "sudo docker build -t nanobox/mysql /vagrant"

tag:
	@vagrant ssh -c "sudo docker tag -f nanobox/mysql nanobox/mysql:5.5"
	@vagrant ssh -c "sudo docker tag -f nanobox/mysql nanobox/mysql:5.5-stable"
	@vagrant ssh -c "sudo docker tag -f nanobox/mysql nanobox/mysql:5.5-beta"
	@vagrant ssh -c "sudo docker tag -f nanobox/mysql nanobox/mysql:5.5-alpha"
	@vagrant ssh -c "sudo docker tag -f nanobox/mysql nanobox/mysql:stable"
	@vagrant ssh -c "sudo docker tag -f nanobox/mysql nanobox/mysql:beta"
	@vagrant ssh -c "sudo docker tag -f nanobox/mysql nanobox/mysql:alpha"

publish: push_55_stable

push_55_stable: push_55_beta
	@vagrant ssh -c "sudo docker push nanobox/mysql"
	@vagrant ssh -c "sudo docker push nanobox/mysql:5.5"
	@vagrant ssh -c "sudo docker push nanobox/mysql:5.5-stable"
	@vagrant ssh -c "sudo docker push nanobox/mysql:stable"

push_55_beta: push_55_alpha
	@vagrant ssh -c "sudo docker push nanobox/mysql:5.5-beta"
	@vagrant ssh -c "sudo docker push nanobox/mysql:beta"

push_55_alpha:
	@vagrant ssh -c "sudo docker push nanobox/mysql:5.5-alpha"
	@vagrant ssh -c "sudo docker push nanobox/mysql:alpha"

clean:
	@vagrant destroy -f
