#!/usr/bin/env python
import re
import subprocess
from fabric import Connection
from bullet import colors, Bullet

username = 'wg41'

sq_cmd = f'squeue --user={username} --name=jupyter'

c = Connection(f'{username}@o2.hms.harvard.edu')
res = c.run(sq_cmd)
out = res.stdout

o2 = subprocess.run(f"echo '{out}' | tail -n +3 | awk '{{print $1}}'",
                    shell=True,
                    stdout=subprocess.PIPE)

choices = o2.stdout.decode('utf-8').split()
cli = Bullet(
    prompt='Which jupyter node do you want to connect to?',
    choices=choices,
    indent=0,
    align=5,
    bullet='•',
    bullet_color=colors.foreground['white']
)

result = cli.launch()

awk_cmd = "awk -F 'command: ' '/SSH tunnel command:/{print $2}'"
res = c.run(f'{awk_cmd} ~/jupyter_{result}.log')
out = res.stdout.split('\n')[1]

match = re.search(r'\d+:', out).group()

subprocess.run(f'open http://localhost:{match[:-1]}/lab', shell=True)
subprocess.run(out, shell=True)


