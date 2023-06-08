A very short note.

It happened that I needed to investigate one validator perfomance issue. And it seemed that issue related to slow storage perfomance. I needed to change a Persisten Volume StorageClass to a new one,

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: fast-ssd
provisioner: ebs.csi.aws.com
parameters:
  type: gp3
  iops: "16000"
  throughput: "1000"

```

but that requires a Pod restart with a new EMPTY Volume attached, that causes a significant downtime. But then I discovered that I can change volume type, througput and ioops in the AWS Console

![](EKS-VolumeModification.md-images/2023-06-06-21-13-22.jpg)

To locate Volume, you need a "volumeHandle", that can be listed by the following script:

```bash
for i in $(kubectl get pvc -o name); do
    volume_name=$(kubectl get "$i" -o jsonpath='{.spec.volumeName}')
    volume_handle=$(kubectl get pv "$volume_name" -o jsonpath='{.spec.csi.volumeHandle}')
    echo "$i $volume_handle"
done
```

Then you can change IOPS and Througput for testing. 👋

