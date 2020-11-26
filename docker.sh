# This is a collection of Docker-related commands and snippets

# Prevent users from accidentally running this entire file as a script
exit 0

# When browsing the contents of a Dockerfile from the terminal, it can sometimes
# be useful to also see the line numbers
cat -n Dockerfile

# RHEL/CentOS running devicemapper as the Docker storage driver, in which devicemapper begins
# gobbling up disk space. WARNING: This will nuke Docker and all containers/images!
# See also: https://stackoverflow.com/questions/37672018/clean-docker-environment-devicemapper
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine \
                  docker-ce
sudo rm -rf /var/lib/docker
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce
sudo chkconfig docker on
/sbin/service docker start