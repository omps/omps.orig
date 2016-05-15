set -e

REPO_URL="http://yum.puppetlabs.com/el/6/products/i386/puppetlabs-release-6-11.noarch.rpm"

if ["$EUID" -ne "0"]; then
    echo "This script should be run as root" >&2
    exit 1
fi

if which puppet > /dev/null 2>&1; then
    echo "Puppet already installed"
    exit 0
fi



# Install puppet labs repo
echo "configuring puppetlabs repo.."
repo_path =$(mktemp)
wget --output-document=${repo_path} ${REPO_URL} 2>/dev/null
rpm -i ${repo_path} > /dev/null

# Install puppet..
echo "installing puppet"
yum install -y puppet > /dev/null

echo "Puppet installed!!"
