#!/usr/bin/env bash
set -e

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <video_path> <output_dir>"
  exit 1
fi

ROOT="/data"
REPO="$ROOT/workspace/syncnet_python"
NAME="evaluation_syncnet"
VIDEO="$1"
OUTPUT_DIR="$2"

mkdir -p $OUTPUT_DIR

python "$REPO/run_pipeline.py" --videofile $VIDEO --reference $NAME --data_dir $OUTPUT_DIR
python "$REPO/run_syncnet.py" --videofile $VIDEO --reference $NAME --data_dir $OUTPUT_DIR
# optional (visualized video)
# python "$REPO/run_visualise.py" --videofile $VIDEO --reference $NAME --data_dir $OUTPUT_DIR
