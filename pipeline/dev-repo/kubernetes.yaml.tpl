apiVersion: apps/v1
kind: Deployment
metadata:
  name: hello-test
  labels:
    app: hello-test
spec:
  replicas: 1
  selector:
    matchLabels:
      app: hello-test
  template:
    metadata:
      labels:
        app: hello-test
    spec:
      containers:
      - name: hello-test
        image: gcr.io/GOOGLE_CLOUD_PROJECT/image:COMMIT_SHA
        ports:
        - containerPort: 8080
---
kind: Service
apiVersion: v1
metadata:
  name: hello-test
spec:
  selector:
    app: hello-test
  ports:
  - protocol: TCP
    port: 80
    targetPort: 8080
  type: LoadBalancer
