# SyncNet

Original repository: https://github.com/joonson/syncnet_python

## What is changed

일부 requirements 패키지 버전 수정

numpy 버전에 안맞는 코드 수정

전체 pipeline 통합한 쉘 스크립트 추가(visualize는 제외함)

상대경로 코드 수정(eval.sh를 다른 위치에서 실행해도 경로 문제가 안생기도록)

평가 수치를 json 형식으로 저장

### My Environment
	•	Kubernetes Pod 기반
	•	NVIDIA CUDA 12.5 + Ubuntu 22.04
	•	1 GPU(A100 40GB)
	•	500GB PVC
	•	SSH 접속 가능 (Secret 기반)
	•	StableAvatar 실험을 위한 단일 Persistent 쉘 환경
참고: https://sgs-docs.snucse.org/usage/run-workload-examples.html
```
# stableavatar-shell.yaml
apiVersion: v1
kind: Pod
metadata:
  name: stableavatar-shell
spec:
  restartPolicy: Never
  nodeSelector:
    node-restriction.kubernetes.io/nodegroup: undergraduate
  volumes:
    - name: data
      persistentVolumeClaim:
        claimName: stableavatar-volume
    - name: ssh-auth
      secret:
        secretName: stableavatar-ssh
        defaultMode: 0400
  containers:
    - name: app
      image: nvcr.io/nvidia/cuda:12.5.0-base-ubuntu22.04
      ports:
        - containerPort: 22
      env:
        - name: HF_HOME
          value: /data/huggingface
        - name: PIP_CACHE_DIR
          value: /data/pip_cache
        - name: TMPDIR
          value: /data/tmp
        - name: TOKENIZERS_PARALLELISM
          value: "false"
      volumeMounts:
        - name: data
          mountPath: /data
        - name: ssh-auth
          mountPath: /root/.ssh/authorized_keys
          subPath: authorized_keys
          readOnly: true
      command: ["/bin/bash", "-c", "sleep inf"]
      resources:
        limits:
          nvidia.com/gpu: 1
```

## Dependencies
```
apt install ffmpeg
pip install -r requirements.txt
sh download_model.sh
```


## Usage
Using shell script:
```
./eval.sh <video_path> <output_dir>
# json file will be saved at <output_dir>/pywork/evaluation_syncnet/syncnet_summary.json
```

Full pipeline:
```
sh download_model.sh
python run_pipeline.py --videofile /path/to/video.mp4 --reference name_of_video --data_dir /path/to/output
python run_syncnet.py --videofile /path/to/video.mp4 --reference name_of_video --data_dir /path/to/output
python run_visualise.py --videofile /path/to/video.mp4 --reference name_of_video --data_dir /path/to/output
```

Outputs:
```
$DATA_DIR/pycrop/$REFERENCE/*.avi - cropped face tracks
$DATA_DIR/pywork/$REFERENCE/offsets.txt - audio-video offset values
$DATA_DIR/pyavi/$REFERENCE/video_out.avi - output video (as shown below)
```

## Publications
 
```
@InProceedings{Chung16a,
  author       = "Chung, J.~S. and Zisserman, A.",
  title        = "Out of time: automated lip sync in the wild",
  booktitle    = "Workshop on Multi-view Lip-reading, ACCV",
  year         = "2016",
}
```
