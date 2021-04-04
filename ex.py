import requests
import os

url = "http://image-net.org/data/downsample/Imagenet8_val_npz.zip"
download_path = "/home/shrey_bana/projects/datasets"


r = requests.get(url, stream=True)
size = int(r.headers.get('content-length'))
print('Status: {}'.format(r.status_code))

def print_progress(percentage):
    print('%{}'.format(percentage) + '[' + '=' * (percentage * 3 // 10) + ' ' * (30 - (percentage * 3 // 10)) + ']', end = '\r')

with open(os.path.join(download_path, url.split('/')[-1]), 'wb') as fd:
    downloaded = 0
    print_progress(int(downloaded * 100 // size))
    for chunk in r.iter_content(chunk_size = 4096): # 4kb 
        fd.write(chunk)
        downloaded += 4096
        print_progress(downloaded * 100 // size)
