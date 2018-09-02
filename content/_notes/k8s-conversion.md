### Ingress Controller

#### View the Kubernetes UI
```
$ az aks browse --resource-group bunk_aks --name bunk-aks
```

#### Install the Traefik helm chart
```
$ helm install \
    --name traefik stable/traefik \
    --namespace kube-system \
    --values ./traefik.yaml
```

#### Watch it generate a TLS cert
```
time="2018-07-21T21:08:11Z" level=info msg="Using TOML configuration file /config/traefik.toml"
time="2018-07-21T21:08:11Z" level=warning msg="web provider configuration is deprecated, you should use these options : api, rest provider, ping and metrics"
time="2018-07-21T21:08:11Z" level=info msg="Traefik version v1.6.2 built on 2018-05-22_03:19:06PM"
time="2018-07-21T21:08:11Z" level=info msg="\nStats collection is disabled.\nHelp us improve Traefik by turning this feature on :)\nMore details on: https://docs.traefik.io/basics/#collected-data\n"
time="2018-07-21T21:08:11Z" level=info msg="Preparing server https &amp;{Address::443 TLS:0xc42034e380 Redirect:&lt;nil&gt; Auth:&lt;nil&gt; WhitelistSourceRange:[] WhiteList:&lt;nil&gt; Compress:true ProxyProtocol:&lt;nil&gt; ForwardedHeaders:0xc420406f00} with readTimeout=0s writeTimeout=0s idleTimeout=3m0s"
time="2018-07-21T21:08:11Z" level=info msg="Preparing server traefik &amp;{Address::8080 TLS:&lt;nil&gt; Redirect:&lt;nil&gt; Auth:&lt;nil&gt; WhitelistSourceRange:[] WhiteList:&lt;nil&gt; Compress:false ProxyProtocol:&lt;nil&gt; ForwardedHeaders:0xc420406f20} with readTimeout=0s writeTimeout=0s idleTimeout=3m0s"
time="2018-07-21T21:08:11Z" level=info msg="Preparing server http &amp;{Address::80 TLS:&lt;nil&gt; Redirect:0xc42062c640 Auth:&lt;nil&gt; WhitelistSourceRange:[] WhiteList:&lt;nil&gt; Compress:true ProxyProtocol:&lt;nil&gt; ForwardedHeaders:0xc4204069c0} with readTimeout=0s writeTimeout=0s idleTimeout=3m0s"
time="2018-07-21T21:08:11Z" level=info msg="Starting provider configuration.providerAggregator {}"
time="2018-07-21T21:08:11Z" level=info msg="Starting server on :443"
time="2018-07-21T21:08:11Z" level=info msg="Starting server on :8080"
time="2018-07-21T21:08:11Z" level=info msg="Starting server on :80"
time="2018-07-21T21:08:11Z" level=info msg="Starting provider *kubernetes.Provider {\"Watch\":true,\"Filename\":\"\",\"Constraints\":[],\"Trace\":false,\"TemplateVersion\":0,\"DebugLogGeneratedTemplate\":false,\"Endpoint\":\"\",\"Token\":\"\",\"CertAuthFilePath\":\"\",\"DisablePassHostHeaders\":false,\"EnablePassTLSCert\":false,\"Namespaces\":null,\"LabelSelector\":\"\",\"IngressClass\":\"\"}"
time="2018-07-21T21:08:11Z" level=info msg="Starting provider *acme.Provider {\"Email\":\"jd@courtoy.io\",\"ACMELogging\":true,\"CAServer\":\"https://acme-staging-v02.api.letsencrypt.org/directory\",\"Storage\":\"/acme/acme.json\",\"EntryPoint\":\"https\",\"OnHostRule\":true,\"OnDemand\":false,\"DNSChallenge\":null,\"HTTPChallenge\":{\"EntryPoint\":\"http\"},\"Domains\":null,\"Store\":{}}"
time="2018-07-21T21:08:11Z" level=info msg="Testing certificate renew..."
time="2018-07-21T21:08:11Z" level=info msg="ingress label selector is: \"\""
time="2018-07-21T21:08:11Z" level=info msg="Creating in-cluster Provider client"
time="2018-07-21T21:08:11Z" level=info msg="Server configuration reloaded on :80"
time="2018-07-21T21:08:11Z" level=info msg="Server configuration reloaded on :443"
time="2018-07-21T21:08:11Z" level=info msg="Server configuration reloaded on :8080"
time="2018-07-21T21:08:11Z" level=info msg="Server configuration reloaded on :80"
time="2018-07-21T21:08:11Z" level=info msg="Server configuration reloaded on :443"
time="2018-07-21T21:08:11Z" level=info msg="Server configuration reloaded on :8080"
legolog: 2018/07/21 21:08:12 [INFO][edge.courtoy.io] acme: Obtaining bundled SAN certificate
legolog: 2018/07/21 21:08:13 [INFO][edge.courtoy.io] AuthURL: https://acme-staging-v02.api.letsencrypt.org/acme/authz/v1Rjta7XKpMrRv7OW_cfb9TCugh_YhReEUXnr4x2820
legolog: 2018/07/21 21:08:13 [INFO][edge.courtoy.io] acme: Trying to solve HTTP-01
time="2018-07-21T21:08:18Z" level=error msg="Unable to obtain ACME certificate for domains \"edge.courtoy.io\" detected thanks to rule \"Host:edge.courtoy.io\" : cannot obtain certificates: acme: Error -&gt; One or more domains had a problem:\n[edge.courtoy.io] acme: Error 400 - urn:ietf:params:acme:error:connection - Fetching http://edge.courtoy.io/.well-known/acme-challenge/Wsn3Trn-wAMsaLcLAw1Br1Vb5mvD6guK3hSWT5t0pQ0: Timeout during connect (likely firewall problem)\n"
legolog: 2018/07/21 21:08:27 [INFO][edge.courtoy.io] acme: Obtaining bundled SAN certificate
time="2018-07-21T21:08:27Z" level=info msg="Server configuration reloaded on :443"
time="2018-07-21T21:08:27Z" level=info msg="Server configuration reloaded on :8080"
time="2018-07-21T21:08:27Z" level=info msg="Server configuration reloaded on :80"
legolog: 2018/07/21 21:08:27 [INFO][edge.courtoy.io] AuthURL: https://acme-staging-v02.api.letsencrypt.org/acme/authz/v3y7VacGCCNlhcWTfBQ6Cqq-CAUQlXiZomRRK4SWtu0
legolog: 2018/07/21 21:08:27 [INFO][edge.courtoy.io] acme: Could not find solver for: dns-01
legolog: 2018/07/21 21:08:27 [INFO][edge.courtoy.io] acme: Could not find solver for: tls-alpn-01
legolog: 2018/07/21 21:08:27 [INFO][edge.courtoy.io] acme: Trying to solve HTTP-01
legolog: 2018/07/21 21:08:38 [INFO][edge.courtoy.io] The server validated our request
legolog: 2018/07/21 21:08:38 [INFO][edge.courtoy.io] acme: Validations succeeded; requesting certificates
```

#### Upgrade the release w/ production TLS certs

```
$ helm upgrade -f ./traefik.yaml traefik stable/traefik
Release "traefik" has been upgraded. Happy Helming!
LAST DEPLOYED: Sat Jul 21 16:17:52 2018
NAMESPACE: kube-system
STATUS: DEPLOYED

RESOURCES:
==> v1/PersistentVolumeClaim
NAME          STATUS  VOLUME                                    CAPACITY  ACCESS MODES  STORAGECLASS  AGE
traefik-acme  Bound   pvc-f77d59e5-8d27-11e8-bf9a-0a58ac1f0757  1Gi       RWO           default       25m

==> v1/Service
NAME               TYPE          CLUSTER-IP    EXTERNAL-IP     PORT(S)                     AGE
traefik-dashboard  ClusterIP     10.0.69.166   <none>          80/TCP                      25m
traefik            LoadBalancer  10.0.244.156  137.117.43.115  80:32501/TCP,443:31509/TCP  25m

==> v1beta1/Deployment
NAME     DESIRED  CURRENT  UP-TO-DATE  AVAILABLE  AGE
traefik  1        1        1           0          25m

==> v1beta1/Ingress
NAME               HOSTS            ADDRESS  PORTS  AGE
traefik-dashboard  edge.courtoy.io  80       25m

==> v1/Pod(related)
NAME                      READY  STATUS             RESTARTS  AGE
traefik-686df4796c-fs2zd  1/1    Terminating        0         9m
traefik-76f8b455c8-6zqph  0/1    ContainerCreating  0         1s

==> v1/Secret
NAME                  TYPE    DATA  AGE
traefik-default-cert  Opaque  2     25m

==> v1/ConfigMap
NAME     DATA  AGE
traefik  1     25m

$ helm history traefik
REVISION	UPDATED                 	STATUS    	CHART         	DESCRIPTION
1       	Sat Jul 21 15:52:22 2018	SUPERSEDED	traefik-1.35.0	Install complete
2       	Sat Jul 21 16:01:16 2018	SUPERSEDED	traefik-1.35.0	Upgrade complete
3       	Sat Jul 21 16:17:52 2018	DEPLOYED  	traefik-1.35.0	Upgrade complete
```

### Resume Chart

```
$ helm lint ./resume-chart
==> Linting ./resume-chart
[INFO] Chart.yaml: icon is recommended

1 chart(s) linted, no failures
```
