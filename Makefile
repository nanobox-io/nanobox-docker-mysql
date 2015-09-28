# -*- mode: make; tab-width: 4; -*-
# vim: ts=4 sw=4 ft=make noet
all: build publish

LATEST:=5.6
stability?=latest
version?=$(LATEST)
dockerfile?=Dockerfile-$(version)

login:
	@vagrant ssh -c "docker login"

build:
	@echo "Building 'mysql' image..."
	@vagrant ssh -c "docker build -f /vagrant/Dockerfile-${version} -t nanobox/mysql /vagrant"

publish:
	@echo "Tagging 'mysql:${version}-${stability}' image..."
	@vagrant ssh -c "docker tag -f nanobox/mysql nanobox/mysql:${version}-${stability}"
	@echo "Publishing 'mysql:${version}-${stability}'..."
	@vagrant ssh -c "docker push nanobox/mysql:${version}-${stability}"
ifeq ($(version),$(LATEST))
	@echo "Publishing 'mysql:${stability}'..."
	@vagrant ssh -c "docker tag -f nanobox/mysql nanobox/mysql:${stability}"
	@vagrant ssh -c "docker push nanobox/mysql:${stability}"
endif

clean:
	@echo "Removing all images..."
	@vagrant ssh -c "for image in \$$(docker images -q); do docker rmi -f \$$image; done"