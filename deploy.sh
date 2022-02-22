# Create manifest, similar to "make deploy"
# Deploy with: kubectl apply -f deploy/awx-operator.yaml

VERSION=0.17.0
NAMESPACE=awx

pushd config/manager >/dev/null
kustomize edit set image controller=quay.io/ansible/awx-operator:${VERSION}
popd >/dev/null

pushd config/default >/dev/null
kustomize edit set namespace ${NAMESPACE}
popd >/dev/null

mkdir -p deploy
kustomize build config/default > deploy/awx-operator.yaml
