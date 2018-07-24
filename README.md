 GCP Courseur staging

Construit un cluster nomad / consul / traefik / glusterfs / mysql

### Vue d'ensemble

Ne prendre en compte que la partie droite du schema.

Il n'a pas non plus de load balancer interne.

https://bitbucket.org/courseur/infra/src/master/pres/images/Multi-cloud-step03.png

### Les outils

- La stack Hashicorp

### Prerequis

- `gcloud` installe
- S'etre logge sur le cloud
- Avoir un image prete dans le registry google

### Build image

```
$ cd *build* && ./build.sh && cd ..
```

**Ne pas oublier de mettre a jour la version de l'image dans les steps**

### Construction 

```
# L'ordre est import
``$ for step in network firewall bastion consul mysql treafik glusterfs \
do \
   cd *$step* terraform init && terraform apply -auto-approve && cd .. \
done
$
```

### A la mano (via l'api ou via le web)


Creer le load balancer `https` vers le group d'instances traefik. 

Ajouter les certifs des domaines ci-apres generes.

Et relier l'ip static `traefik` au front de ce load balancer.

### Les certificats 

#### acme.sh (https certificates)

- https://github.com/Neilpang/acme.sh/wiki/How-to-use-OVH-domain-api

- https://github.com/Neilpang/acme.sh)[https://github.com/Neilpang/acme.sh

#### Automatique: Pas reussit a faire fonctionner


##### Wildcard certificates with ovh :

Got to https://eu.api.ovh.com/createApp/ to get app key / app secret

##### Export keys 

```
$ export OVH_AK=""
$ export OVH_AS=""
```

##### Set DNS

```
$ acme.sh  --issue -d cloud.courseur.com  -d '*.cloud.courseur.com'  --dns dns_ovh
```

##### Authenticate

Will ask you to go to the authentication link.

##### Rerun `acme.sh`
  
```
$ acme.sh
  ```

Vous aurez un truc du genre :

  ```
  Your cert is in  /home/greg/.acme.sh/cloud.courseur.com/cloud.courseur.com.cer 
  Your cert key is in  /home/greg/.acme.sh/cloud.courseur.com/cloud.courseur.com.key 
  The intermediate CA cert is in  /home/greg/.acme.sh/cloud.courseur.com/ca.cer 
  And the full chain certs is there:  /home/greg/.acme.sh/cloud.courseur.com/fullchain.cer 
```
