#!/bin/zsh

if [[ $(ls /tmp/flutter/bin 2&> /dev/null ) ]]; then
	if [[ -z $(echo $PATH | grep /tmp/flutter/bin) ]]; then
		export PATH="$PATH:/tmp/flutter/bin";
		source ~/.zshrc > /dev/null;
		flutter doctor;
		echo "PATH variable added!"
		zsh;
	else
		echo "Flutter already installed!";
	fi
else
	data=$(curl --silent "https://storage.googleapis.com/flutter_infra/releases/releases_macos.json" | grep -m 2 -A 4 '"channel": "stable"')
	url=$(echo $data | grep archive | cut -d '"' -f4)
	curl --progress-bar "https://storage.googleapis.com/flutter_infra/releases/$url" > /tmp/flutter.zip;
	unzip -q /tmp/flutter.zip -d /tmp/.;
	rm -f /tmp/flutter.zip;
	if [[ -z $(echo $PATH | grep /tmp/flutter/bin) ]]; then
		export PATH="$PATH:/tmp/flutter/bin";
		source ~/.zshrc > /dev/null;
	fi
	chmod -R 777 "/tmp/flutter"
	flutter doctor;
	echo "Flutter installation done!";
	zsh;
fi
