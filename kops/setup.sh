#!/bin/bash

gsutil mb gs://kubernetes-clusters-state-2/

gsutil versioning set on gs://kubernetes-clusters-state-2/

export KOPS_STATE_STORE2=gs://kubernetes-clusters-state-2/

export GOOGLE_APPLICATION_CREDENTIALS=/Users/home/Downloads/crack-willow-410719-2350579751b4.json

PROJECT=`gcloud config get-value project`

kops create cluster oatek.k8s.local --zones us-central1-a --state ${KOPS_STATE_STORE2}/ --project=${PROJECT}

kops get cluster --state ${KOPS_STATE_STORE2}

kops validate cluster

kops get instancegroup --state ${KOPS_STATE_STORE2}/ --name oatek.k8s.local

kops update cluster oatek.k8s.local --yes

kubectl config use-context oatek.k8s.local

kops export kubecfg --admin