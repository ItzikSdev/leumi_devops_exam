This is exam for Devops position in Band Leumi

- Jenkins

* U: admin
* P:2acc0d00be8c4cf3b14c0ced27090511

aws eks
P: kubectl exec --namespace default -it svc/myjenkins -c jenkins -- /bin/cat /run/secrets/additional/chart-admin-password && echo
RUN kubectl --namespace jenkins port-forward svc/jenkins 8080:8080
