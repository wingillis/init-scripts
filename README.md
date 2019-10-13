# init-scripts
Shell scripts used to initialize command windows.

Once vim is updated and installed, open vim and run `:CocInstall coc-python` to enable async python linting.

In order to run port-forwarding and proxy-jump to a compute node on o2, you need to add the following to `~/.ssh/config`:

```bash
Host compute*o2.rc.hms.harvard.edu
	ProxyJump ${USERNAME}@login02.o2.rc.hms.harvard.edu
	User ${USERNAME}
```


