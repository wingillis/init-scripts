import os
import subprocess
from os.path import join, exists


output = subprocess.check_output(['uname', '-v'])

if 'Debian' in output:
    installer = 'apt'
else:
    installer = 'yum'

home = os.environ['HOME']
startup = join(home, 'init-scripts', 'gce-startup')

if not exists(join(home, '.bash_profile')):
    os.system('touch {}'.format(join(home, '.bash_profile')))

os.system('bash {}'.format(join(startup, 'startup_1.sh')))

with open(join(home, '.bashrc'), 'r') as f:
    bash_prof = f.readlines()

bash_prof = list(filter(lambda l: 'miniconda' in l, bash_prof))

if len(bash_prof) == 0:
    with open(join(home, '.bashrc'), 'a') as f:
        f.write('\nexport PATH=$HOME/miniconda3/bin:\\$PATH\n')
else:
    print('miniconda already added')

os.system('bash {}'.format(join(startup, 'startup_2.sh')))

os.system('sudo {} install -y zsh'.format(installer))

os.system('bash {}'.format(join(startup, 'startup_3.sh')))
