## nanobox-docker-mysql ![Build Status Image](https://travis-ci.org/nanobox-io/nanobox-docker-mysql.svg)

This repo contains the files necessary to create the mysql docker image for [Nanobox](http://nanobox.io) consumption.

#### Requirements

* [vagrant](vagrantup.com)
* [dockerhub](hub.docker.com) account

## Usage

## Testing

All changes, experimental or not, should be published using the alpha tag. The alpha image can be tested by using [Nanobox](http://nanobox.io), and adding the following to an application's Boxfile:

```yaml
web1:
  stability: alpha
```

## Caveat

#### Authentication

If during a publish, you receive the error:

```bash
unauthorized: access to the requested resource is not authorized
```

Run the following command and follow the login prompt:

```bash
make login
```

Subsequent publishes will use a stored api token.

#### Cleanup

Don't forget to halt the Vagrant machine when you're done:

```bash
vagrant halt
```

## License

Mozilla Public License, version 2.0
