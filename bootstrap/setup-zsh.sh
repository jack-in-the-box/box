#!/bin/bash

. /vagrant/resources/colors.sh
. /vagrant/resources/trycatch.sh

# This script needs admin rights
if [ 0 != $(id -u) ]; then
	echox "${text_red}Error:${text_reset} This script must be run as root!"
	exit 1
fi

try
(
	echo "Install ZSH"
	apt-get -y -q install zsh

	echo "Install Oh My ZSH"
	sudo -u vagrant sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

	echo "Change default shell"
	chsh -s $(which zsh)
	sed -i 's/vagrant:\/bin\/bash\+/vagrant:\/usr\/bin\/zsh/g' /etc/passwd

	echo "Copy configuration"
	cp /vagrant/resources/.zshrc /root/.zshrc
	cp /vagrant/resources/.zshrc /home/vagrant/.zshrc
)
catch || {
	case $ex_code in
		*)
			echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
			throw $ex_code
		;;
	esac
}
