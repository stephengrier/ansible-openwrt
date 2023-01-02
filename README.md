# An ansible playbook for managing my OpenWrt wifi router

This contains an ansible playbook that configures my Belkin RT3200 wifi router
running OpenWrt. Most of the heavy lifting is done by the
[gekmihesg.openwrt](https://github.com/gekmihesg/ansible-openwrt) role, which
reimplements many of the builtin modules as shell scripts to avoid having to
install Python on the router.

## Installing prerequisites

You will need to install ansible. On a Mac this can be installed using homebrew:

```bash
brew install ansible
```

The playbook requires the
[gekmihesg.openwrt](https://github.com/gekmihesg/ansible-openwrt) role. This can
be installed from Ansible Galaxy like so:

```bash
ansible-galaxy install -r requirements.yml
```

## Running the playbook

Once the above prerequisites have been installed the playbook can be run like
so:

```bash
ansible-playbook -k openwrt.yml
```

The playbook will prompt for the password for SSH access to the router and also
the WPA2 key to set on the wireless interfaces.

## Running the playbook in a docker container

You can avoid having to install ansible on your device by running the playbook
in a docker container. The `ansible.sh` script contains all the commands to
install dependencies and run ansible and can be run inside a docker container
like so:

```bash
docker run --rm -ti -v $PWD:/ansible cytopia/ansible /ansible/ansible.sh
```

## Testing against an openwrt container

For testing and development purposes it may be easier to run the playbook
against a docker container running locally. You can run openwrt in a container
like so:

```bash
docker run --rm -it -p22:22 -d --name openwrt openwrtorg/rootfs
```

You can then test the playbook against the container by adding a local hosts
file override in docker like so:

```bash
OPENWRT_IP=$(docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' openwrt)
docker run --rm -ti -v $PWD:/ansible --add-host openwrt.lan:$OPENWRT_IP cytopia/ansible /ansible/ansible.sh

```

