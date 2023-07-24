# dotfiles
___My Portable Server Provision Configs___<br><br>
This configuration moves the work out of .bashrc and makes controlling the startup process modular, portable and (hopefully) less complex.<br><br>
```
cd ~
git clone https://github.com/tsharley/dotfiles.git .config/
chmod +x .config/dotfiles/install.sh
sudo .config/dotfiles/install.sh
```

The individual scripts can be modified in place as needed.<br><br>
Works on most Linux distributions.  Still ironing out the MacOS logic but that should be in place soon.
