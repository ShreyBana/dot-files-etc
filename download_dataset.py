import sys
import requests
import os

url = sys.argv[1]
save_path = sys.argv[2]
MB = 1024 * 1024

r = requests.get(url, stream=True)
size = int(r.headers.get('content-length')) / MB

if os.path.exists(save_path) and os.stat(save_path).st_size == size * MB:
    print('File already exists')
    exit()

print('Downloading {}'.format(save_path.split('/')[-1]))
print('Total Size: {:.2f} MB'.format(size))

def print_progress(percentage):
    print('%{:.2f} '.format(percentage) + '[' + '=' * int(percentage / 10) + ' ' * (10 - int(percentage / 10)) + ']', end='\r')

with open(save_path, 'wb') as fd:
    downloaded = 0
    print_progress(downloaded * 100 / size)
    for chunk in r.iter_content(chunk_size=int(size * 0.1) * MB): # set to 10% of total size of the file
        fd.write(chunk)
        downloaded += 0.1 * size
        downloaded = min(downloaded, size)
        print_progress(downloaded * 100 / size)

print('\nDownload Complete')
