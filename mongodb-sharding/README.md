# MongoDB Sharding Helm Chart
----
Originated from https://github.com/helm/charts/tree/master/stable/mongodb-replicaset and made some modifcation for sharding
----
## Overall Structure
<img src="https://github.com/archaetor/helm_charts/tree/master/mongodb-sharding/help.jgp">

## Deploy a Mongodb-Replicaset
$sudo helm install ./charts/mongodb-replica --name myMongo

## Upgrade from Mongodb-Replicaset to Mongodb-Sharding
$sudo Helm upgrade . myMongo

## Deploy a Mongodb-Sharding directly
$sudo helm install . --name myMongo


