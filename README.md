# Adding a Caddy reverse SSL to OpenClinica

## 1 Make a volume for the certificates

```
docker volume create caddycert
```

## 2 Clone the repository

```
git clone https://github.com/mshunshin/openclinica_caddy-docker.git
cd openclinica_caddy-docker
```

## 3 Change the config file

You will need to put in your own email address and site URL into the Caddy file.

First copy the template Caddyfile

```
cp ./caddy.config/Caddyfile.new ./caddy.config/Caddyfile
```

Then edit it


```
vi .caddy.config/Caddyfile

(common) {
  log / stdout "{combined}"
  errors stderr
  tls your@email.com
}

replace_this_with_your_domain.com {
  import common
  proxy /OpenClinica oc:8080 {
    transparent
  }
  proxy /randi randi:8080 {
    transparent
  }
}

````

## 4 Build it

```
docker build -t occaddy .
```

## 5 Run it

Put it on the correct network

```
docker run -d -p 80:80 -p 443:443 --name occaddy -v caddycert:/root/.caddy --network trial-net occaddy
```

