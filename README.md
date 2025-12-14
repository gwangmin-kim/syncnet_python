# SyncNet

Original repository: https://github.com/joonson/syncnet_python

## Changed from original

일부 requirements 패키지 버전 수정

numpy 버전에 안맞는 코드 수정

전체 pipeline 통합한 쉘 스크립트 추가(visualize는 제외함)

상대경로 코드 수정(eval.sh를 다른 위치에서 실행해도 경로 문제가 안생기도록)

평가 수치를 json 형식으로 저장

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
