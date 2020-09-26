# Tracker
bash <(curl -fsSL git.io/tracker.sh) "/app/aria2c.conf"

#Peer Agent
echo "peer-id-prefix=-qB4250-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9!~*()._-' | fold -w 12 | head -n 1)" >> /app/aria2c.conf

python3 -m tobrot
