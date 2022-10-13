export PYTHONPATH=${PWD}    # only need to run this line once
python preprocess_datasets/preprocess_ZJU-MoCap.py --data-dir /yiji/data/zju_mocap --out-dir /yiji/data/arah/zju_mocap --seqname CoreView_313
python preprocess_datasets/preprocess_ZJU-MoCap.py --data-dir /yiji/data/zju_mocap --out-dir /yiji/data/arah/zju_mocap --seqname CoreView_315
python preprocess_datasets/preprocess_ZJU-MoCap.py --data-dir /yiji/data/zju_mocap --out-dir /yiji/data/arah/zju_mocap --seqname CoreView_377
python preprocess_datasets/preprocess_ZJU-MoCap.py --data-dir /yiji/data/zju_mocap --out-dir /yiji/data/arah/zju_mocap --seqname CoreView_386