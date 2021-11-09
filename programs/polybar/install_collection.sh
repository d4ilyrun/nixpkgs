#/bin/sh

[ -d polybar-themes ] || git clone --depth=1 https://github.com/adi1090x/polybar-themes.git

cd polybar-themes
chmod +x setup.sh
./setup.sh
