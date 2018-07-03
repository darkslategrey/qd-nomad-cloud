sudo systemctl stop apt-daily.service
sudo systemctl stop apt-daily.timer

sudo systemctl disable apt-daily.service
sudo systemctl disable apt-daily.timer
sudo systemctl kill --kill-who=all apt-daily.service
sudo systemctl daemon-reload

# wait until `apt-get updated` has been killed
while ! (systemctl list-units --all apt-daily.service | fgrep -q dead) && ! (systemctl list-units --all apt-daily.timer | fgrep -q dead)
do
    sleep 1;
done
