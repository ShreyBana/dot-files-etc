import requests
import sys
import os

DATASETS_PATH = '/home/shrey_bana/projects/datasets/'
MB = 1024 * 1024

def print_progress(percentage):
    print('%{:.2f} '.format(percentage) + '[' + '=' * int(percentage / 10) + ' ' * (10 - int(percentage / 10)) + ']', end='\r')

for url in sys.argv[1:]:
    print('---------------------------------')
    filename = url.split('/')[-1]
    path = DATASETS_PATH + filename

    r = requests.get(url, stream=True)
    size = int(r.headers.get('content-length')) / MB

    if os.path.exists(path) and os.stat(path).st_size == size * MB:
        print('{} already exists'.format(filename))
        continue

    print('Downloading {}'.format(filename))
    print('Total Size: {:.2f} MB'.format(size))
    chunk_size = min(int(size * 0.1) * MB, int(MB)) # set to 10% of total size of the file but lower bounded by 1 MB
    with open(path, 'wb') as fd:
        downloaded = 0
        print_progress(downloaded * 100 / size)
        for chunk in r.iter_content(chunk_size=chunk_size):
            fd.write(chunk)
            downloaded += 0.1 * size
            downloaded = min(downloaded, size)
            print_progress(downloaded * 100 / size)

    print('\n')
