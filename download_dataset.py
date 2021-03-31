import requests
import sys
import os

DATASETS_PATH = ''
MB = 1024 * 1024
URL_LIST = sys.argv[1:]

def print_progress(percentage):
    print('%{:.2f} '.format(percentage) + '[' + '=' * int(percentage / 10) + ' ' * (10 - int(percentage / 10)) + ']', end='\r')

for url in URL_LIST:
    print('---------------------------------')
    filename = url.split('/')[-1]
    path = DATASETS_PATH + filename

    r = requests.get(url, stream=True)
    size = int(r.headers.get('content-length')) / MB

    if os.path.exists(path) and os.stat(path).st_size == size * MB:
        print('{} already exists'.format(filename))
        continue

    print('Downloading {}'.format(filename))
    print('File Size ~ {} MB'.format(int(size)))
    chunk_size = max(int(size * 0.1), 1) * MB # set to 10% of total size of the file but lower bounded by 1 MB
    with open(path, 'wb') as fd:
        downloaded = 0
        print_progress(downloaded * 100 / size)
        for chunk in r.iter_content(chunk_size=chunk_size):
            fd.write(chunk)
            downloaded += chunk_size / MB
            downloaded = min(downloaded, size)
            print_progress(downloaded * 100 / size)

    print('\n')
