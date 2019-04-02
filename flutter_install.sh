#!/bin/zsh

if [[ $(ls /private/tmp/flutter/bin 2&> /dev/null ) ]]; then
	echo "Flutter already installed!";
else
	data=$(curl --silent "https://storage.googleapis.com/flutter_infra/releases/releases_macos.json" | grep -m 2 -A 4 '"channel": "stable"')
	url=$(echo $data | grep archive | cut -d '"' -f4)
	curl --silent "https://storage.googleapis.com/flutter_infra/releases/$url" > /private/tmp/flutter.zip;
	unzip -q /private/tmp/flutter.zip -d /private/tmp/.;
	rm -f /private/tmp/flutter.zip;
	if [[ -z $(echo $PATH | grep /tmp/flutter/bin) ]]; then
		export PATH="$PATH:/tmp/flutter/bin";
		source ~/.zshrc > /dev/null;
	fi
	flutter doctor;
	echo "Flutter installation done!";
	zsh;
fi
