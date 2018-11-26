# MongoDB Sharding Helm Chart
## Origin information
fork from https://github.com/helm/charts/tree/master/stable/mongodb-replicaset and made some modifcation for sharding

## Overall Structure
<img src="https://github.com/archaetor/helm_charts/blob/master/mongodb-sharding/help.jpg">

## To Use Charts
#### Deployment a replicaset 
```
$ helm install ./charts/mongodb-replica --name myMongo
```
#### Upgrade from a replicaset to sharding
```
$ Helm upgrade . myMongo
```
#### Deploy a sharding directly
```
$ helm install . --name myMongo
```
#### Deploy with a given value file
```
$ helm install . --name myMongo  --value ./value/myValueFile
```

## Other
Have not add security configure yet.

